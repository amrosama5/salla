import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/cart_model.dart';
import '../../../models/get_cart_model.dart';
import '../../../shared/componets/constans.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../ProductsScreen/cubit/products_cubit.dart';
import 'cart_state.dart';


class CartCubit extends Cubit<CartState>
{
  CartCubit() : super(CartInitial());


  static CartCubit get(context) => BlocProvider.of(context);


  /// api Cart Screen
  AddToCartModel? addToCartModel;
  Future addCartData({required  productId})
  {

    emit(ShopLoadingPostCartDataState());
    return DioHelper.postData(
      path: 'carts',
      data:
      {
        'product_id':productId
      },
      token: token,
    ).then((value)
    {
      ProductsCubit.itemsInCart[productId] = !ProductsCubit.itemsInCart[productId]!;
      addToCartModel = AddToCartModel.fromJson(value.data);
      // homeModel!.data.products.forEach((element)
      // {
      //   itemsInCart.addAll({
      //     element.id: element.in_cart
      //   });
      // });
      if(addToCartModel!.status)
      {
        getCartData();
      }else
      {

        ProductsCubit.itemsInCart[productId] = !ProductsCubit.itemsInCart[productId]!;
      }
      emit(ShopSuccessPostCartDataState());
      //inCartId=value.data;
    }
    ).catchError((ex)
    {
      print(ex.toString());
      emit(ShopErrorPostCartDataState());
    });
  }

  GetCartModel? getCartModel;
  Future  getCartData()
  {
    emit(ShopLoadingGetCartDataState());
    return DioHelper.getData(url: 'carts', token: token).then((value)
    {
      getCartModel = GetCartModel.fromJson(value.data);
      emit(ShopSuccessGetCartDataState(getCart: getCartModel));

    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorGetCartDataState());
    });
  }

  void updateCartData({
    required int inCartProductId,
    required int quantity
  })
  {
    emit(ShopLoadingUpdateCartDataState());
    DioHelper.updateData(
      path: 'carts/$inCartProductId',
      data:
      {
        'quantity':  quantity
      },
      token: token,
    ).then((value)
    {
      if(value.data['status'])
      {
        getCartData();
      }
      emit(ShopSuccessUpdateCartDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateCartDataState());
    });
  }

  void deleteProductFromCart(int inCartProductID) {
    emit(ShopLoadingDeleteCartDataState());
    DioHelper.updateData(
      token: token,
      path: 'carts/$inCartProductID',
    ).then((value) {
      if (value.data['status'])
      {
        getCartData();
      }
      emit(ShopSuccessDeleteCartDataState());
      getCartData();
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorDeleteCartDataState());
    });
  }
}
