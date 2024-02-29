class SupplierModel {
  int? _total;
  int? _limit;
  int? _offset;
  List<Suppliers>? _suppliers;

  SupplierModel(
      {int? total, int? limit, int? offset, List<Suppliers>? suppliers}) {
    if (total != null) {
      _total = total;
    }
    if (limit != null) {
      _limit = limit;
    }
    if (offset != null) {
      _offset = offset;
    }
    if (suppliers != null) {
      _suppliers = suppliers;
    }
  }

  int? get total => _total;
  int? get limit => _limit;
  int? get offset => _offset;
  List<Suppliers>? get suppliers => _suppliers;


  SupplierModel.fromJson(Map<String, dynamic> json) {
    _total = json['total'];
    _limit = int.parse(json['limit'].toString());
    _offset = int.parse(json['offset'].toString());
    if (json['suppliers'] != null) {
      _suppliers = <Suppliers>[];
      json['suppliers'].forEach((v) {
        _suppliers!.add(Suppliers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = _total;
    data['limit'] = _limit;
    data['offset'] = _offset;
    if (_suppliers != null) {
      data['suppliers'] = _suppliers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Suppliers {
  int? _id;
  String? _name;
  String? _mobile;
  String? _email;
  String? _image;
  String? _state;
  String? _city;
  String? _zipCode;
  String? _address;
  double? _dueAmount;
  String? _createdAt;
  String? _updatedAt;
  int? _productCount;


  Suppliers(
      {int? id,
        String? name,
        String? mobile,
        String? email,
        String? image,
        String? state,
        String? city,
        String? zipCode,
        String? address,
        double? dueAmount,
        String? createdAt,
        String? updatedAt,
        int? productCount,
       }) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (mobile != null) {
      _mobile = mobile;
    }
    if (email != null) {
      _email = email;
    }
    if (image != null) {
      _image = image;
    }
    if (state != null) {
      _state = state;
    }
    if (city != null) {
      _city = city;
    }
    if (zipCode != null) {
      _zipCode = zipCode;
    }
    if (address != null) {
      _address = address;
    }
    if (dueAmount != null) {
      _dueAmount = dueAmount;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (productCount != null) {
      _productCount = productCount;
    }

  }

  int? get id => _id;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get email => _email;
  String? get image => _image;
  String? get state => _state;
  String? get city => _city;
  String? get zipCode => _zipCode;
  String? get address => _address;
  double? get dueAmount => _dueAmount;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get productCount => _productCount;


  Suppliers.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _mobile = json['mobile'];
    _email = json['email'];
    _image = json['image'];
    _state = json['state'];
    _city = json['city'];
    _zipCode = json['zip_code'];
    _address = json['address'];
   if(json['due_amount'] != null){
     try{
       _dueAmount = json['due_amount'].toDouble();
     }catch(e){
       _dueAmount = double.parse(json['due_amount'].toString());
     }

   }else{
     _dueAmount = 0.0;
   }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if(json['products_count'] != null){
      _productCount = int.parse(json['products_count'].toString());
    }


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['mobile'] = _mobile;
    data['email'] = _email;
    data['image'] = _image;
    data['state'] = _state;
    data['city'] = _city;
    data['zip_code'] = _zipCode;
    data['address'] = _address;
    data['due_amount'] = _dueAmount;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['products_count'] = _productCount;

    return data;
  }
}
