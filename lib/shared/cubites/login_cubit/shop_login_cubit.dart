import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_cubit.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/cubites/login_cubit/shop_login_states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../network/remote/end_points.dart';

// class LoginCubit extends Cubit<ShopLoginStates>
// {
//   LoginCubit() : super(ShopLoginInitialState());
//
//   static LoginCubit get(context) => BlocProvider.of(context);
//
//
//
//
//
// }
