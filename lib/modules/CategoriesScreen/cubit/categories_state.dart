
import '../../../models/categories.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}


class ShopLoadingCategoriesDataState extends CategoriesState {}

class ShopSuccessCategoriesDataState extends CategoriesState {
  CategoriesModel? categoriesModel;
  static ShopSuccessCategoriesDataState object=ShopSuccessCategoriesDataState();
  ShopSuccessCategoriesDataState({this.categoriesModel});
}

class ShopErrorCategoriesDataState extends CategoriesState {}

