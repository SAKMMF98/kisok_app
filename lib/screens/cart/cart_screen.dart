import 'package:ecitykiosk/models/cart_model.dart';
import 'package:ecitykiosk/screens/cart/cart_view_model.dart';
import 'package:ecitykiosk/screens/common/common_appBar.dart';
import 'package:ecitykiosk/screens/payments/payment_mode/payment_mode_screen.dart';
import 'package:ecitykiosk/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../utils/common_widgets.dart';
import 'widgets/bottomSheet.dart';
import 'widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = "/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  initState() {
    getViewModel<CartViewModel>(context, (viewModel) {
      viewModel.setCartValue = null;
      viewModel.onError = () {
        viewModel.cartUpdating = false;
      };
      viewModel.getCartDetails();
      viewModel.onSuccess = () {
        showToast(msg: viewModel.snackBarText!);
      };
      viewModel.onEmpty = () {
        Navigator.pop(context);
        showToast(msg: "Cart is empty, or product out of stock");
      };
      viewModel.checkoutCall = () {
        if (viewModel.cartData != null) {
          if (!viewModel.cartUpdating) {
            Fluttertoast.cancel();
            Navigator.pushNamed(context, PaymentModeScreen.routeName);
          } else {
            errorToast(msg: "Updating Your Cart!!");
          }
        } else {
          errorToast(msg: "No Item Added In Your Cart!!");
        }
      };
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<CartViewModel, bool>(
        selector: (context, provider) => provider.isLoading,
        builder: (context, isLoading, child) {
          return Stack(
            children: [
              Scaffold(
                appBar: commonAppBar(
                    title: const Text(
                      "Shopping Bag",
                      style: TextStyle(
                          fontFamily: "Josefin_Sans",
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: Colors.black),
                    ),
                    isCenter: true,
                    leading: backButton(context)),
                bottomSheet: const BottomSheetWidgets(),
                body: Selector<CartViewModel, List<Item>>(
                    selector: (context, provider) => provider.cartItems,
                    builder: (context, items, child) {
                      return items.isNotEmpty
                          ? ListView.separated(
                              itemCount: items.length,
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 180),
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 5);
                              },
                              itemBuilder: (context, index) {
                                return CartItem(
                                  item: items[index],
                                  storeName: context
                                          .read<CartViewModel>()
                                          .cartData!
                                          .storeInfo!
                                          .storeName ??
                                      "",
                                );
                              })
                          : isLoading
                              ? const SizedBox.shrink()
                              : const Center(
                                  child: Text(
                                    "Card Is Empty",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Josefin_Sans"),
                                  ),
                                );
                    }),
              ),
              const LoadingIndicatorConsumer<CartViewModel>()
            ],
          );
        });
  }
}
