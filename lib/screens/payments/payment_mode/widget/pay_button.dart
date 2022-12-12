import 'package:easy_localization/easy_localization.dart';
import 'package:ecitykiosk/models/cart_model.dart';
import 'package:ecitykiosk/screens/cart/cart_view_model.dart';
import 'package:ecitykiosk/screens/payments/payment_mode/payment_mode_view_model.dart';
import 'package:ecitykiosk/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PayButton extends StatelessWidget {
  const PayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartData? cartData = context.read<CartViewModel>().cartData;
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03,
          bottom: 15),
      child: ElevatedButton(
        onPressed: () =>
            Provider.of<PaymentModeViewModel>(context, listen: false)
                .payNow(cartData!),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.appColor),
            fixedSize: MaterialStateProperty.all<Size>(
                Size(MediaQuery.of(context).size.width, 60))),
        child: Text(
          "pay_now".tr(),
          style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: "Josefin_Sans"),
        ),
      ),
    );
  }
}
