class PutCart {
  late  bool status;
  late String message;
  late Data data;


  PutCart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }


}

class Data {
  late Cart cart;
  late int subTotal;
  late int total;

  Data.fromJson(Map<String, dynamic> json) {
    cart = Cart.fromJson(json['cart']);
    subTotal = json['sub_total'];
    total = json['total'];
  }


}

class Cart {
  late int id;
  late int quantity;
  late Product product;



  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =Product.fromJson(json['product']);
  }

}

class Product {
  late int id;
  late int price;
  late int oldPrice;
  late int discount;
  late String image;


  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }

}