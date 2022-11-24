import 'package:ecitykiosk/models/product_model.dart';
import 'package:ecitykiosk/screens/cart/cart_screen.dart';
import 'package:ecitykiosk/utils/common_widgets.dart';
import 'package:flutter/material.dart';

import 'backdrop_image.dart';
import 'details_card.dart';
import 'product_details_viewmodel.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/product_details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductData? _productData;

  @override
  initState() {
    getViewModel<ProductDetailsViewModel>(context,
        (ProductDetailsViewModel viewModel) {
      Map map = ModalRoute.of(context)?.settings.arguments as Map;
      _productData = map["productData"];
      if (mounted) setState(() {});
      viewModel.setDetails = null;
      if (_productData != null) {
        viewModel.getProductDetails(_productData!.id.toString());
      }
      viewModel.onCartSuccess = () {
        showToast(msg: viewModel.snackBarText!);
        Navigator.pushNamed(context, CartScreen.routeName);
      };
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: const Details(),
        body: BackdropImage(
          productsImages: _productData?.images ?? [],
        ),
      ),
    );
  }
}
