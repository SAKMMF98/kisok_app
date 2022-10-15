class StoreData {
  String? id,
      status,
      merchantId,
      storeName,
      storeLogo,
      storeCountry,
      storeState,
      storeCity,
      storeAddress,
      storeLatitude,
      storeLongitude,
      storeDescription,
      openTime,
      closeTime,
      rating,
      kioskName,
      storeLogoThumb;

  StoreData(
      {this.id,
      this.status,
      this.merchantId,
      this.storeName,
      this.storeLogo,
      this.storeCountry,
      this.storeState,
      this.storeCity,
      this.storeAddress,
      this.storeLatitude,
      this.storeLongitude,
      this.storeDescription,
      this.openTime,
      this.closeTime,
      this.rating,
      this.kioskName,
      this.storeLogoThumb});

  factory StoreData.fromJson(var json) {
    return StoreData(
      id: json['id'],
      status: json['status'],
      merchantId: json['merchant_id'],
      storeName: json['store_name'],
      storeLogo: json['store_logo'],
      storeCountry: json['store_country'],
      storeState: json['store_state'],
      storeCity: json['store_city'],
      storeAddress: json['store_address'],
      storeLatitude: json['store_latitude'],
      storeLongitude: json['store_longitude'],
      storeDescription: json['store_description'],
      openTime: json['open_time'],
      closeTime: json['close_time'],
      rating: json['rating'],
      kioskName: json['kiosk_name'],
      storeLogoThumb: json['store_logo_thumb'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['merchant_id'] = merchantId;
    data['store_name'] = storeName;
    data['store_logo'] = storeLogo;
    data['store_country'] = storeCountry;
    data['store_state'] = storeState;
    data['store_city'] = storeCity;
    data['store_address'] = storeAddress;
    data['store_latitude'] = storeLatitude;
    data['store_longitude'] = storeLongitude;
    data['store_description'] = storeDescription;
    data['open_time'] = openTime;
    data['close_time'] = closeTime;
    data['rating'] = rating;
    data['kiosk_name'] = kioskName;
    data['store_logo_thumb'] = storeLogoThumb;
    return data;
  }
}
