
import '../../../models/get_favorite_model.dart';
import '../../../models/home_model.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ShopLoadingHomeDataState extends ProductsState {}

class ShopSuccessHomeDataState extends ProductsState {
  HomeModel? homeModel;
  ShopSuccessHomeDataState({this.homeModel});
}

class ShopErrorHomeDataState extends ProductsState {}



