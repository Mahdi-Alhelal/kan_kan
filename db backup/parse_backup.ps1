
$inputFile = "db backup/db.backup"
$outputFile = "db backup/restore_public.sql"

$content = Get-Content $inputFile

$result = @()
$inBlock = $false
$blockType = "" # "type", "func", "table", "alter"
$inCopy = $false
$copyHeader = ""
$copyTable = ""
$currentAlterBlock = @()

foreach ($line in $content) {
    # Start of blocks
    if ($line -match "^CREATE TYPE public\..* AS ENUM") {
        $inBlock = $true
        $blockType = "type"
    } elseif ($line -match "^CREATE FUNCTION public\.") {
        $inBlock = $true
        $blockType = "func"
    } elseif ($line -match "^CREATE TABLE public\.") {
        $inBlock = $true
        $blockType = "table"
    } elseif ($line -match "^ALTER TABLE ONLY public\.") {
        $inBlock = $true
        $blockType = "alter"
        $currentAlterBlock = @()
    } elseif ($line -match "^CREATE TRIGGER .* ON public\.") {
        $result += $line
        continue
    }

    if ($inBlock) {
        if ($blockType -eq "alter") {
            $currentAlterBlock += $line
        } else {
            $result += $line
        }

        # End of blocks
        if ($blockType -eq "type" -and $line -match "\);") {
            $inBlock = $false
        } elseif ($blockType -eq "func" -and $line -match "\$\$;") {
            $inBlock = $false
        } elseif ($blockType -eq "table" -and $line -match "\);") {
            $inBlock = $false
        } elseif ($blockType -eq "alter" -and $line -match ";$") {
            $inBlock = $false
            # Check if this alter block is something we want
            $alterText = $currentAlterBlock -join " "
            if ($alterText -match "ADD CONSTRAINT|ALTER COLUMN|SET DEFAULT|ADD GENERATED") {
                $result += $currentAlterBlock
            }
        }
        continue
    }

    # COPY to INSERT
    if ($line -match "COPY public\.(\w+) \((.*)\) FROM stdin;") {
        $inCopy = $true
        $copyTable = $matches[1]
        $cols = $matches[2]
        $copyHeader = "INSERT INTO public.$copyTable ($cols) VALUES ("
        continue
    }
    if ($inCopy) {
        if ($line -eq "\.") {
            $inCopy = $false
            continue
        }
        $values = $line -split "\t"
        $formattedValues = @()
        foreach ($val in $values) {
            if ($val -eq "\N") {
                $formattedValues += "NULL"
            } elseif ($val -match "^-?[0-9]+(\.[0-9]+)?$") {
                $formattedValues += $val
            } elseif ($val -eq "t") {
                $formattedValues += "true"
            } elseif ($val -eq "f") {
                $formattedValues += "false"
            } else {
                # Escape single quotes
                $escaped = $val -replace "'", "''"
                $formattedValues += "'$escaped'"
            }
        }
        $result += $copyHeader + ($formattedValues -join ", ") + ");"
        continue
    }
}

$result | Set-Content $outputFile
