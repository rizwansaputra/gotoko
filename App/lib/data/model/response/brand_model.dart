class BrandModel {
  int? _total;
  String? _limit;
  String? _offset;
  List<Brands>? _brands;

  BrandModel(
      {int? total, String? limit, String? offset, List<Brands>? brands}) {
    if (total != null) {
      _total = total;
    }
    if (limit != null) {
      _limit = limit;
    }
    if (offset != null) {
      _offset = offset;
    }
    if (brands != null) {
      _brands = brands;
    }
  }

  int? get total => _total;
  String? get limit => _limit;
  String? get offset => _offset;
  List<Brands>? get brands => _brands;


  BrandModel.fromJson(Map<String, dynamic> json) {
    _total = json['total'];
    _limit = json['limit'];
    _offset = json['offset'];
    if (json['brands'] != null) {
      _brands = <Brands>[];
      json['brands'].forEach((v) {
        _brands!.add(Brands.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = _total;
    data['limit'] = _limit;
    data['offset'] = _offset;
    if (_brands != null) {
      data['brands'] = _brands!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Brands {
  int? _id;
  String? _name;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  Brands(
      {int? id,
        String? name,
        String? image,
        String? createdAt,
        String? updatedAt}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (image != null) {
      _image = image;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
  }

  int? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;


  Brands.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['image'] = _image;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}
