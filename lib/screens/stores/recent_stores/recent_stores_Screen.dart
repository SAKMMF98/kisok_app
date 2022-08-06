import 'package:ecitykiosk/models/store_model.dart';
import 'package:ecitykiosk/screens/common/common_appBar.dart';
import 'package:ecitykiosk/screens/home/home_viewmodel.dart';
import 'package:ecitykiosk/screens/stores/recent_store_details/recent_details.dart';
import 'package:ecitykiosk/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({Key? key}) : super(key: key);
  static const String routeName = "/recentStore";

  @override
  Widget build(BuildContext context) {
    Map previousData = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: commonAppBar(
        title: Text(
          previousData['title'],
          style: const TextStyle(
            fontFamily: "Josefin_Sans",
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: backButton(context),
        isCenter: true,
        actions: [bagIcon(context)],
      ),
      body: GridView.builder(
          padding: const EdgeInsets.only(left: 10, right: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // childAspectRatio: 3 / 2,
              childAspectRatio: 3 / 3.5,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemCount: previousData['data'].length,
          itemBuilder: (context, index) {
            StoreData storeData = previousData['data'][index];
            return GestureDetector(
              onTap: () async {
                context
                    .read<HomeViewModel>()
                    .setRecentViewed(storeData.id.toString());
                await Navigator.pushNamed(context, StoresDetails.routeName,
                    arguments: {"storeData": storeData});
                context.read<HomeViewModel>().getHomeDetails();
              },
              child: Card(
                elevation: 2.0,
                shadowColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              storeData.storeLogoThumb ?? "",
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.5,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: Text(
                        storeData.storeName ?? "Store Name",
                        style: const TextStyle(
                          fontFamily: "Josefin_Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.location_on,
                            size: 15,
                            color: Color(0xFF717171),
                          ),
                          Expanded(
                            child: Text(
                              "Pizza hut, Connought circle",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "Josefin_Sans",
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                                color: Color(0xFF717171),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
