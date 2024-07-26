import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app_layout/shop_app_layout.dart';
import 'package:shop_app/modules/register/cubit/register_cubit.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/layout/shop_cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_cubit/shop_states.dart';
import 'package:shop_app/shared/componets/constans.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'modules/CategoriesScreen/cubit/categories_cubit.dart';
import 'modules/FavouritesScreen/cubit/favorites_cubit.dart';
import 'modules/ProductsScreen/cubit/products_cubit.dart';
import 'modules/SettingsScreen/cubit/settings_cubit.dart';
import 'modules/cart_screen/cubit/cart_cubit.dart';
import 'modules/login/login_cubit/login_cubit.dart';
import 'modules/login/login_screen.dart';
import 'modules/onBoarding/onBoarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  token = CacheHelper.getData(key: 'token') ?? '';
  print(CacheHelper.getData(key: 'token'));
  // if (onBoarding != null) {
  //   if (token != null) {
  //     widget = const ShopAppLayout();
  //   } else {
  //     widget = LoginScreen();
  //   }
  // } else {
  //   widget = OnBoardingScreen();
  // }
  runApp(MyApp(
    onBoarding: onBoarding,
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
  String token;
  MyApp({super.key, required this.onBoarding, required this.token});

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit()..getCartData(),
        ),
        BlocProvider(
          create: (context) => CategoriesCubit()..getCategoriesData(),
        ),
        BlocProvider(
          create: (context) => FavoritesCubit()..getFavoritesData(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => ProductsCubit()..getHomeData(),
        ),
        BlocProvider(
          create: (context) => SettingsCubit()..getUserData(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        )
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: onBoarding
                ? ((token.isEmpty) ? LoginScreen() : const ShopAppLayout())
                : OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
