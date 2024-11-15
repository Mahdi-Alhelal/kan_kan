import 'package:flutter/material.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';

void customBottomSheet(
    {required BuildContext context,
    required Widget child,
    double? height = 0.9}) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets / 4,
        child: Container(
          height: context.getHeight(value: height!),
          decoration: BoxDecoration(
              color: AppColor.white, borderRadius: BorderRadius.circular(12)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    var f = FocusScope.of(context);

                    if (!f.hasPrimaryFocus) {
                      f.unfocus();
                    }
                  },
                  child: child)),
        ),
      );
    },
  );
}
