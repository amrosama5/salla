class HomeModel{
  late bool status;
  late HomeData data;
 HomeModel.fromJson(Map<String,dynamic> json){
   status = json['status'];
   data = HomeData.fromJson(json['data']);
 }
}

class HomeData
{
  late List<BannersData> banners=[];
  late List<ProductsData> products=[];
  HomeData.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element){
      banners.add(BannersData.fromJson(element));
    });
    json['products'].forEach((element){
      products.add(ProductsData.fromJson(element));
    });
  }
}

class BannersData
{
  late int id;
  late String image;

  BannersData.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}


class ProductsData
{
  late int id;
  late dynamic price;
  late dynamic old_price;
  late dynamic discount;
  late String name;
  late String image;
  late bool in_favorites;
  late bool in_cart;
  late String description;
  ProductsData.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    image = json['image'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
    description = json['description'];
  }
}