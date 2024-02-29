class AccountModel {
  int? _total;
  int? _limit;
  int? _offset;
  List<Accounts>? _accounts;

  AccountModel(
      {int? total, int? limit, int? offset, List<Accounts>? accounts}) {
    if (total != null) {
      _total = total;
    }
    if (limit != null) {
      _limit = limit;
    }
    if (offset != null) {
      _offset = offset;
    }
    if (accounts != null) {
      _accounts = accounts;
    }
  }

  int? get total => _total;
  int? get limit => _limit;
  int? get offset => _offset;
  List<Accounts>? get accounts => _accounts;


  AccountModel.fromJson(Map<String, dynamic> json) {
    _total = json['total'];
    _limit = int.parse(json['limit'].toString());
    _offset = int.parse(json['offset'].toString());
    if (json['accounts'] != null) {
      _accounts = <Accounts>[];
      json['accounts'].forEach((v) {
        _accounts!.add(Accounts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = _total;
    data['limit'] = _limit;
    data['offset'] = _offset;
    if (_accounts != null) {
      data['accounts'] = _accounts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Accounts {
  int? _id;
  String? _account;
  String? _description;
  double? _balance;
  String? _accountNumber;
  double? _totalIn;
  double? _totalOut;
  String? _createdAt;
  String? _updatedAt;


  Accounts(
      {int? id,
        String? account,
        String? description,
        double? balance,
        String? accountNumber,
        double? totalIn,
        double? totalOut,
        String? createdAt,
        String? updatedAt,
       }) {
    if (id != null) {
      _id = id;
    }
    if (account != null) {
      _account = account;
    }
    if (description != null) {
      _description = description;
    }
    if (balance != null) {
      _balance = balance;
    }
    if (accountNumber != null) {
      _accountNumber = accountNumber;
    }
    if (totalIn != null) {
      _totalIn = totalIn;
    }
    if (totalOut != null) {
      _totalOut = totalOut;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }

  }

  int? get id => _id;
  String? get account => _account;
  String? get description => _description;
  double? get balance => _balance;
  String? get accountNumber => _accountNumber;
  double? get totalIn => _totalIn;
  double? get totalOut => _totalOut;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;


  Accounts.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _account = json['account'];
    _description = json['description'];
    if(json['balance'] != null){
      try{
        _balance = json['balance'].toDouble();
      }catch(e){
        _balance = double.parse(json['balance'].toString());
      }

    }

    _accountNumber = json['account_number'];
    if(json['total_in'] != null){
      try{
        _totalIn = json['total_in'].toDouble();
      }catch(e){
        _totalIn = double.parse(json['total_in'].toString());
      }

    }else{
      _totalIn = 0.0;
    }
    if(json['total_out'] != null){
      try{
        _totalOut = json['total_out'].toDouble();
      }catch(e){
        _totalOut = double.parse(json['total_out'].toString());
      }

    }else{
      _totalOut = 0.0;
    }

    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['account'] = _account;
    data['description'] = _description;
    data['balance'] = _balance;
    data['account_number'] = _accountNumber;
    data['total_in'] = _totalIn;
    data['total_out'] = _totalOut;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}
