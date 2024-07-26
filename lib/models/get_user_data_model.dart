class GetUserDataModel {
  bool? status;
  Data? data;

  GetUserDataModel({this.status, this.data});

  GetUserDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }


}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.image,
        this.points,
        this.credit,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }

}