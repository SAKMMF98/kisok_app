import 'package:ecitykiosk/screens/cart/cart_view_model.dart';
import 'package:ecitykiosk/utils/app_colors.dart';
import 'package:ecitykiosk/utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../payments/payment_mode/payment_mode_screen.dart';

class BottomSheetWidgets extends StatelessWidget {
  const BottomSheetWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(builder: (context, provider, child) {
      // double finalAmount = 0.0;
      // if (provider.cartData != null) {
      //   if (provider.cartData!.cart != null) {
      //     if (provider.cartData!.cart!.item != null) {
      //       for (var element in provider.cartData!.cart!.item!) {
      //         finalAmount = finalAmount +
      //             (double.parse(element.price!) * int.parse(element.qty!));
      //       }
      //     }
      //   }
      // }
      return Container(
        decoration: const BoxDecoration(
          color: AppColors.appColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        height: 180,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "SubTotal",
                  style: TextStyle(
                    fontFamily: "Josefin_Sans",
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                Text(
                  "${provider.cartItems.firstOrNull()?.currencyCode ?? ""} ${provider.cartData?.cart?.totalDiscountedPrice ?? ""}",
                  style: const TextStyle(
                    fontFamily: "Josefin_Sans",
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: Color(0xFFFFFFFF),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(
                    fontFamily: "Josefin_Sans",
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                Text(
                  "${provider.cartItems.firstOrNull()?.currencyCode ?? ""} ${provider.cartData?.cart?.totalDiscountedPrice ?? ""}",
                  style: const TextStyle(
                    fontFamily: "Josefin_Sans",
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Color(0xFFFFFFFF),
                  ),
                )
              ],
            ),
            ElevatedButton(
                onPressed: () => provider.checkoutCall?.call(),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    fixedSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width, 50))),
                child: const Text(
                  "CHECKOUT",
                  style: TextStyle(
                      color: AppColors.appColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Josefin_Sans"),
                ))
          ],
        ),
      );
    });
  }
}
