import 'package:flutter/material.dart';
import 'package:helper/helper.dart';
import 'package:kan_kan/model/deal_model.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';

class DealCard extends StatelessWidget {
  const DealCard(
      {super.key,
      required this.onTap,
      required this.dealData,
      required this.orderBooked,
      required this.orderMax,
      required this.title});
  final DealModel dealData;
  final String title;
  final int orderBooked;
  final int orderMax;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    DateTime endDate = DateTime.parse(dealData.endDate);
    String languageCode = Localizations.localeOf(context).languageCode;
    DealEnums dealStatus =
        EnumDealsHelper.stringToDealStatus(dealData.dealStatus);
    String localizedDealStatus =
        LocalizedDealsEnums.getDealsStatusName(dealStatus, languageCode);
    Widget daysInterval =
        DateConverter.differenceInDays(endDate: endDate.toString());
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
              child: dealData.dealUrl != ""
                  ? Image.network(
                      dealData.dealUrl,
                      width: context.getWidth(value: 0.4),
                      height: context.getHeight(value: 0.2),
                    )
                  : Image.asset(
                      "assets/images/logo/kan_kan_logo.png",
                      width: 300,
                    )),
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
                          title,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primary),
                        ),
                        const Spacer(),
                        dealData.dealStatus != "active"
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 2),
                                decoration: BoxDecoration(
                                  color: getEnumColor(dealStatus),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  localizedDealStatus,
                                  style: const TextStyle(color: AppColor.white),
                                ),
                              )
                            : daysInterval
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
                  value: orderBooked / orderMax,
                  backgroundColor: AppColor.bg,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColor.primary),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '$orderBooked / $orderMax ',
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
