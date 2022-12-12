import 'package:easy_localization/easy_localization.dart';
import 'package:ecitykiosk/models/banner_model.dart';
import 'package:ecitykiosk/models/store_model.dart';
import 'package:ecitykiosk/screens/common/common_appBar.dart';
import 'package:ecitykiosk/screens/home/home_viewmodel.dart';
import 'package:ecitykiosk/screens/home/widgets/banner_widget.dart';
import 'package:ecitykiosk/screens/home/widgets/latest_trends.dart';
import 'package:ecitykiosk/screens/stores/recent_stores/recent_stores_Screen.dart';
import 'package:ecitykiosk/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/common_widgets.dart';
import 'widgets/recent_shop_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  initState() {
    getViewModel<HomeViewModel>(context, (HomeViewModel viewModel) {
      viewModel.getHomeDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: commonAppBar(
            title: Image.asset("assets/images/brand.png"),
            isCenter: false,
            actions: [bagIcon(context)]),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Selector<HomeViewModel, List<BannerModel>>(
                        selector: (context, provider) => provider.banners,
                        builder: (context, allBanners, child) {
                          return allBanners.isNotEmpty
                              ? Column(
                                  children: [
                                    header(context, "enjoy_the_deals_with".tr(),
                                        null, []),
                                    BannerShow(
                                      allBanner: allBanners,
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink();
                        }),
                    Selector<HomeViewModel, List<StoreData>>(
                        selector: (context, provider) => provider.allStores,
                        builder: (context, allStore, child) {
                          return allStore.isNotEmpty
                              ? Column(
                                  children: [
                                    header(context, "shops".tr(),
                                        RecentScreen.routeName, allStore),
                                    RecentShopCard(recent: allStore),
                                  ],
                                )
                              : const SizedBox.shrink();
                        }),
                    Selector<HomeViewModel, List<StoreData>>(
                        selector: (context, provider) => provider.recentStores,
                        builder: (context, recentStores, child) {
                          return recentStores.isNotEmpty
                              ? Column(
                                  children: [
                                    header(context, "recent_shops".tr(),
                                        RecentScreen.routeName, recentStores),
                                    RecentShopCard(recent: recentStores),
                                  ],
                                )
                              : const SizedBox.shrink();
                        }),
                    Selector<HomeViewModel, List<StoreData>>(
                        selector: (context, provider) => provider.trendsStores,
                        builder: (context, trendsStore, child) {
                          return trendsStore.isNotEmpty
                              ? Column(
                                  children: [
                                    header(
                                        context, "latest_shops".tr(), null, []),
                                    LatestTrendsCard(
                                        recent: context
                                            .read<HomeViewModel>()
                                            .trendsStores),
                                  ],
                                )
                              : const SizedBox.shrink();
                        }),
                  ],
                ),
              ),
              const LoadingIndicatorConsumer<HomeViewModel>()
            ],
          ),
        ),
      ),
    );
  }

  Widget header(
      BuildContext context, String text, String? routeName, List allData) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, top: 20, bottom: 20),
      margin: const EdgeInsets.only(left: 10, right: 20),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                  fontFamily: "Josefin Sans Regular",
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.black),
            ),
          ),
          if (routeName != null)
            GestureDetector(
              child: Text(
                "view_all".tr(),
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  fontFamily: "Josefin Sans",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color(0xFF717171),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, routeName,
                    arguments: {"title": text, "data": allData});
              },
            ),
        ],
      ),
    );
  }
}
