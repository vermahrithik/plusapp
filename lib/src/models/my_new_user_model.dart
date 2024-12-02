
// centreName -
// name -
// mobileNumber -
// email (optional) -
// gender -
// age -
// addressLine1
// addressLine2 (optional)
// city
// state
// pinCode (optional)

class NewUserModel {
  String? userName;
  String? password;

  NewUserModel({
    this.userName,
    this.password,
  });

  NewUserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['password'] = this.password;
    return data;
  }
}