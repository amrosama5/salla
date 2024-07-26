class RegisterModel {
  late bool status;
  late String message;
  late Data? registerDataModel;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    registerDataModel = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  late int id;
  late String name;
  late String phone;
  late String email;
  late String image;
  late String token;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    token = json['token'];
  }
}