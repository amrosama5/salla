import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/searchScreen/cubit/search_state.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../shared/componets/constans.dart';


class SearchCubit extends Cubit<SearchState> 
{
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);
  
  SearchModel? searchModel;
  void searchData({required String text})
  {
    emit(SearchLoadingState());
    DioHelper.postData(
        path: 'products/search',
        data: {
      'text':text
    },
        token: token
    ).then((value)
    {
      searchModel  = SearchModel.fromJson(value.data);
      print(searchModel!.data.data.length);
      emit(SearchSuccessState());
    }).catchError((error)
    {
      emit(SearchErrorState());
      print(error.toString());
    });
  }
}
