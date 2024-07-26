
import 'package:shop_app/models/register_model.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  RegisterModel registerModel ;
  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterState {}
