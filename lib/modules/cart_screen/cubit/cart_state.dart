
import '../../../models/cart_model.dart';
import '../../../models/get_cart_model.dart';
import '../../../models/put_to_cart.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class ShopSuccessPostCartDataState extends CartState {
  final AddToCartModel? addToCartModel;
  ShopSuccessPostCartDataState({this.addToCartModel});
}

class ShopLoadingPostCartDataState extends CartState {}

class ShopErrorPostCartDataState extends CartState {}




class ShopLoadingGetCartDataState extends CartState {}

class ShopSuccessGetCartDataState extends CartState {
  final GetCartModel? getCart;
  ShopSuccessGetCartDataState({this.getCart});
}

class ShopErrorGetCartDataState extends CartState {}


class ShopLoadingUpdateCartDataState extends CartState {}

class ShopSuccessUpdateCartDataState extends CartState
{
  final PutCart? putCart;
  ShopSuccessUpdateCartDataState({this.putCart});
}

class ShopErrorUpdateCartDataState extends CartState {}


class ShopLoadingDeleteCartDataState extends CartState {}

class ShopSuccessDeleteCartDataState extends CartState {}

class ShopErrorDeleteCartDataState extends CartState {}