import 'package:ecitykiosk/screens/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../screens/cart/cart_screen.dart';
import 'app_colors.dart';

hideKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

IconButton backButton(BuildContext context) {
  return IconButton(
    color: Colors.transparent,
    onPressed: () => Navigator.pop(context),
    icon: const Icon(
      Icons.arrow_back_ios_sharp,
      color: Colors.black,
    ),
  );
}

void getViewModel<VIEW_MODEL extends ViewModel>(
  BuildContext context,
  void Function(VIEW_MODEL viewModel) function,
) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    final provider = Provider.of<VIEW_MODEL>(context, listen: false);
    provider.onError = () {
      errorToast(msg: provider.snackBarText!);
    };
    function.call(provider);
  });
}

Widget backButtonCircle(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: const CircleAvatar(
      radius: 18,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.arrow_back_ios_sharp,
        size: 23,
        color: Colors.black,
      ),
    ),
  );
}

Widget bagIcon(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, CartScreen.routeName),
    child: Padding(
      padding: const EdgeInsets.only(right: 15),
      child: CircleAvatar(
        backgroundColor: const Color(0xFFF4F4F4),
        radius: 20,
        child: SvgPicture.asset(
          "assets/images/cartIcon.svg",
          height: 25,
          width: 25,
        ),
      ),
    ),
  );
}

showToast({
  required String msg,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    textColor: Colors.white,
    backgroundColor: AppColors.appColor,
  );
}

errorToast({
  required String msg,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    textColor: Colors.white,
    backgroundColor: Colors.red[400],
  );
}
