import 'package:easy_localization/easy_localization.dart';
import 'package:ecitykiosk/models/store_model.dart';
import 'package:ecitykiosk/screens/stores/recent_store_details/recent_details.dart';
import 'package:ecitykiosk/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/common_widgets.dart';

class LatestTrendsCard extends StatelessWidget {
  final List<StoreData> recent;

  const LatestTrendsCard({Key? key, required this.recent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        children: [
          for (int position = 0; position < recent.length; position++) ...[
            Card(
              elevation: 3.0,
              shadowColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: SizedBox(
                height: 90,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 8, top: 8, bottom: 8),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            recent[position].storeLogo!,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          )),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            recent[position].storeName ?? "store_name".tr(),
                            style: const TextStyle(
                              fontFamily: "Josefin Sans Semi-Bold",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            recent[position].storeDescription ??
                                "description".tr(),
                            style: const TextStyle(
                              fontFamily: "Josefin Sans Regular",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, StoresDetails.routeName,
                                arguments: {"storeData": recent[position]}),
                            child: Text(
                              "view_details".tr(),
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                fontFamily: "Josefin Sans Bold",
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: AppColors.appColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    bagIcon(context),
                  ],
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
