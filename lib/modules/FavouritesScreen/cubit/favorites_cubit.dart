
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/get_favorite_model.dart';
import '../../../models/postFavoritesModel.dart';
import '../../../shared/componets/constans.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../ProductsScreen/cubit/products_cubit.dart';
import 'favorites_state.dart';


class FavoritesCubit extends Cubit<FavoritesState>
{
  FavoritesCubit() : super(FavoritesInitial());


  static FavoritesCubit get(context) => BlocProvider.of(context);
  /// api Favorites Screen
  FavoritesModel? favoritesModel;
  void postFavoritesData({required int productId,required context})
  {

    ProductsCubit.get(context).favorites[productId] = !ProductsCubit.get(context).favorites[productId]!;
    emit(ShopLoadingPostFavoritesDataState());
    DioHelper.postData(
      path: 'favorites',
      data:
      {
        "product_id":productId
      },
      token: token,
    ).then((value)
    {
      favoritesModel= FavoritesModel.fromJson(value.data);
      if(!favoritesModel!.status)
      {
        ProductsCubit.get(context).favorites[productId] = !ProductsCubit.get(context).favorites[productId]!;
      }else {
        getFavoritesData();
      }
      emit(ShopSuccessPostFavoritesDataState());
    }).catchError((ex)
    {
      ProductsCubit.get(context).favorites[productId] = !ProductsCubit.get(context).favorites[productId]!;
      emit(ShopErrorPostFavoritesDataState());
    });
  }



  GetFavoritesModel? getFavoritesModel;

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesDataState());
    DioHelper.getData(url: 'favorites', token: token).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesDataState(getFavoritesModel:getFavoritesModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesDataState());
    });
  }
}
