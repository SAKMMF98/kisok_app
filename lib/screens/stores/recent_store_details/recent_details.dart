import 'package:easy_localization/easy_localization.dart';
import 'package:ecitykiosk/models/product_model.dart';
import 'package:ecitykiosk/models/store_model.dart';
import 'package:ecitykiosk/screens/common/common_appBar.dart';
import 'package:ecitykiosk/screens/products/product_details/product_details_screen.dart';
import 'package:ecitykiosk/screens/stores/recent_store_details/stores_details_viewmodel.dart';
import 'package:ecitykiosk/utils/app_colors.dart';
import 'package:ecitykiosk/utils/common_widgets.dart';
import 'package:ecitykiosk/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoresDetails extends StatefulWidget {
  const StoresDetails({Key? key}) : super(key: key);
  static const routeName = "/details";

  @override
  State<StoresDetails> createState() => _StoresDetailsState();
}

class _StoresDetailsState extends State<StoresDetails> {
  StoreData? _storeData;

  @override
  void initState() {
    super.initState();
    getViewModel<StoreDetailsViewModel>(context, (viewModel) {
      Map map = ModalRoute.of(context)?.settings.arguments as Map;
      _storeData = map["storeData"];
      if (mounted) setState(() {});
      if (_storeData != null) {
        viewModel.getProductList(_storeData!.id!, 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String address =
        "${_storeData?.storeAddress ?? ""} ${_storeData?.storeCity ?? ""} ${_storeData?.storeCountry ?? ""}";
    return Scaffold(
      appBar: commonAppBar(
          title: Text(
            _storeData?.storeName ?? "store_name".tr(),
            style: const TextStyle(
                fontFamily: "Josefin_Sans",
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w700),
          ),
          leading: backButton(context),
          actions: [bagIcon(context)],
          isCenter: true),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 210,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: const Color(0XFFF4F4F4),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (_storeData?.storeLogo != null)
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              _storeData!.storeLogo!,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 8, top: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 20,
                              color: AppColors.appColor,
                            ),
                            Expanded(
                              child: Text(
                                address.trim().isNotEmpty
                                    ? address
                                    : "store_address".tr(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: "Josefin_Sans",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "products".tr(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Josefin_Sans"),
                ),
              ),
              Stack(
                children: [
                  Selector<StoreDetailsViewModel, List<ProductData>>(
                      selector: (context, provider) => provider.products,
                      builder: (context, products, child) {
                        return GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const ClampingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 3 / 3.5,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              ProductData _productData = products[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, ProductDetailsScreen.routeName,
                                      arguments: {
                                        "storeData": _storeData,
                                        "productData": _productData
                                      });
                                },
                                child: Card(
                                  elevation: 2.0,
                                  shadowColor: Colors.grey[200],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, top: 8),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                _productData.images.first,
                                                fit: BoxFit.fill,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 8,
                                            bottom: 8),
                                        child: Text(
                                          _productData.name ?? "",
                                          style: const TextStyle(
                                            fontFamily: "Josefin_Sans",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       left: 8, right: 8, top: 8),
                                      //   child: Row(
                                      //     children: const [
                                      //       Icon(
                                      //         Icons.location_on,
                                      //         size: 15,
                                      //         color: Color(0xFF717171),
                                      //       ),
                                      // Expanded(
                                      //   child: Text(
                                      //     "Pizza hut, Connought circle",
                                      //     maxLines: 1,
                                      //     overflow: TextOverflow.ellipsis,
                                      //     style: TextStyle(
                                      //       fontFamily: "Josefin_Sans",
                                      //       fontWeight: FontWeight.w300,
                                      //       fontSize: 12,
                                      //       color: Color(0xFF717171),
                                      //     ),
                                      //   ),
                                      // ),
                                      //     ],
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                  Selector<StoreDetailsViewModel, bool>(
                    selector: (_, StoreDetailsViewModel state) =>
                        state.isLoading,
                    builder: (_, bool isLoading, __) => isLoading
                        ? const Center(child: LoadingIndicator())
                        : context
                                .read<StoreDetailsViewModel>()
                                .products
                                .isNotEmpty
                            ? const SizedBox.shrink()
                            : Center(
                                child: Text(
                                  "no_products_found".tr(),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Josefin_Sans"),
                                ),
                              ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
