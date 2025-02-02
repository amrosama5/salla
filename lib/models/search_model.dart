class SearchModel {
  late bool status;
  late Data data;


  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }

}

class Data
{
  late int currentPage;
  List<Product> data=[];
  late String firstPageUrl;
  late int from;
  late int lastPage;
  late String lastPageUrl;
  late String path;
  late int perPage;
  late int to;
  late int total;



  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null)
    {
      json['data'].forEach((v) {
        data.add(Product.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

}

class Product {
  late int id;
  late dynamic price;
  late String image;
  late String name;
  late String description;
  late List<String> images=[];
  late bool inFavorites;
  late bool inCart;


  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }


}