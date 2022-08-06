import 'package:ecitykiosk/models/store_model.dart';
import 'package:ecitykiosk/screens/home/home_viewmodel.dart';
import 'package:ecitykiosk/screens/stores/recent_store_details/recent_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentShopCard extends StatelessWidget {
  final List<StoreData> recent;

  const RecentShopCard({Key? key, required this.recent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemBuilder: (context, position) {
          return GestureDetector(
            onTap: () async {
              context
                  .read<HomeViewModel>()
                  .setRecentViewed(recent[position].id.toString());
              await Navigator.pushNamed(context, StoresDetails.routeName,
                  arguments: {"storeData": recent[position]});
              context.read<HomeViewModel>().getHomeDetails();
            },
            child: Card(
              elevation: 3.0,
              shadowColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: SizedBox(
                height: 200,
                width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 8, bottom: 8),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              recent[position].storeLogo!,
                              width: 160,
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Text(
                        recent[position].storeName!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: "Josefin Sans Regular",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: recent.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
