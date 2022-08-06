class BannerModel {
  String? id,
      title,
      banner,
      type,
      merchantId,
      locationId,
      storeId,
      status,
      addedOn,
      updateOn,
      storeLogo,
      storeName,
      bannerThumb,
      storeLogoThumb;

  BannerModel(
      {this.id,
      this.title,
      this.banner,
      this.type,
      this.merchantId,
      this.locationId,
      this.storeId,
      this.status,
      this.addedOn,
      this.updateOn,
      this.storeLogo,
      this.storeName,
      this.bannerThumb,
      this.storeLogoThumb});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    banner = json['banner'];
    type = json['type'];
    merchantId = json['merchant_id'];
    locationId = json['location_id'];
    storeId = json['store_id'];
    status = json['status'];
    addedOn = json['added_on'];
    updateOn = json['update_on'];
    storeLogo = json['store_logo'];
    storeName = json['store_name'];
    bannerThumb = json['banner_thumb'];
    storeLogoThumb = json['store_logo_thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['banner'] = banner;
    data['type'] = type;
    data['merchant_id'] = merchantId;
    data['location_id'] = locationId;
    data['store_id'] = storeId;
    data['status'] = status;
    data['added_on'] = addedOn;
    data['update_on'] = updateOn;
    data['store_logo'] = storeLogo;
    data['store_name'] = storeName;
    data['banner_thumb'] = bannerThumb;
    data['store_logo_thumb'] = storeLogoThumb;
    return data;
  }
}
