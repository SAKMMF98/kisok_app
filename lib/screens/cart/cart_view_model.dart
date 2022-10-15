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
  VoidCallback? onEmpty;
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
    checkInStock(data);
    notifyListeners();
  }

  void checkInStock(List<Item> items) {
    List<Item> allData = [];
    try {
      allData = items;
      for (int i = 0; i < items.length; i++) {
        if (!items[i].inStock) {
          removeProduct(items[i], false);
          allData.remove(items[i]);
          if (allData.isEmpty) {
            onEmpty?.call();
          }
        }
      }
    } catch (_) {}
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
        removeProduct(item, true);
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

  void removeProduct(Item item, bool showToast) async {
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
        if (showToast) {
          snackBarText = response.message;
          onSuccess?.call();
        }
      } else {
        if (showToast) {
          snackBarText = response.message;
          onError?.call();
        }
      }
      item.isLoading = false;
      notifyListeners();
    });
  }
}
