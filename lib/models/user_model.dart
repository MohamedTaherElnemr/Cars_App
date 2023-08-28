class UserModel {
  late String name;
  late String email;
  late String password;
  late String phone;
  late String uId;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.uId,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'uId': uId,
    };
  }
}
