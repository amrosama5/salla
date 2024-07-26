class AddToCartModel {
  late bool status;
  late AddCartProductData data;


  AddToCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =AddCartProductData.fromJson(json['data']);
  }
}

class AddCartProductData {
  late int id;
  late dynamic quantity;
  late CartProduct product;


  AddCartProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =CartProduct.fromJson(json['product']);
  }
}

class CartProduct {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;


  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}