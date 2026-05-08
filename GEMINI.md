# Kan Kan Project Instructions

Welcome to the Kan Kan project. This is a Flutter monorepo managed with Melos, designed for a group deals platform ("Kan Kan") that facilitates importing products from China.

## Project Overview

The workspace consists of two primary applications and shared support packages:

- **Apps:**
  - `apps/kan_kan`: The consumer-facing mobile application for users to browse, join group deals, manage orders, and track deliveries.
  - `apps/kan_kan_admin`: The administrative dashboard for managing users, factories, deals, products, and system settings.
- **Packages:**
  - `packages/ui`: Shared UI components, design tokens, assets (images/fonts), and localization logic (`easy_localization`).
  - `packages/helper`: Shared utility functions and generic Dart helpers.

### Core Tech Stack

- **Framework:** Flutter (Android, iOS, Web, Desktop support)
- **Monorepo Management:** [Melos](https://melos.invertase.dev/)
- **State Management:** [Bloc / Cubit](https://pub.dev/packages/flutter_bloc)
- **Backend:** [Supabase](https://supabase.com/) (Database, Auth, Storage)
- **Dependency Injection:** [GetIt](https://pub.dev/packages/get_it)
- **Environment Config:** `flutter_dotenv` (requires `.env` files in app roots)
- **Localization:** `easy_localization` (Assets in `packages/ui/assets/translations`)
- **Payments:** Moyasar
- **Shipping:** Oto API
- **Animations:** Lottie

## Architecture & Conventions

### Directory Structure (Apps)
- `lib/setup`: Initialization logic (Supabase, GetIt, Dotenv).
- `lib/cubit`: Bloc/Cubit classes for state management.
- `lib/data`: Data repositories and direct data access logic.
- `lib/layer`: Business logic layers (abstractions for data operations).
- `lib/model`: Data models (entities).
- `lib/screens`: UI screens and navigation logic.
- `lib/widgets`: App-specific reusable widgets.
- `lib/integrations`: External service clients (e.g., Supabase, APIs).

### Development Workflow

1.  **Bootstrapping:**
    ```bash
    # Install Melos globally if not already present
    dart pub global activate melos
    # Bootstrap the workspace (links packages and runs pub get)
    melos bootstrap
    ```
2.  **Running Apps:**
    - From root using Melos (if scripts are configured) or directly from the app directory:
      ```bash
      cd apps/kan_kan
      flutter run
      ```
3.  **Localization:**
    - Shared translations are in `packages/ui/assets/translations`.
    - Always use `.tr()` for localized strings.

### Coding Standards
- **Naming:** Follow official Dart/Flutter style guides (PascalCase for classes, camelCase for variables/methods).
- **State Management:** Prefer `Cubit` for simple state and `Bloc` for complex event-driven logic.
- **DI:** Use `GetIt.I.get<T>()` to retrieve services and layers. Ensure they are registered in `lib/setup/setup.dart`.
- **UI:** Prefer using components from `packages/ui` to maintain visual consistency.

## Key Files
- `melos.yaml`: Workspace configuration.
- `apps/kan_kan/lib/setup/setup.dart`: App initialization entry point.
- `packages/ui/lib/ui.dart`: Export file for shared UI components.
- `.env`: Environment variables (Supabase URL/Key, etc.) - **Do not commit sensitive values.**

## Common Tasks

### Adding a New Shared Component
1. Create the widget in `packages/ui/lib/component/`.
2. Export it in `packages/ui/lib/ui.dart`.
3. Run `melos bootstrap` to ensure apps pick up the change.

### Adding a New Business Layer
1. Create the layer class in `lib/layer/`.
2. Register it in `lib/setup/setup.dart`.
3. Inject it into the relevant Cubits using `GetIt`.
