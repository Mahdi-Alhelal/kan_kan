import 'package:flutter/material.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';

void customBottomSheet({
  required BuildContext context,
  required Widget child,
}) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: context.getHeight(value: 0.75),
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(12)),
        child: Padding(padding: const EdgeInsets.all(8.0), child: child),
      );
    },
  );
}
