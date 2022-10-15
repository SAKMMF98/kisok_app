import 'package:ecitykiosk/models/product_details_model.dart';
import 'package:ecitykiosk/screens/products/product_details/product_details_viewmodel.dart';
import 'package:ecitykiosk/utils/app_colors.dart';
import 'package:ecitykiosk/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  // final ProductDetailsViewModel? productDetailsViewModel;

  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.60 - 10,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
                offset: Offset(-4, -9), color: Colors.black, blurRadius: 80),
            BoxShadow(
                offset: Offset(-2, -9), color: Colors.black, blurRadius: 80),
          ],
        ),
        child: Consumer<ProductDetailsViewModel>(
            builder: (context, provider, child) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: provider.isLoading
                ? Stack(
                    children: const [
                      LoadingIndicatorConsumer<ProductDetailsViewModel>(),
                    ],
                  )
                : provider.productDetails != null
                    ? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.only(left: 15, right: 10),
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            priceShow(provider.productDetails!),
                            const SizedBox(height: 20),
                            const Text(
                              "Store Name",
                              style: TextStyle(
                                  fontFamily: "Josefin_Sans",
                                  color: Color(0xFF717171),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              provider.productDetails?.name ?? "",
                              style: const TextStyle(
                                  fontFamily: "Josefin_Sans",
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              provider.productDetails?.description ?? "",
                              style: const TextStyle(
                                  fontFamily: "Josefin_Sans",
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(height: 20),
                            if (provider.productDetails?.variants != null)
                              if (provider
                                      .productDetails?.variants!.productSizes !=
                                  null)
                                showVariant(provider.productDetails!, context),
                            ...showQuantity(context),
                            ...addToCart(provider.productDetails!, context)
                          ],
                        ),
                      )
                    : const Center(
                        child: Text(
                          "No Details Found",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Josefin_Sans"),
                        ),
                      ),
          );
        }));
  }

  Widget showVariant(ProductDetailsModel details, BuildContext context) {
    ProductDetailsViewModel provider = context.read<ProductDetailsViewModel>();
    List<ProductSizes> productSizes = details.variants!.productSizes!;
    return Selector<ProductDetailsViewModel, ProductSizes?>(
        builder: (context, selectedSize, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Available size",
                style: TextStyle(
                    fontFamily: "Josefin_Sans",
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  for (int i = 0; i < productSizes.length; i++)
                    Padding(
                      padding: EdgeInsets.only(left: i == 0 ? 0.0 : 10),
                      child: GestureDetector(
                        onTap: () {
                          provider.updateIndexSize(productSizes[i]);
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              provider.selectedSize == productSizes[i]
                                  ? AppColors.appColor
                                  : const Color(0xFFF4F4F4),
                          child: Text(
                            productSizes[i].optionName ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              color: provider.selectedSize == productSizes[i]
                                  ? Colors.white
                                  : Colors.black,
                              fontFamily: "Josefin_Sans",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              if (provider.productColors != null) ...[
                const Text(
                  "Available color",
                  style: TextStyle(
                      fontFamily: "Josefin_Sans",
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                Selector<ProductDetailsViewModel, ProductColors?>(
                    builder: (context, value, child) {
                      return Row(
                        children: [
                          for (int i = 0;
                              i < provider.productColors!.length;
                              i++)
                            Padding(
                              padding: EdgeInsets.only(left: i == 0 ? 0.0 : 10),
                              child: GestureDetector(
                                onTap: () {
                                  provider.updateColor =
                                      provider.productColors![i];
                                },
                                child: CircleAvatar(
                                    radius: 19,
                                    backgroundColor: provider.selectedColor ==
                                            provider.productColors![i]
                                        ? AppColors.appColor
                                        : Colors.transparent,
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Color(int.parse(provider
                                          .productColors![i].optionValue!
                                          .replaceAll("#", "0xFF"))),
                                    )),
                              ),
                            ),
                        ],
                      );
                    },
                    selector: (context, provider) => provider.selectedColor),
                const SizedBox(height: 20),
              ]
            ],
          );
        },
        selector: (context, provider) => provider.selectedSize);
  }

  Widget priceShow(ProductDetailsModel details) {
    if (details.offers == 'null') {
      return Text(
        "${details.currencyCode ?? ""} ${details.price}",
        style: const TextStyle(
          fontSize: 26,
          fontFamily: "Josefin_Sans",
          fontWeight: FontWeight.w600,
          color: AppColors.appColor,
        ),
      );
    } else {
      bool discountShow = false;
      try {
        double price = double.parse(
            details.price!.replaceAll(".", "").replaceAll(",", ""));
        double discount = double.parse(
            details.offerPrice!.replaceAll(".", "").replaceAll(",", ""));
        if (discount == 0.00) {
          discountShow = false;
        } else {
          discountShow = price != discount;
        }
      } catch (_) {
        discountShow = false;
      }
      if (details.offers.toString() != "[]") {
        // try {
        //   double price = double.parse(
        //       details.price!.replaceAll(".", "").replaceAll(",", ""));
        //   double discount = double.parse(
        //       details.offerPrice!.replaceAll(".", "").replaceAll(",", ""));
        //   discountShow = price == discount;
        // } catch (_) {
        //   discountShow = false;
        // }
        return RichText(
          text: TextSpan(
              children: [
                TextSpan(
                  text: discountShow
                      ? "  ${details.currencyCode ?? ""} ${details.price}"
                      : "",
                  style: const TextStyle(
                      fontFamily: "Josefin_Sans",
                      decoration: TextDecoration.lineThrough,
                      fontSize: 12,
                      color: Color(0xFF717171),
                      fontWeight: FontWeight.w300),
                )
              ],
              style: const TextStyle(
                fontSize: 26,
                fontFamily: "Josefin_Sans",
                fontWeight: FontWeight.w600,
                color: AppColors.appColor,
              ),
              text: "${details.currencyCode ?? ""} ${details.offerPrice}"),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        );
      } else if (discountShow) {
        return RichText(
          text: TextSpan(
              children: [
                TextSpan(
                  text: discountShow
                      ? "  ${details.currencyCode ?? ""} ${details.price}"
                      : "",
                  style: const TextStyle(
                      fontFamily: "Josefin_Sans",
                      decoration: TextDecoration.lineThrough,
                      fontSize: 12,
                      color: Color(0xFF717171),
                      fontWeight: FontWeight.w300),
                )
              ],
              style: const TextStyle(
                fontSize: 26,
                fontFamily: "Josefin_Sans",
                fontWeight: FontWeight.w600,
                color: AppColors.appColor,
              ),
              text: "${details.currencyCode ?? ""} ${details.offerPrice}"),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        );
      } else {
        return Text(
          "${details.currencyCode ?? ""} ${details.price}",
          style: const TextStyle(
            fontSize: 26,
            fontFamily: "Josefin_Sans",
            fontWeight: FontWeight.w600,
            color: AppColors.appColor,
          ),
        );
      }
    }
  }

  List<Widget> showQuantity(BuildContext context) {
    return [
      const Text(
        "Quantity",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: "Josefin_Slab"),
      ),
      Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
            color: const Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(20)),
        child: Selector<ProductDetailsViewModel, int>(
          selector: (s, provider) => provider.quantityIndex,
          builder: (context, quantity, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => context
                      .read<ProductDetailsViewModel>()
                      .updateQuantity = quantity - 1,
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Text(
                      "-",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Josefin_Slab"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    "${quantity.toString().length == 1 ? "0$quantity" : quantity}",
                    style: const TextStyle(
                        color: Color(0xFF717171),
                        fontFamily: "Josefin_Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                  ),
                ),
                GestureDetector(
                  onTap: () => context
                      .read<ProductDetailsViewModel>()
                      .updateQuantity = quantity + 1,
                  child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Text(
                        "+",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Josefin_Slab"),
                      )),
                )
              ],
            );
          },
        ),
      ),
      const SizedBox(height: 20),
    ];
  }

  List<Widget> addToCart(ProductDetailsModel details, BuildContext context) {
    return [
      ElevatedButton(
        onPressed: () => context
            .read<ProductDetailsViewModel>()
            .addToCart(details.storeId.toString(), () async {
          final result = await showPopUp(context);
          if (result) {
            context.read<ProductDetailsViewModel>().emptyCart();
          }
        }, false),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.appColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
            minimumSize: MaterialStateProperty.all<Size>(
                Size(MediaQuery.of(context).size.width, 50))),
        child: const Text(
          "ADD TO CART",
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontFamily: "Josefin_Sans"),
        ),
      ),
      const SizedBox(height: 10),
    ];
  }

  Future<bool> showPopUp(context) async {
    return await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Are You Sure",
          ),
          content: const Text(
            "Already Add A Product From Another Store, You Want To Add This Product In Cart",
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(color: AppColors.appColor),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(color: AppColors.appColor),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            )
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        );
      },
    );
  }
}
