import 'package:flutter/material.dart';
import 'package:kan_kan/model/deal_model.dart';
import 'package:ui/ui.dart';
import 'package:helper/helper.dart';

class DealCard extends StatelessWidget {
  const DealCard({super.key, required this.onTap, required this.dealData});
  final DealModel dealData;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.parse(dealData.endDate);

    int daysInterval =
        DateConverter.differenceInDays(endDate: endDate, startDate: startDate);
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child:
                  Image.asset("assets/images/products-sample/tv-sample.png")),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          dealData.dealTitle,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primary),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${daysInterval} يوم/أيام',
                                style: const TextStyle(color: AppColor.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${dealData.salePrice} ريال',
                      style: const TextStyle(
                        fontSize: 20,
                        color: AppColor.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: dealData.numberOfOrder / dealData.quantity,
                  backgroundColor: AppColor.bg,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColor.primary),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${dealData.numberOfOrder} / ${dealData.quantity} ',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'تفاصيل الصفقة',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
