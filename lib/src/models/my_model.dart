
class UserModel {
  String? mobileNumber;
  String? password;

  UserModel({
    this.mobileNumber,
    this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNumber'] = this.mobileNumber;
    data['password'] = this.password;
    return data;
  }
}