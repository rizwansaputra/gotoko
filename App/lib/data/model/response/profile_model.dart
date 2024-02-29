class ProfileModel {
  int? _id;
  String? _fName;
  String? _lName;
  String? _email;
  String? _phone;
  String? _password;
  String? _image;


  ProfileModel(
      {int? id,
        String? fName,
        String? lName,
        String? email,
        String? phone,
        String? password,
        String? image,
       }) {
    if (id != null) {
      _id = id;
    }
    if (fName != null) {
      _fName = fName;
    }
    if (lName != null) {
      _lName = lName;
    }
    if (email != null) {
      _email = email;
    }
    if (phone != null) {
      _phone = phone;
    }
    if (password != null) {
      _password = password;
    }
    if (image != null) {
      _image = image;
    }
 
  }

  int? get id => _id;
  String? get fName => _fName;
  String? get lName => _lName;
  String? get email => _email;
  String? get phone => _phone;
  String? get password => _password;
  String? get image => _image;

  

  ProfileModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fName = json['f_name'];
    _lName = json['l_name'];
    _email = json['email'];
    _phone = json['phone'];
    _password = json['password'];
    _image = json['image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['f_name'] = _fName;
    data['l_name'] = _lName;
    data['email'] = _email;
    data['phone'] = _phone;
    data['password'] = _password;
    data['image'] = _image;
    return data;
  }
}
