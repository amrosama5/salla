import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app_layout/shop_app_layout.dart';
import 'package:shop_app/layout/shop_cubit/shop_cubit.dart';
import 'package:shop_app/modules/CategoriesScreen/cubit/categories_cubit.dart';
import 'package:shop_app/modules/FavouritesScreen/cubit/favorites_cubit.dart';
import 'package:shop_app/modules/ProductsScreen/cubit/products_cubit.dart';
import 'package:shop_app/modules/SettingsScreen/cubit/settings_cubit.dart';
import 'package:shop_app/modules/cart_screen/cubit/cart_cubit.dart';
import 'package:shop_app/modules/register/shop_register_screen.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/shared/styles/colors.dart';
import '../../shared/componets/constans.dart';
import '../../shared/componets/widgets.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'login_cubit/login_cubit.dart';
import 'login_cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is ShopLoginSuccessState)
            {
              if (LoginCubit.get(context).userModel!.status)
              {
                showToast(
                    msg: LoginCubit.get(context).userModel!.message, color: Colors.green);
                CacheHelper.saveData(
                        key: 'token',
                        value: LoginCubit.get(context).userModel!.data.token
                ).then((value)
                {
                  token = state.loginUserModel!.data.token!;
                  print('token  from login screen $token');
                  navigatorPushAndRemove(context: context, widget: const ShopAppLayout());
                });
              } else
              {
                showToast(msg: LoginCubit.get(context).userModel!.message, color: Colors.red);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'login now to browse our hot offers',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomFormField(
                            paddingOutForm: EdgeInsets.zero,
                            labelText: 'Email Address',
                            hintText: 'Enter your email Address',
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(Icons.email_rounded),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'please enter your email address';
                              }
                              return null;
                            },
                            onSubmitted: (_) {},
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomFormField(
                            paddingOutForm: EdgeInsets.zero,
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            controller: passwordController,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(Icons.password),
                            obscureText: ShopCubit.get(context).isPasswordShow,
                            suffixIcon: IconButton(
                              onPressed: () {
                                ShopCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              icon: Icon(ShopCubit.get(context).suffix),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'please enter your password';
                              }
                              return null;
                            },
                            onSubmitted: (_) {
                              if (formKey.currentState!.validate())
                              {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              builder: (context) => CustomMaterialButton(
                                    text: 'Login',
                                    textStyle: const TextStyle(
                                      color: Colors.white
                                    ),
                                    widget: const SizedBox(
                                      height: 0,
                                      width: 0,
                                    ),
                                    onPressed: ()
                                    {
                                      if (formKey.currentState!.validate())
                                      {
                                        LoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text,
                                        ).then((value) {
                                          token = LoginCubit.get(context).userModel!.data.token!;
                                          SettingsCubit.get(context).getUserData();
                                          ProductsCubit.get(context).getHomeData();
                                          CategoriesCubit.get(context).getCategoriesData();
                                          CartCubit.get(context).getCartData();
                                          FavoritesCubit.get(context).getFavoritesData();
                                        });
                                      }
                                    },
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                              fallback: (context) => const Center(
                                    child: CircularProgressIndicator(),
                                  )),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\' have an account ?',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigatorPushAndRemove(
                                        context: context,
                                        widget: ShopRegisterScreen());
                                  },
                                  child: const Text('Register Now'))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
  }
}
