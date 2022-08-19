class EndPoints {
  static const _kBaseUrl =
      "https://alphaxtech.net/ecity/index.php/api/users/kiosk/";
  static const _kBaseUrlWithKiosk =
      "https://alphaxtech.net/ecity/index.php/api/users/Kiosk/";
  static const kLoginUrl = _kBaseUrl + "kioskLogin";
  static const kAllStoreUrl = _kBaseUrl + "allstores";
  static const kRecentStoreUrl = _kBaseUrl + "recents";
  static const kTrendsStoreUrl = _kBaseUrl + "trands";
  static const kRecentStoreViewedUrl = _kBaseUrl + "storeViewed/";
  static const kHomeBannerUrl = _kBaseUrl + "bannerlist";
  static const kStoreProductUrl = _kBaseUrl + "storeProducts/";
  static const kStoreProductDetailsUrl = _kBaseUrl + "detail/";
  static const kAddToCartUrl = _kBaseUrl + "addtocart";
  static const kRemoveFromCartUrl = _kBaseUrl + "removeItem/";
  static const kEmptyCartUrl = _kBaseUrl + "emptyCard";
  static const kGetCartUrl = _kBaseUrl + "mycart";
  static const kOrderUrl = _kBaseUrlWithKiosk + "confirm";
  static const kWalletOrderUrl = _kBaseUrlWithKiosk + "confirmWithWallet";
  static const kCheckPaymentUrl = _kBaseUrl + "checkPayment";
  static const kCheckUser = _kBaseUrl + "checkuserid";
  static const kUserPinMatchUrl = _kBaseUrl + "afterpin";
  static const kInvoicePageUrl = _kBaseUrl + "invoicedetails";
}
