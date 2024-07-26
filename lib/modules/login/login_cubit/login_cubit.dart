import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/login_model.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';
import 'login_state.dart';


class LoginCubit extends Cubit<LoginState>
{
  LoginCubit() : super(LoginInitial());




  static LoginCubit get(context) => BlocProvider.of(context);





  LoginUserModel? userModel;

  Future userLogin({
    required String email,
    required String password,
  })async{
    emit(ShopLoginLoadingState());
    return await DioHelper.postData(
        path: LOGIN,
        data: {
          'email':email,
          'password':password
        }).then((value)
    {
      print(value.data);
      userModel = LoginUserModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginUserModel: userModel));
    }).catchError((ex){
      print("error is ${ex.toString()}");
      emit(ShopLoginErrorState(ex.toString()));
    });
  }
}
