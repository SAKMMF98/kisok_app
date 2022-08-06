import 'package:ecitykiosk/data/repo/home_repo.dart';
import 'package:ecitykiosk/models/store_model.dart';
import 'package:ecitykiosk/screens/view_model.dart';

import '../../models/banner_model.dart';

class HomeViewModel extends ViewModel {
  final _homeRepo = HomeRepo();
  List<StoreData> _allStores = [];
  List<StoreData> _recentStores = [];
  List<StoreData> _trendsStores = [];
  List<BannerModel> _banners = [];

  List<StoreData> get allStores => _allStores;

  List<StoreData> get recentStores => _recentStores;

  List<StoreData> get trendsStores => _trendsStores;

  List<BannerModel> get banners => _banners;

  set setAll(List<StoreData> data) {
    _allStores = data;
    notifyListeners();
  }

  set setRecent(List<StoreData> data) {
    _recentStores = data;
    notifyListeners();
  }

  set setTrends(List<StoreData> data) {
    _trendsStores = data;
    notifyListeners();
  }

  set setBanners(List<BannerModel> data) {
    _banners = data;
    notifyListeners();
  }

  void getHomeDetails() {
    _getBanners();
    _getRecentStores();
    _getStores();
    _getTrendsStores();
    // Future.delayed(Duration(seconds: 5),()=>getHomeDetails());
  }

  void _getStores() {
    callApi(() async {
      if (allStores.isNotEmpty) {
        isLoading = false;
      }
      setAll = await _homeRepo.getAllStores();
    });
  }

  void _getRecentStores() {
    callApi(() async {
      if (recentStores.isNotEmpty) {
        isLoading = false;
      }
      setRecent = await _homeRepo.getRecentStores();
    });
  }

  void _getTrendsStores() {
    callApi(() async {
      if (trendsStores.isNotEmpty) {
        isLoading = false;
      }
      setTrends = await _homeRepo.getTrendsStores();
    });
  }

  void setRecentViewed(String storeId) {
    callApi(() async {
      await _homeRepo.setRecentView(storeId);
    });
  }

  void _getBanners() {
    callApi(() async {
      if (banners.isNotEmpty) {
        isLoading = false;
      }
      setBanners = await _homeRepo.getHomeBanners();
    });
  }
}
