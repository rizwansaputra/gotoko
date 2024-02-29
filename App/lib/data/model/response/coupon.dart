class CouponItem {
  List<Coupon>? _coupon;

  CouponItem({List<Coupon>? coupon}) {
    if (coupon != null) {
      _coupon = coupon;
    }
  }

  List<Coupon>? get coupon => _coupon;

  CouponItem.fromJson(Map<String, dynamic> json) {
    if (json['coupon'] != null) {
      _coupon = <Coupon>[];
      json['coupon'].forEach((v) {
        _coupon!.add(Coupon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_coupon != null) {
      data['coupon'] = _coupon!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coupon {
  int? _userLimit;
  String? _startDate;
  String? _expireDate;
  String? _minPurchase;
  String? _maxDiscount;

  Coupon(
      {int? userLimit,
        String? startDate,
        String? expireDate,
        String? minPurchase,
        String? maxDiscount}) {
    if (userLimit != null) {
      _userLimit = userLimit;
    }
    if (startDate != null) {
      _startDate = startDate;
    }
    if (expireDate != null) {
      _expireDate = expireDate;
    }
    if (minPurchase != null) {
      _minPurchase = minPurchase;
    }
    if (maxDiscount != null) {
      _maxDiscount = maxDiscount;
    }
  }

  int? get userLimit => _userLimit;
  String? get startDate => _startDate;
  String? get expireDate => _expireDate;
  String? get minPurchase => _minPurchase;
  String? get maxDiscount => _maxDiscount;

  Coupon.fromJson(Map<String, dynamic> json) {
    _userLimit = json['user_limit'];
    _startDate = json['start_date'];
    _expireDate = json['expire_date'];
    _minPurchase = json['min_purchase'];
    _maxDiscount = json['max_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_limit'] = _userLimit;
    data['start_date'] = _startDate;
    data['expire_date'] = _expireDate;
    data['min_purchase'] = _minPurchase;
    data['max_discount'] = _maxDiscount;
    return data;
  }
}
