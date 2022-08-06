import 'dart:developer';

import 'package:ecitykiosk/data/remote/response.dart';
import 'package:ecitykiosk/data/repo/cart_repo.dart';
import 'package:ecitykiosk/data/repo/product_repo.dart';
import 'package:ecitykiosk/models/cart_model.dart';
import 'package:ecitykiosk/models/product_details_model.dart';
import 'package:ecitykiosk/screens/view_model.dart';
import 'package:flutter/material.dart';

class ProductDetailsViewModel extends ViewModel {
  final _productRepo = ProductsRepo();
  final _cartRepo = CartRepo();
  int _index = 0;
  int _quantityIndex = 01;
  List<ProductColors>? _productColors;
  ProductSizes? _selectedSize;
  ProductColors? _selectedColor;
  ProductDetailsModel? _productDetailsModel;

  int get index => _index;

  set updateIndex(int value) {
    _index = value;
    notifyListeners();
  }

  int get quantityIndex => _quantityIndex;

  ProductSizes? get selectedSize => _selectedSize;

  ProductColors? get selectedColor => _selectedColor;

  List<ProductColors>? get productColors => _productColors;

  ProductDetailsModel? get productDetails => _productDetailsModel;

  VoidCallback? onCartSuccess;

  set updateQuantity(int value) {
    if (value != 0) {
      _quantityIndex = value;
      notifyListeners();
    }
  }

  set setDetails(ProductDetailsModel? value) {
    _productDetailsModel = value;
    notifyListeners();
  }

  set setProductColors(List<ProductColors>? value) {
    _productColors = value;
    notifyListeners();
  }

  void updateIndexSize(ProductSizes value) {
    _selectedSize = value;
    _selectedColor = null;
    setProductColors = value.colors;
    notifyListeners();
  }

  set updateColor(ProductColors value) {
    _selectedColor = value;
    notifyListeners();
  }

  void getProductDetails(String id) {
    callApi(() async {
      setDetails = await _productRepo.getDetails(storeId: id);
      if (productDetails != null) {
        if (productDetails!.variants != null) {
          setProductColors = productDetails!.variants!.productColors;
        }
      }
    });
  }

  void emptyCart() async {
    callApi(() async {
      Response response = await _cartRepo.emptyCart();
      isLoading = false;
      if (response.isSuccessFul) {
        addToCart("", () {}, true);
      } else {
        snackBarText = response.message;
        onError?.call();
      }
    });
  }

  void addToCart(String storeId, VoidCallback? onPopUp, bool isChecked) {
    callApi(() async {
      if (!isChecked) {
        CartData? cartData = await _cartRepo.getCartDetail();
        if (cartData != null) {
          if (cartData.storeInfo != null) {
            if (cartData.storeInfo!.id != storeId) {
              onPopUp?.call();
            } else {
              addToCart(storeId, onPopUp, true);
            }
          } else {
            addToCart(storeId, onPopUp, true);
          }
        } else {
          addToCart(storeId, onPopUp, true);
        }
      } else {
        if (productDetails!.variants == null) {
          Map<String, dynamic> body = {
            "product_id": productDetails!.id.toString(),
            "quantity": "+$_quantityIndex",
            "action": "1",
            "selected_color": "${selectedColor?.id}",
            "selected_size": "${selectedSize?.id}"
          };
          var data = await _cartRepo.addToCart(body);
          if (data.isSuccessFul) {
            snackBarText = data.message;
            onCartSuccess?.call();
          } else {
            snackBarText = data.message;
            onError?.call();
          }
        } else if (productDetails!.variants!.productSizes != null &&
            selectedSize == null) {
          snackBarText = "Please Select Size First.";
          onError?.call();
          // allTranslations.text("select_size_message");
        } else if (productColors != null && selectedColor == null) {
          snackBarText = "Please Select Color First.";
          onError?.call();
          // allTranslations.text("select_color_message");
        } else {
          Map<String, dynamic> body = {
            "product_id": productDetails!.id.toString(),
            "quantity": "+$_quantityIndex",
            "action": "1",
            "selected_color": selectedColor?.id.toString(),
            "selected_size": selectedSize?.id.toString()
          };
          var data = await _cartRepo.addToCart(body);
          if (data.isSuccessFul) {
            snackBarText = data.message;
            onCartSuccess?.call();
          } else {
            snackBarText = data.message;
            onError?.call();
          }
        }
      }
    });
  }
}
