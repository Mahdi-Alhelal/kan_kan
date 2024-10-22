import 'package:flutter/material.dart';

class FactoryStatus extends StatelessWidget {
  const FactoryStatus({
    super.key,
    required this.status,
  });
  final String status;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .07,
        height: MediaQuery.of(context).size.height * .05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: statusColors(status: status),
          ),
        ),
        child: Center(
          child: Text(
            style: TextStyle(
                color: statusColors(status: status),
                fontWeight: FontWeight.bold),
            status,
          ),
        ),
      ),
    );
  }

  Color statusColors({required String status}) {
    switch (status) {
      case "نشط":
        return Color(0xff0CAF60);

      case "غير نشط":
        return Colors.red;

      case "قيد المراجعة":
        return Colors.orange;

      default:
        return Colors.white;
    }
  }
}
