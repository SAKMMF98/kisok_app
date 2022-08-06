import 'package:ecitykiosk/data/repo/product_repo.dart';
import 'package:ecitykiosk/models/product_model.dart';
import 'package:ecitykiosk/screens/view_model.dart';

class StoreDetailsViewModel extends ViewModel {
  final _productRepo = ProductsRepo();
  int _index = 0;
  int _quantityIndex = 01;
  int _indexSize = 0;
  List<ProductData> _allProducts = [];

  //getter's'
  int get index => _index;

  int get quantityIndex => _quantityIndex;

  int get indexSize => _indexSize;

  List<ProductData> get products => _allProducts;

  //setter's'
  set updateIndex(int value) {
    _index = value;
    notifyListeners();
  }

  set updateQuantity(int value) {
    _quantityIndex = value;
    notifyListeners();
  }

  set updateIndexSize(int value) {
    _indexSize = value;
    notifyListeners();
  }

  set productsSets(List<ProductData> products) {
    _allProducts = products;
    notifyListeners();
  }

  void getProductList(String id, int page) {
    callApi(() async {
      if (page == 1) {
        _allProducts.clear();
      } else {
        isLoading = false;
      }
      List<ProductData> products =
          await _productRepo.getProductListByStore(storeId: id, page: page);
      if (products.isNotEmpty) {
        if (page == 1) {
          productsSets = products;
        } else {
          _allProducts.addAll(products);
        }
        getProductList(id, page + 1);
      }
    });
  }
}
