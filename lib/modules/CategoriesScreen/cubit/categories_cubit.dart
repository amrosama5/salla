import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/categories.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';
import 'categories_state.dart';


class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  static CategoriesCubit get(context) => BlocProvider.of(context);

  /// api Categories Data
  CategoriesModel? categoriesModel;
  void getCategoriesData()
  {
    emit(ShopLoadingCategoriesDataState());
    DioHelper.getData(
      url: Get_Categories,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState(categoriesModel: categoriesModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }
}
