
import '../../../models/login_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class ShopLoginInitialState extends LoginState {}

class ShopLoginSuccessState extends LoginState {
  LoginUserModel? loginUserModel;
  ShopLoginSuccessState({this.loginUserModel});
}

class ShopLoginLoadingState extends LoginState {}

class ShopLoginErrorState extends LoginState {
  final String error;
  ShopLoginErrorState(this.error);
}