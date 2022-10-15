class CartData {
  bool? paymentWithWallet;
  Cart? cart;
  StoreInfo? storeInfo;
  Authfortoken? authForToken;

  CartData(
      {this.paymentWithWallet, this.cart, this.storeInfo, this.authForToken});

  CartData.fromJson(Map<String, dynamic> json) {
    paymentWithWallet = json['paymentWithWallet'];
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
    storeInfo = json['store_info'] != null
        ? StoreInfo.fromJson(json['store_info'])
        : null;
    // authForToken = json['authfortoken'] != null
    //     ? Authfortoken.fromJson(json['authfortoken'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentWithWallet'] = paymentWithWallet;
    if (cart != null) {
      data['cart'] = cart!.toJson();
    }
    if (storeInfo != null) {
      data['store_info'] = storeInfo!.toJson();
    }
    if (authForToken != null) {
      data['authfortoken'] = authForToken!.toJson();
    }
    return data;
  }
}

class Cart {
  List<Item>? item;
  int? cartTotalWithoutFormat;
  String? cartTotal;
  int? totalItems;
  int? totalDiscountedPriceWithoutFormat;
  String? totalDiscountedPrice;
  int? totalDiscountWithoutFormat;
  String? totalDiscount;
  List? tax;
  int? delliveryCharge;
  List? extraCharge;
  List? offers;
  Tokenmsg? tokenmsg;

  Cart(
      {this.item,
      this.cartTotalWithoutFormat,
      this.cartTotal,
      this.totalItems,
      this.totalDiscountedPriceWithoutFormat,
      this.totalDiscountedPrice,
      this.totalDiscountWithoutFormat,
      this.totalDiscount,
      this.tax,
      this.delliveryCharge,
      this.extraCharge,
      this.offers,
      this.tokenmsg});

  Cart.fromJson(Map<String, dynamic> json) {
    if (json['item'] != null) {
      item = <Item>[];
      json['item'].forEach((v) {
        item!.add(Item.fromJson(v));
      });
    }
    cartTotalWithoutFormat = json['cart_total_without_format'];
    cartTotal = json['cart_total'];
    totalItems = json['total_items'];
    totalDiscountedPriceWithoutFormat =
        json['total_discounted_price_without_format'];
    totalDiscountedPrice = json['total_discounted_price'];
    totalDiscountWithoutFormat = json['total_discount_without_format'];
    totalDiscount = json['total_discount'];
    if (json['tax'] != null) {
      tax = <Null>[];
      json['tax'].forEach((v) {
        tax!.add(v);
      });
    }
    delliveryCharge = json['dellivery_charge'];
    if (json['extra_charge'] != null) {
      extraCharge = <Null>[];
      json['extra_charge'].forEach((v) {
        extraCharge!.add(v);
      });
    }
    if (json['offers'] != null) {
      offers = <Null>[];
      json['offers'].forEach((v) {
        offers!.add(v);
      });
    }
    tokenmsg =
        json['tokenmsg'] != null ? Tokenmsg.fromJson(json['tokenmsg']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (item != null) {
      data['item'] = item!.map((v) => v.toJson()).toList();
    }
    data['cart_total_without_format'] = cartTotalWithoutFormat;
    data['cart_total'] = cartTotal;
    data['total_items'] = totalItems;
    data['total_discounted_price_without_format'] =
        totalDiscountedPriceWithoutFormat;
    data['total_discounted_price'] = totalDiscountedPrice;
    data['total_discount_without_format'] = totalDiscountWithoutFormat;
    data['total_discount'] = totalDiscount;
    if (tax != null) {
      data['tax'] = tax!.map((v) => v.toJson()).toList();
    }
    data['dellivery_charge'] = delliveryCharge;
    if (extraCharge != null) {
      data['extra_charge'] = extraCharge!.map((v) => v.toJson()).toList();
    }
    if (offers != null) {
      data['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    if (tokenmsg != null) {
      data['tokenmsg'] = tokenmsg!.toJson();
    }
    return data;
  }
}

class Item {
  bool isLoading;
  String? qty;
  String? cartId;
  String? productId;
  String? productOptionId;
  String? kioskId;
  String? cartStatus;
  var appliedOffer;
  String? productQty;
  String? name;
  String? category;
  String? price;
  String? trackInventory;
  String? threshold;
  String? thresholdLimit;
  String? merchantId;
  String? storeId;
  String? description;
  List<String>? imgs;
  String? currency;
  String? currencyCode;
  String? cashtoken;
  String? rating;
  bool inStock;
  String? productStatus;
  List<String>? imgsThumb;
  List<SelectedSize>? selectedSize;
  List<SelectedColor>? selectedColor;
  String? offferPriceWithoutFormat;
  String? offferPrice;
  List? offers;
  List? applyedOffer;

  Item(
      {required this.isLoading,
      required this.inStock,
      this.qty,
      this.cartId,
      this.productId,
      this.productOptionId,
      this.kioskId,
      this.cartStatus,
      this.appliedOffer,
      this.productQty,
      this.name,
      this.category,
      this.price,
      this.trackInventory,
      this.threshold,
      this.thresholdLimit,
      this.merchantId,
      this.storeId,
      this.description,
      this.imgs,
      this.currency,
      this.currencyCode,
      this.cashtoken,
      this.rating,
      this.productStatus,
      this.imgsThumb,
      this.selectedSize,
      this.selectedColor,
      this.offferPriceWithoutFormat,
      this.offferPrice,
      this.offers,
      this.applyedOffer});

  factory Item.fromJson(Map<String, dynamic> json) {
    print("dfawmenkgptaewngt $json");
    var offers = [];
    var applyedOffer = [];
    if (json['offers'] != null) {
      json['offers'].forEach((v) {
        offers.add(v);
      });
    }
    if (json['applyed_offer'] != null) {
      json['applyed_offer'].forEach((v) {
        applyedOffer.add(v);
      });
    }
    List<SelectedSize> size = [];
    if (json['selected_size'] != null && json["selected_size"] != false) {
      json['selected_size'].forEach((v) {
        size.add(SelectedSize.fromJson(v));
      });
    }
    List<SelectedColor> color = [];
    if (json['selected_color'] != null && json["selected_color"] != false) {
      json['selected_color'].forEach((v) {
        color.add(SelectedColor.fromJson(v));
      });
    }
    print("aobfroew $json");
    return Item(
        isLoading: false,
        qty: json['qty'],
        cartId: json['cart_id'],
        productId: json['product_id'],
        productOptionId: json['product_option_id'],
        kioskId: json['kiosk_id'],
        cartStatus: json['cart_status'],
        appliedOffer: json['applied_offer'],
        productQty: json['product_qty'],
        name: json['name'],
        category: json['category'],
        price: json['price'],
        trackInventory: json['track_inventory'],
        threshold: json['threshold'],
        thresholdLimit: json['threshold_limit'],
        merchantId: json['merchant_id'],
        storeId: json['store_id'],
        description: json['description'],
        inStock: json["inStock"],
        imgs: json['imgs'].cast<String>(),
        currency: json['currency'],
        currencyCode: json['currency_code'],
        cashtoken: json['cashtoken'],
        rating: json['rating'],
        productStatus: json['product_status'],
        imgsThumb: json['imgs_thumb'].cast<String>(),
        selectedSize: size,
        selectedColor: color,
        offferPriceWithoutFormat:
            json['offfer_price_without_format'].toString(),
        offferPrice: json['offfer_price'],
        offers: offers,
        applyedOffer: applyedOffer);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qty'] = qty;
    data['cart_id'] = cartId;
    data['product_id'] = productId;
    data['product_option_id'] = productOptionId;
    data['kiosk_id'] = kioskId;
    data['cart_status'] = cartStatus;
    data['applied_offer'] = appliedOffer;
    data['product_qty'] = productQty;
    data['name'] = name;
    data['category'] = category;
    data['price'] = price;
    data['track_inventory'] = trackInventory;
    data['threshold'] = threshold;
    data['threshold_limit'] = thresholdLimit;
    data['merchant_id'] = merchantId;
    data['store_id'] = storeId;
    data['description'] = description;
    data['imgs'] = imgs;
    data['currency'] = currency;
    data['currency_code'] = currencyCode;
    data['cashtoken'] = cashtoken;
    data['rating'] = rating;
    data['product_status'] = productStatus;
    data['imgs_thumb'] = imgsThumb;
    if (selectedSize != null) {
      data['selected_size'] = selectedSize!.map((v) => v.toJson()).toList();
    }
    if (selectedColor != null) {
      data['selected_color'] = selectedColor!.map((v) => v.toJson()).toList();
    }
    data['offfer_price_without_format'] = offferPriceWithoutFormat;
    data['offfer_price'] = offferPrice;
    if (offers != null) {
      data['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    if (applyedOffer != null) {
      data['applyed_offer'] = applyedOffer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SelectedSize {
  String? optionName;
  String? id;

  SelectedSize({this.optionName, this.id});

  SelectedSize.fromJson(Map<String, dynamic> json) {
    optionName = json['option_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option_name'] = optionName;
    data['id'] = id;
    return data;
  }
}

class SelectedColor {
  String? optionName;
  String? optionValue;
  String? id;

  SelectedColor({this.optionName, this.optionValue, this.id});

  SelectedColor.fromJson(Map<String, dynamic> json) {
    optionName = json['option_name'];
    optionValue = json['option_value'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option_name'] = optionName;
    data['option_value'] = optionValue;
    data['id'] = id;
    return data;
  }
}

class Tokenmsg {
  int? isValidForToken;
  String? message;

  Tokenmsg({this.isValidForToken, this.message});

  Tokenmsg.fromJson(Map<String, dynamic> json) {
    isValidForToken = json['is_valid_for_token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_valid_for_token'] = isValidForToken;
    data['message'] = message;
    return data;
  }
}

class StoreInfo {
  String? id;
  String? merchantId;
  String? storeName;
  String? storeLogo;
  String? storeCountry;
  String? storeState;
  String? storeCity;
  String? storeAddress;
  String? storeLatitude;
  String? storeLongitude;
  String? storeDescription;
  String? status;
  String? openTime;
  String? closeTime;
  String? rating;
  String? storeCurrency;
  String? storeCurrencySign;
  String? marginByMerchant;
  String? storeLogoThumb;

  StoreInfo(
      {this.id,
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
      this.status,
      this.openTime,
      this.closeTime,
      this.rating,
      this.storeCurrency,
      this.storeCurrencySign,
      this.marginByMerchant,
      this.storeLogoThumb});

  StoreInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantId = json['merchant_id'];
    storeName = json['store_name'];
    storeLogo = json['store_logo'];
    storeCountry = json['store_country'];
    storeState = json['store_state'];
    storeCity = json['store_city'];
    storeAddress = json['store_address'];
    storeLatitude = json['store_latitude'];
    storeLongitude = json['store_longitude'];
    storeDescription = json['store_description'];
    status = json['status'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    rating = json['rating'];
    storeCurrency = json['store_currency'];
    storeCurrencySign = json['store_currency_sign'];
    marginByMerchant = json['margin_by_merchant'];
    storeLogoThumb = json['store_logo_thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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
    data['status'] = status;
    data['open_time'] = openTime;
    data['close_time'] = closeTime;
    data['rating'] = rating;
    data['store_currency'] = storeCurrency;
    data['store_currency_sign'] = storeCurrencySign;
    data['margin_by_merchant'] = marginByMerchant;
    data['store_logo_thumb'] = storeLogoThumb;
    return data;
  }
}

class Authfortoken {
  String? accessToken;
  int? expiresIn;
  String? tokenType;
  String? scope;

  Authfortoken({this.accessToken, this.expiresIn, this.tokenType, this.scope});

  Authfortoken.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    tokenType = json['token_type'];
    scope = json['scope'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['expires_in'] = expiresIn;
    data['token_type'] = tokenType;
    data['scope'] = scope;
    return data;
  }
}
