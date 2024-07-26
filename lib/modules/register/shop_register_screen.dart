import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/cubit/register_state.dart';

import '../../layout/shop_app_layout/shop_app_layout.dart';
import '../../layout/shop_cubit/shop_cubit.dart';
import '../../shared/componets/constans.dart';
import '../../shared/componets/widgets.dart';
import '../../shared/network/local/shared_preferences.dart';
import '../../shared/styles/colors.dart';
import 'cubit/register_cubit.dart';

class ShopRegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state)
      {
        if (state is RegisterSuccessState)
        {
          if (state.registerModel.status)
          {
            showToast(
                msg: state.registerModel.message, color: Colors.green);
            CacheHelper.saveData(
                key: 'token',
                value: state.registerModel.registerDataModel!.token
            ).then((value)
            {
              token = CacheHelper.getData(key: 'token');
              print('token  from register screen $token');
              navigatorPushAndRemove(context: context, widget: const ShopAppLayout());
            });
          } else
          {
            showToast(msg: state.registerModel.message, color: Colors.red);
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
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Register now to browse our hot offers',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomFormField(
                        paddingOutForm: EdgeInsets.zero,
                        labelText: 'Name',
                        hintText: 'Enter your Name',
                        controller: nameController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_rounded),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'please enter your Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomFormField(
                        paddingOutForm: EdgeInsets.zero,
                        labelText: 'Phone',
                        hintText: 'Enter your Phone',
                        controller: phoneController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_rounded),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'please enter your Phone';
                          }
                          return null;
                        },
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
                        obscureText: ShopCubit
                            .get(context)
                            .isPasswordShow,
                        suffixIcon: IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changePasswordVisibility();
                          },
                          icon: Icon(ShopCubit
                              .get(context)
                              .suffix),
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
                            RegisterCubit.get(context).register(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) =>
                              CustomMaterialButton(
                                text: 'Register',
                                textStyle: const TextStyle(color: Colors.white),
                                widget: const SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                                onPressed: ()
                                {
                                  if (formKey.currentState!.validate())
                                  {
                                    RegisterCubit.get(context).register(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                          fallback: (context) =>
                          const Center(
                            child: CircularProgressIndicator(),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'You have an account?',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                              onPressed: () {
                                navigatorPushAndRemove(
                                    context: context,
                                    widget: LoginScreen());
                              },
                              child: const Text('Login'))
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
