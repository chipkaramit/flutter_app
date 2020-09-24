class LoginResponseModel {
  String message;
  String status;
  String token;
  Data data;

  LoginResponseModel({this.message, this.status, this.token, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    token = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String custId;
  String title;
  String firstName;
  String lastName;
  String email;
  String mobile;
  String gender;
  String dob;
  String address1;
  String address2;
  String apartmentNumber;
  String city;
  String territory;
  String country;
  String postalCode;

  Data(
      {this.custId,
        this.title,
        this.firstName,
        this.lastName,
        this.email,
        this.mobile,
        this.gender,
        this.dob,
        this.address1,
        this.address2,
        this.apartmentNumber,
        this.city,
        this.territory,
        this.country,
        this.postalCode});

  Data.fromJson(Map<String, dynamic> json) {
    custId = json['custId'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    dob = json['dob'];
    address1 = json['address1'];
    address2 = json['address2'];
    apartmentNumber = json['apartmentNumber'];
    city = json['city'];
    territory = json['territory'];
    country = json['country'];
    postalCode = json['postalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custId'] = this.custId;
    data['title'] = this.title;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['apartmentNumber'] = this.apartmentNumber;
    data['city'] = this.city;
    data['territory'] = this.territory;
    data['country'] = this.country;
    data['postalCode'] = this.postalCode;
    return data;
  }
}


/*class LoginResponseModel
{
  String _message;
  String _status;
  Data _data;

  LoginResponseModel({String message, String status, Data data}) {
    this._message = message;
    this._status = status;
    this._data = data;
  }

  String get message => _message;

  set message(String message) => _message = message;

  String get status => _status;

  set status(String status) => _status = status;

  Data get data => _data;

  set data(Data data) => _data = data;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    _status = json['status'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this._message;
    data['status'] = this._status;
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    return data;
  }
}

class Data {
  String _custId;
  String _title;
  String _firstName;
  String _lastName;
  String _email;
  String _mobile;
  String _gender;
  String _dob;
  String _address1;
  String _address2;
  String _apartmentNumber;
  String _city;
  String _territory;
  String _country;
  String _postalCode;
  String _token;

  Data(
      {String custId,
      String title,
      String firstName,
      String lastName,
      String email,
      String mobile,
      String gender,
      String dob,
      String address1,
      String address2,
      String apartmentNumber,
      String city,
      String territory,
      String country,
      String postalCode,
      String token}) {
    this._custId = custId;
    this._title = title;
    this._firstName = firstName;
    this._lastName = lastName;
    this._email = email;
    this._mobile = mobile;
    this._gender = gender;
    this._dob = dob;
    this._address1 = address1;
    this._address2 = address2;
    this._apartmentNumber = apartmentNumber;
    this._city = city;
    this._territory = territory;
    this._country = country;
    this._postalCode = postalCode;
    this._token = token;
  }

  String get custId => _custId;

  set custId(String custId) => _custId = custId;

  String get title => _title;

  set title(String title) => _title = title;

  String get firstName => _firstName;

  set firstName(String firstName) => _firstName = firstName;

  String get lastName => _lastName;

  set lastName(String lastName) => _lastName = lastName;

  String get email => _email;

  set email(String email) => _email = email;

  String get mobile => _mobile;

  set mobile(String mobile) => _mobile = mobile;

  String get gender => _gender;

  set gender(String gender) => _gender = gender;

  String get dob => _dob;

  set dob(String dob) => _dob = dob;

  String get address1 => _address1;

  set address1(String address1) => _address1 = address1;

  String get address2 => _address2;

  set address2(String address2) => _address2 = address2;

  String get apartmentNumber => _apartmentNumber;

  set apartmentNumber(String apartmentNumber) =>
      _apartmentNumber = apartmentNumber;

  String get city => _city;

  set city(String city) => _city = city;

  String get territory => _territory;

  set territory(String territory) => _territory = territory;

  String get country => _country;

  set country(String country) => _country = country;

  String get postalCode => _postalCode;

  set postalCode(String postalCode) => _postalCode = postalCode;

  String get token => _token;

  set token(String token) => _token = token;

  Data.fromJson(Map<String, dynamic> json) {
    _custId = json['custId'];
    _title = json['title'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _mobile = json['mobile'];
    _gender = json['gender'];
    _dob = json['dob'];
    _address1 = json['address1'];
    _address2 = json['address2'];
    _apartmentNumber = json['apartmentNumber'];
    _city = json['city'];
    _territory = json['territory'];
    _country = json['country'];
    _postalCode = json['postalCode'];
    _token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custId'] = this._custId;
    data['title'] = this._title;
    data['firstName'] = this._firstName;
    data['lastName'] = this._lastName;
    data['email'] = this._email;
    data['mobile'] = this._mobile;
    data['gender'] = this._gender;
    data['dob'] = this._dob;
    data['address1'] = this._address1;
    data['address2'] = this._address2;
    data['apartmentNumber'] = this._apartmentNumber;
    data['city'] = this._city;
    data['territory'] = this._territory;
    data['country'] = this._country;
    data['postalCode'] = this._postalCode;
    data['token'] = this._token;
    return data;
  }
}*/
