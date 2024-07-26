class CategoriesModel
{
 late bool status;
 late CategoriesDataModel data;
 CategoriesModel();
 CategoriesModel.fromJson(Map<String,dynamic> json){
   status = json['status'];
   data = CategoriesDataModel.fromJson(json['data']);

 }


}


class CategoriesDataModel{
  late int current_page;
  late String first_page_url;
  late int from;
  late int last_page;
  late String last_page_url;
  late String path;
  late int per_page;
  late int to;
  late int total;
  late List<DataModel> data=[];

  CategoriesDataModel.fromJson(Map<String,dynamic> json)
  {
    current_page = json['current_page'];
    first_page_url = json['first_page_url'];
    from = json['from'];
    last_page = json['last_page'];
    last_page_url = json['last_page_url'];
    path = json['path'];
    per_page = json['per_page'];
    to = json['to'];
    total = json['total'];
    json['data'].forEach((val){
      data.add(DataModel.fromJson(val));
    });
  }
}


class DataModel
{
  late int id;
  late String name;
  late String image;
  DataModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
