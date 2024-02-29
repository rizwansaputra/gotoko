class TransactionTypeModel {
  List<Types>? _types;

  TransactionTypeModel({List<Types>? types}) {
    if (types != null) {
      _types = types;
    }
  }

  List<Types>? get types => _types;


  TransactionTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['types'] != null) {
      _types = <Types>[];
      json['types'].forEach((v) {
        _types!.add(Types.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_types != null) {
      data['types'] = _types!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Types {
  int? _id;
  String? _tranType;

  Types({int? id, String? tranType}) {
    if (id != null) {
      _id = id;
    }
    if (tranType != null) {
      _tranType = tranType;
    }
  }

  int? get id => _id;
  String? get tranType => _tranType;

  Types.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _tranType = json['tran_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['tran_type'] = _tranType;
    return data;
  }
}
