import 'package:ecitykiosk/data/repo/cart_repo.dart';
import 'package:ecitykiosk/models/cart_model.dart';
import 'package:ecitykiosk/screens/view_model.dart';
import 'package:ecitykiosk/utils/common_functions.dart';
import 'package:flutter/material.dart';

class CartViewModel extends ViewModel {
  final _cartRepo = CartRepo();

  bool _cartUpdating = false;

  CartData? cartData;

  List<Item> _cartItems = [];

  List<Item> get cartItems => _cartItems;

  bool get cartUpdating => _cartUpdating;

  VoidCallback? onSuccess;
  VoidCallback? checkoutCall;

  set setCartValue(CartData? data) {
    cartData = data;
    if (cartData != null) {
      if (cartData!.cart != null) {
        setCartItems = cartData!.cart!.item ?? [];
      }
    } else {
      setCartItems = [];
    }
    notifyListeners();
  }

  set cartUpdating(bool value) {
    _cartUpdating = value;
    notifyListeners();
  }

  set setCartItems(List<Item> data) {
    _cartItems = data;
    notifyListeners();
  }

  void getCartDetails() {
    callApi(() async {
      cartUpdating = true;
      setCartValue = await _cartRepo.getCartDetail();
      cartUpdating = false;
    });
  }

  void updateQuantity({required Item item, required bool increase}) {
    if (item.isLoading) return;
    callApi(() async {
      isLoading = false;
      cartUpdating = true;
      notifyListeners();
      if (!increase && (int.parse(item.qty!) - 1) == 0) {
        removeProduct(item);
      } else {
        item.isLoading = true;
        notifyListeners();
        Map<String, dynamic> body = {
          "product_id": item.productId!,
          "quantity": "${increase ? "+" : "-"}1",
          "action": "",
          "selected_color": "${item.selectedColor?.firstOrNull()?.id}",
          "selected_size": "${item.selectedSize?.firstOrNull()?.id}"
        };
        var data = await _cartRepo.addToCart(body);
        cartUpdating = false;
        if (data.isSuccessFul) {
          snackBarText = data.message;
          getCartDetails();
        } else {
          snackBarText = data.message;
          onError?.call();
        }
        item.isLoading = false;
        notifyListeners();
      }
    });
  }

  void removeProduct(Item item) async {
    if (item.isLoading) return;
    callApi(() async {
      isLoading = false;
      cartUpdating = true;
      item.isLoading = true;
      notifyListeners();
      var response = await _cartRepo.removeFromCart(item.cartId!);
      cartUpdating = false;
      if (response.isSuccessFul) {
        getCartDetails();
        snackBarText = response.message;
        onSuccess?.call();
      } else {
        snackBarText = response.message;
        onError?.call();
      }
      item.isLoading = false;
      notifyListeners();
    });
  }
}
