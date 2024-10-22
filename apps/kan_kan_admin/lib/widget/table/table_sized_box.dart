
import 'package:flutter/material.dart';

class TableSizedBox extends StatelessWidget {
  const TableSizedBox({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.84,

      child: child,
    );
  }
}
