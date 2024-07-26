import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_cubit/shop_states.dart';
import 'package:shop_app/modules/searchScreen/search_screen.dart';
import 'package:shop_app/shared/componets/widgets.dart';

class ShopAppLayout extends StatelessWidget {
  const ShopAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text('Salla', style: TextStyle(
                color: Colors.black,
                fontSize: 30
            ),),
            actions: [
              IconButton(onPressed: () {
                navigatTo(context: context, widget: SearchScreen());
              }, icon: const Icon(Icons.search))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomNavBarItems,
            onTap: (index) {
              cubit.changeBottomNavBar(index, context);
            },
          ),
        );
      },
    );
  }
}
