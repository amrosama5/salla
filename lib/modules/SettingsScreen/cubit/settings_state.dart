
import '../../../models/get_user_data_model.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class ShopLoadingGetUserDataState extends SettingsState {}

class ShopSuccessGetUserDataState extends SettingsState
{
  final GetUserDataModel? getUserDataModel;
  ShopSuccessGetUserDataState({this.getUserDataModel});
}

class ShopErrorGetUserDataState extends SettingsState {}

class ShopLoadingUpdateUserDataState extends SettingsState {}

class ShopSuccessUpdateUserDataState extends SettingsState
{
  final GetUserDataModel? getUserDataModel;
  ShopSuccessUpdateUserDataState({this.getUserDataModel});
}

class ShopErrorUpdateUserDataState extends SettingsState {}





class ShopLoadingLogoutState extends SettingsState {}

class ShopSuccessLogoutState extends SettingsState {}

class ShopErrorLogoutState extends SettingsState {}
