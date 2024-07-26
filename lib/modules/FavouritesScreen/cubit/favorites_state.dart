
import '../../../models/get_favorite_model.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}


class ShopSuccessPostFavoritesDataState extends FavoritesState {}

class ShopLoadingPostFavoritesDataState extends FavoritesState {}

class ShopErrorPostFavoritesDataState extends FavoritesState {}


class ShopLoadingGetFavoritesDataState extends FavoritesState {}

class ShopSuccessGetFavoritesDataState extends FavoritesState {
  final GetFavoritesModel? getFavoritesModel;
  ShopSuccessGetFavoritesDataState({this.getFavoritesModel});
}

class ShopErrorGetFavoritesDataState extends FavoritesState {}
