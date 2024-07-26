import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_states.dart';
import 'package:shop_app/modules/CategoriesScreen/categories_screen.dart';
import 'package:shop_app/modules/FavouritesScreen/cubit/favorites_state.dart';
import 'package:shop_app/modules/FavouritesScreen/favourites_screen.dart';
import 'package:shop_app/modules/ProductsScreen/cubit/products_cubit.dart';
import 'package:shop_app/modules/ProductsScreen/products_screen.dart';
import 'package:shop_app/modules/SettingsScreen/settings_screen.dart';
import 'package:shop_app/modules/cart_screen/cubit/cart_state.dart';
import '../../modules/CategoriesScreen/cubit/categories_cubit.dart';
import '../../modules/CategoriesScreen/cubit/categories_state.dart';
import '../../modules/FavouritesScreen/cubit/favorites_cubit.dart';
import '../../modules/ProductsScreen/cubit/products_state.dart';
import '../../modules/cart_screen/cart__screen.dart';
import '../../modules/cart_screen/cubit/cart_cubit.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);


  ///BottomNavigationBar logic
  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
    const CartScreen(),
    SettingsScreen()
  ];

  List<BottomNavigationBarItem> bottomNavBarItems=const
  [
    BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart'),
    BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
  ];

  int currentIndex=0;
  void changeBottomNavBar(index,context)
  {
    currentIndex = index;
    if(index==2)
    {
      FavoritesCubit.get(context).getFavoritesData();
      FavoritesCubit.get(context).emit(ShopSuccessGetFavoritesDataState());
    }

    if(index==3)
    {
      CartCubit.get(context).getCartData();
      CartCubit.get(context).emit(ShopSuccessGetCartDataState());
    }

    if(index==0)
    {
      ProductsCubit.get(context).getHomeData();
      ProductsCubit.get(context).emit(ShopSuccessHomeDataState(homeModel: ProductsCubit.get(context).homeModel));
    }

    if(index==1)
    {
      if(ShopSuccessCategoriesDataState().categoriesModel == null)
      {
        CategoriesCubit.get(context).getCategoriesData();
      }else{
        const CategoriesScreen();
      }
    }

    emit(ShopChangeBottomNavBarState());
  }

  ///changePasswordVisibility

  IconData suffix = Icons.visibility;
  bool isPasswordShow = true;
  void changePasswordVisibility()
  {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow ? Icons.visibility_off : Icons.visibility ;
    emit(ChangePasswordVisibility());
  }




  ///basic logic
  bool check=false;
  void changeLengthText()
  {
    check = !check;
    emit(ShopChangeState());
  }











}
