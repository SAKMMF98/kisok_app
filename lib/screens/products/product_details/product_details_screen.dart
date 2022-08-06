import 'package:ecitykiosk/data/repo/cart_repo.dart';
import 'package:ecitykiosk/models/product_details_model.dart';
import 'package:ecitykiosk/models/product_model.dart';
import 'package:ecitykiosk/models/store_model.dart';
import 'package:ecitykiosk/screens/cart/cart_screen.dart';
import 'package:ecitykiosk/screens/cart/cart_view_model.dart';
import 'package:ecitykiosk/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  @override
  initState() {
    getViewModel<ProductDetailsViewModel>(context,
        (ProductDetailsViewModel viewModel) {
      viewModel.onCartSuccess = () {
        showToast(msg: viewModel.snackBarText!);
        Navigator.pushNamed(context, CartScreen.routeName).onError((ad, d) {});
      };
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context)?.settings.arguments as Map;
    StoreData _storeData = map["storeData"];
    ProductData _productData = map["productData"];
    getViewModel<ProductDetailsViewModel>(context,
        (ProductDetailsViewModel viewModel) {
      viewModel.setDetails = null;
      viewModel.getProductDetails(_productData.id.toString());
    });
    return SafeArea(
      child: Scaffold(
        bottomSheet: const Details(),
        body: BackdropImage(
          productsImages: _productData.images,
        ),
      ),
    );
  }
}
