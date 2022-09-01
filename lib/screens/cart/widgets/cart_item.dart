import 'package:ecitykiosk/models/cart_model.dart';
import 'package:ecitykiosk/screens/cart/cart_view_model.dart';
import 'package:ecitykiosk/utils/app_colors.dart';
import 'package:ecitykiosk/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final Item item;
  final String storeName;

  const CartItem({Key? key, required this.item, required this.storeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<CartViewModel>();
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      item.imgs!.first,
                      fit: BoxFit.cover,
                      height: 105,
                      width: 80,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        item.offferPrice != null &&
                                item.offferPrice != "" &&
                                item.offferPrice != "0"
                            ? RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "  ${item.currencyCode ?? ""} ${item.price}",
                                        style: const TextStyle(
                                            fontFamily: "Josefin_Sans",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Colors.black),
                                      )
                                    ],
                                    style: const TextStyle(
                                        fontFamily: "Josefin_Sans",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black),
                                    text:
                                        "${item.currencyCode ?? ""} ${item.offferPrice}"),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Text(
                                "${item.currencyCode ?? ""} ${item.price ?? ""}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: "Josefin_Sans",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                        Text(
                          storeName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: "Josefin_Sans",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF717171)),
                        ),
                        Text(
                          item.name ?? "Product Name",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: "Josefin_Sans",
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        Consumer<CartViewModel>(
                            builder: (context, provider, child) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Qty",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF717171)),
                              ),
                              Container(
                                padding: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF4F4F4),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => context
                                          .read<CartViewModel>()
                                          .updateQuantity(
                                              item: item, increase: false),
                                      child: const CircleAvatar(
                                        radius: 10,
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
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Text(
                                        "${item.qty.toString().length == 1 ? "0${item.qty}" : item.qty}",
                                        style: const TextStyle(
                                            color: Color(0xFF717171),
                                            fontFamily: "Josefin_Sans",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => context
                                          .read<CartViewModel>()
                                          .updateQuantity(
                                              item: item, increase: true),
                                      child: const CircleAvatar(
                                          radius: 10,
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
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      context
                                          .read<CartViewModel>()
                                          .removeProduct(item);
                                    },
                                    child: const Icon(
                                      Icons.cancel,
                                      size: 28,
                                      color: AppColors.appColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          if (item.isLoading)
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: const LoadingIndicator(),
              alignment: Alignment.center,
            )
        ],
      ),
    );
  }

  Widget priceShow(Item details) {
    if (details.offers.toString() == 'null') {
      return Text(
        "${details.currencyCode ?? ""} ${details.price}",
        style: const TextStyle(
            fontFamily: "Josefin_Sans",
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black),
      );
    } else {
      bool discountShow = false;
      try {
        double price = double.parse(
            details.price!.replaceAll(".", "").replaceAll(",", ""));
        double discount = double.parse(
            details.offferPrice!.replaceAll(".", "").replaceAll(",", ""));
        if (discount == 0.00) {
          discountShow = false;
        } else {
          if (double.parse(discount.toString()) ==
              double.parse(price.toString())) {
            discountShow = false;
          } else {
            discountShow = price != discount;
          }
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
                      ? "  ${details.currencyCode ?? ""} ${details.offferPrice}"
                      : "",
                  style: const TextStyle(
                      fontFamily: "Josefin_Sans",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black),
                )
              ],
              style: const TextStyle(
                fontSize: 16,
                fontFamily: "Josefin_Sans",
                fontWeight: FontWeight.w600,
                color: AppColors.appColor,
              ),
              text: "${details.currencyCode ?? ""} ${details.price}"),
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
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black),
                )
              ],
              style: const TextStyle(
                fontSize: 16,
                fontFamily: "Josefin_Sans",
                fontWeight: FontWeight.w600,
                color: AppColors.appColor,
              ),
              text: "${details.currencyCode ?? ""} ${details.offferPrice}"),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        );
      } else {
        return Text(
          "${details.currencyCode ?? ""} ${details.price}",
          style: const TextStyle(
            fontSize: 16,
            fontFamily: "Josefin_Sans",
            fontWeight: FontWeight.w600,
            color: AppColors.appColor,
          ),
        );
      }
    }
  }

// String getColorAndSizeText(Item item) {
//   if (item.selectedSize!=null&&item.selectedColor!=null) {
//     if(item.selectedSize!.isNotEmpty&&item.selectedColor!.isNotEmpty){
//       return "Size:- ${item.selectedSize!.first.optionName??""} Color:- ${item.selectedColor!.first.optionName??""}";
//     }
//     else if(){}else{
//
//   }
//   } else if () {} else if () {} else {}
// }
}
