class ProductDetailsModel {
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
      isFavourite,
      cartTotalItems,
      thresholdLimit,
      discount,
      campaignStatus,
      description,
      updateOn,
      currency,
      currencyCode,
      status,
      rating,
      addedOn,
      offerPrice,
      offerUnit,
      link;

  var offers;
  List<String>? imgs;

  // List<Null>? urls;
  List<String>? imgsThumb;
  int? offerPriceWithoutFormat;
  List? applyedOffer;
  Variants? variants;

  ProductDetailsModel(
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
      this.campaignStatus,
      this.thresholdLimit,
      this.offers,
      this.discount,
      this.description,
      this.imgs,
      this.currency,
      this.currencyCode,
      this.status,
      this.rating,
      // this.urls,
      this.addedOn,
      this.updateOn,
      this.isFavourite,
      this.cartTotalItems,
      this.imgsThumb,
      this.link,
      this.offerPriceWithoutFormat,
      this.offerPrice,
      this.offerUnit,
      this.applyedOffer,
      this.variants});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantId = json['merchant_id'];
    storeId = json['store_id'];
    name = json['name'];
    category = json['category'];
    price = json['price'];
    qty = json['qty'];
    cashToken = json['cashtoken'];
    trackInventory = json['track_inventory'];
    threshold = json['threshold'];
    thresholdLimit = json['threshold_limit'];
    discount = json['discount'];
    description = json['description'];
    imgs = json['imgs'].cast<String>();
    currency = json['currency'];
    currencyCode = json['currency_code'];
    status = json['status'];
    rating = json['rating'];
    addedOn = json['added_on'];
    updateOn = json['update_on'];
    isFavourite = json['is_favourite'];
    cartTotalItems = json['cart_total_items'];
    imgsThumb = json['imgs_thumb'].cast<String>();
    link = json['link'];
    offers = json['offers'];
    offerPriceWithoutFormat = json['offfer_price_without_format'];
    offerPrice = json['offfer_price'];
    offerUnit = json['offerUnit'];
    variants = json['variants'] != null && json['variants'].isNotEmpty
        ? Variants.fromJson(json['variants'])
        : null;
    campaignStatus = json["campaign_status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['merchant_id'] = merchantId;
    data['store_id'] = storeId;
    data['name'] = name;
    data['category'] = category;
    data['price'] = price;
    data['qty'] = qty;
    data['cashtoken'] = cashToken;
    data['track_inventory'] = trackInventory;
    data['threshold'] = threshold;
    data['threshold_limit'] = thresholdLimit;
    data['offers'] = offers;
    data['discount'] = discount;
    data['description'] = description;
    data['imgs'] = imgs;
    data['currency'] = currency;
    data['currency_code'] = currencyCode;
    data['status'] = status;
    data['rating'] = rating;
    data['added_on'] = addedOn;
    data['update_on'] = updateOn;
    data['is_favourite'] = isFavourite;
    data['cart_total_items'] = cartTotalItems;
    data['imgs_thumb'] = imgsThumb;
    data['link'] = link;
    data['offfer_price_without_format'] = offerPriceWithoutFormat;
    data['offfer_price'] = offerPrice;
    data['offerUnit'] = offerUnit;
    if (variants != null) {
      data['variants'] = variants!.toJson();
    }
    return data;
  }
}

class Variants {
  List<ProductSizes>? productSizes;
  List<ProductColors>? productColors;

  Variants({this.productSizes, this.productColors});

  Variants.fromJson(Map<String, dynamic> json) {
    if (json['product_sizes'] != null) {
      productSizes = <ProductSizes>[];
      json['product_sizes'].forEach((v) {
        productSizes!.add(ProductSizes.fromJson(v));
      });
    }
    if (json['product_colors'] != null) {
      productColors = <ProductColors>[];
      json['product_colors'].forEach((v) {
        productColors!.add(ProductColors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productSizes != null) {
      data['product_sizes'] = productSizes!.map((v) => v.toJson()).toList();
    }
    if (productColors != null) {
      data['product_colors'] = productColors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductSizes {
  String? id, optionName, optionValue;
  List<ProductColors>? colors;

  ProductSizes({this.id, this.optionName, this.optionValue, this.colors});

  ProductSizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    optionName = json['option_name'];
    optionValue = json['option_value'];
    if (json['colors'] != null) {
      colors = <ProductColors>[];
      json['colors'].forEach((v) {
        colors!.add(ProductColors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['option_name'] = optionName;
    data['option_value'] = optionValue;
    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductColors {
  String? id, optionName, optionValue;

  ProductColors({this.id, this.optionName, this.optionValue});

  ProductColors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    optionName = json['option_name'];
    optionValue = json['option_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['option_name'] = optionName;
    data['option_value'] = optionValue;
    return data;
  }
}
