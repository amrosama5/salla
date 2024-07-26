import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/ProductsScreen/cubit/products_state.dart';

import '../../../models/home_model.dart';
import '../../../shared/componets/constans.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';


class ProductsCubit extends Cubit<ProductsState>
{
  ProductsCubit() : super(ProductsInitial());

  static ProductsCubit get(context) => BlocProvider.of(context);


  /// api Home Data
  Map<int,bool> favorites={};

  static Map<int,bool> itemsInCart={};
  HomeModel? homeModel;
  void getHomeData()
  {
    print(token);
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
        token: token
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id:element.in_favorites
        });
      });
      homeModel!.data.products.forEach((element) {
        itemsInCart.addAll({
          element.id:element.in_cart
        });
      });

      emit(ShopSuccessHomeDataState(homeModel: homeModel));
    }).catchError((error)
    {
      emit(ShopErrorHomeDataState());
    });
  }
}
