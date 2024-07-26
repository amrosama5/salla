import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/componets/widgets.dart';
import 'package:shop_app/shared/styles/colors.dart';
import '../../shared/componets/constans.dart';
import '../../shared/network/local/shared_preferences.dart';
import '../login/login_screen.dart';
import 'cubit/settings_cubit.dart';
import 'cubit/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  TextEditingController? emailController = TextEditingController();
  TextEditingController? nameController = TextEditingController();
  TextEditingController? phoneController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: SettingsCubit.get(context).getUserDataModel != null,
              builder: (context) {
                emailController!.text =
                SettingsCubit.get(context).getUserDataModel!.data!.email!;
                nameController!.text =
                SettingsCubit.get(context).getUserDataModel!.data!.name!;
                phoneController!.text =
                SettingsCubit.get(context).getUserDataModel!.data!.phone!;
                return Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children:
                        [
                          if(state is ShopLoadingUpdateUserDataState)
                            const LinearProgressIndicator(),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomFormField(
                            paddingOutForm: const EdgeInsets.all(10),
                            labelText: 'Name',
                            prefixIcon: const Icon(Icons.email),
                            hintText: 'Name',
                            controller: nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name must not be empty';
                              }
                              return null;
                            },
                          ),
                          CustomFormField(
                            paddingOutForm: const EdgeInsets.all(10),
                            labelText: 'Email Address',
                            prefixIcon: const Icon(Icons.email),
                            hintText: 'Email Address',
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email Address must not be empty';
                              }
                              return null;
                            },
                          ),
                          CustomFormField(
                            paddingOutForm: const EdgeInsets.all(10),
                            labelText: 'Phone',
                            prefixIcon: const Icon(Icons.email),
                            controller: phoneController,
                            hintText: 'Phone',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'phone must not be empty';
                              }
                              return null;
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 70,
                            child: MaterialButton(
                              onPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  SettingsCubit.get(context).updateUserData(
                                      name: nameController!.text,
                                      email: emailController!.text,
                                      phone: phoneController!.text
                                  );
                                }
                              },
                              color: kPrimaryColor,
                              child: const Text(
                                'UPDATE',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 70,
                            child: MaterialButton(
                              onPressed: ()
                              {
                                // ShopCubit.get(context).logout(context: context);
                                //logout(context: context,);
                                CacheHelper.removeData(key: 'token').then((value)
                                {
                                  if (value)
                                  {
                                    navigatorPushAndRemove(context: context, widget: LoginScreen());

                                  }
                                  emailController!.text = '';
                                  passwordController!.text='';
                                  phoneController!.text='';
                                  nameController!.text='';
                                });
                              },
                              color: kPrimaryColor,
                              child: const Text(
                                'LOGOUT',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ));
        },
      );
  }
}
