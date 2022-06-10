class LoginResponse {
  int? status;
  String? message;
  Data? data;

  LoginResponse({this.status, this.message, this.data});

  LoginResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}

class Data {
  String? id;
  String? firstName;
  String? lastName;
  String? displayName;
  String? accountType;
  String? emailAddress;
  String? countryId;
  String? mobileNumber;
  String? membershipType;
  bool? status;
  int? userId;
  String? token;
  String? tokenExpiry;
  String? userType;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.displayName,
      this.accountType,
      this.emailAddress,
      this.countryId,
      this.mobileNumber,
      this.membershipType,
      this.status,
      this.userId,
      this.token,
      this.tokenExpiry,
      this.userType});

  Data.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    displayName = json['displayName'];
    accountType = json['accountType'];
    emailAddress = json['emailAddress'];
    countryId = json['countryId'];
    mobileNumber = json['mobileNumber'];
    membershipType = json['membershipType'];
    status = json['status'];
    userId = json['userId'];
    token = json['token'];
    tokenExpiry = json['token_expiry'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['displayName'] = displayName;
    map['accountType'] = accountType;
    map['emailAddress'] = emailAddress;
    map['countryId'] = countryId;
    map['mobileNumber'] = mobileNumber;
    map['membershipType'] = membershipType;
    map['status'] = status;
    map['userId'] = userId;
    map['token'] = token;
    map['token_expiry'] = tokenExpiry;
    map['userType'] = userType;
    return map;
  }
}
