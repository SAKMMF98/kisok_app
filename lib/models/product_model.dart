class ProductData {
  String? id,
      merchantId,
      storeId,
      name,
      category,
      price,
      qty,
      cashToken,
      trackInventory,
      threshold,
      thresholdLimit,
      offers,
      discount,
      description,
      currency,
      currencyCode,
      status,
      rating,
      urls,
      addedOn,
      updateOn,
      storeName,
      storeLogo,
      storeCountry;
  List<String> images;

  ProductData(
      {this.id,
      this.merchantId,
      this.storeId,
      this.name,
      this.category,
      this.price,
      this.qty,
      this.cashToken,
      this.trackInventory,
      this.threshold,
      this.thresholdLimit,
      this.offers,
      this.discount,
      this.description,
      required this.images,
      this.currency,
      this.currencyCode,
      this.status,
      this.rating,
      this.urls,
      this.addedOn,
      this.updateOn,
      this.storeName,
      this.storeLogo,
      this.storeCountry});

  factory ProductData.fromJson(Map<String, dynamic> json) {
    List<String> allImages = [];
    if (json['imgs'] != null) {
      for (int i = 0; i < json['imgs'].length; i++) {
        allImages.add("${json['imgs'][i]}");
      }
    }
    return ProductData(
      id: json['id'],
      merchantId: json['merchant_id'],
      storeId: json['store_id'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
      qty: json['qty'],
      cashToken: json['cashtoken'],
      trackInventory: json['track_inventory'],
      threshold: json['threshold'],
      thresholdLimit: json['threshold_limit'],
      offers: json['offers'],
      discount: json['discount'],
      description: json['description'],
      images: allImages,
      currency: json['currency'],
      currencyCode: json['currency_code'],
      status: json['status'],
      rating: json['rating'],
      // urls: json['urls'],
      addedOn: json['added_on'],
      updateOn: json['update_on'],
      storeName: json['store_name'],
      storeLogo: json['store_logo'],
      storeCountry: json['store_country'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['merchant_id'] = merchantId;
  //   data['store_id'] = storeId;
  //   data['name'] = name;
  //   data['category'] = category;
  //   data['price'] = price;
  //   data['qty'] = qty;
  //   data['cashtoken'] = cashToken;
  //   data['track_inventory'] = trackInventory;
  //   data['threshold'] = threshold;
  //   data['threshold_limit'] = thresholdLimit;
  //   data['offers'] = offers;
  //   data['discount'] = discount;
  //   data['description'] = description;
  //   data['imgs'] = images;
  //   data['currency'] = currency;
  //   data['currency_code'] = currencyCode;
  //   data['status'] = status;
  //   data['rating'] = rating;
  //   data['urls'] = urls;
  //   data['added_on'] = addedOn;
  //   data['update_on'] = updateOn;
  //   data['store_name'] = storeName;
  //   data['store_logo'] = storeLogo;
  //   data['store_country'] = storeCountry;
  //   return data;
  // }
}
