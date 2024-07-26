import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/SettingsScreen/cubit/settings_state.dart';
import '../../../models/get_user_data_model.dart';
import '../../../shared/componets/constans.dart';
import '../../../shared/network/remote/dio_helper.dart';


class SettingsCubit extends Cubit<SettingsState>
{
  SettingsCubit() : super(SettingsInitial());
  static SettingsCubit get(context) => BlocProvider.of(context);

/// api User Data
GetUserDataModel? getUserDataModel;
void getUserData()
{
  emit(ShopLoadingGetUserDataState());
  DioHelper.getData(url: 'profile',token: token).then((value)
  {
    getUserDataModel = GetUserDataModel.fromJson(value.data);
    emit(ShopSuccessGetUserDataState(getUserDataModel: getUserDataModel));
  }).catchError((ex)
  {
    print(ex.toString());
    emit(ShopErrorGetUserDataState());
  });
}

  void updateUserData({
  required String email,
  required String name,
  required String phone,
})
  {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.updateData(
        path: 'update-profile',
        token: token,
        data: {
        'name':name,
          'email':email,
          'phone':phone
    }).then((value)
    {
      getUserDataModel = GetUserDataModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserDataState(getUserDataModel: getUserDataModel));
    }).catchError((ex)
    {
      print(ex.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }
}
