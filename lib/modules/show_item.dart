import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/shop_cubit.dart';
import 'package:shop_app/modules/FavouritesScreen/cubit/favorites_state.dart';
import 'package:shop_app/modules/cart_screen/cubit/cart_state.dart';
import 'package:shop_app/shared/componets/widgets.dart';
import 'package:shop_app/shared/styles/colors.dart';
import '../models/home_model.dart';
import 'FavouritesScreen/cubit/favorites_cubit.dart';
import 'ProductsScreen/cubit/products_cubit.dart';
import 'cart_screen/cubit/cart_cubit.dart';

class ShowItem extends StatelessWidget
{
  ShowItem({super.key, required this.index,this.productId});
  int index;
  int? productId;
  String selectedNumber = "1";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
  listener: (context, state) {},
  builder: (context, state) {
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<ProductsData> shopCubit =
            ProductsCubit.get(context).homeModel!.data.products;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .3,
                    width: double.infinity,
                    child: Image(
                      image: NetworkImage(ProductsCubit.get(context).homeModel!.data.products[index].image),
                    ),
                  ),
                  if (shopCubit[index].discount != 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        color: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                              shopCubit[index].name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w400),
                            )),
                            Column(
                              children: [
                                Text(
                                  '${shopCubit[index].price} EGP',
                                  style: const TextStyle(
                                      fontSize: 20, color: kPrimaryColor),
                                ),
                                if (shopCubit[index].discount != 0)
                                  Text(
                                    '${shopCubit[index].old_price}EGP',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.red,
                                        decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                              child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Text(
                                shopCubit[index].description,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: ShopCubit.get(context).check == true
                                    ? 1000
                                    : 8,
                                overflow: TextOverflow.ellipsis,
                              ),
                              TextButton(
                                onPressed: () {
                                  ShopCubit.get(context).changeLengthText();
                                },
                                child: Text(
                                    ShopCubit.get(context).check == false
                                        ? 'Read more'
                                        : 'less than'),
                              )
                            ],
                          )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: ()
                                {
                                  FavoritesCubit.get(context).postFavoritesData(productId:productId!, context: context);
                                },
                                icon:ProductsCubit.get(context).favorites[productId]==true?const Icon(Icons.favorite,color: Colors.red,size: 35,):const Icon(Icons.favorite_border_outlined,size: 35,),
                            ),
                            CustomMaterialButton(
                              textStyle:  const TextStyle(color: Colors.white),
                              color:  ProductsCubit.itemsInCart[productId]  == true ?Colors.green :kPrimaryColor,
                              text: ProductsCubit.itemsInCart[productId]  == true ?  'Added to cart' : 'Add to Cart',
                              width: MediaQuery.of(context).size.width / 1.7,
                              borderRadius: BorderRadius.circular(20),
                              widget:ProductsCubit.itemsInCart[productId]  == true ?const Icon(Icons.done,color: Colors.white,) :const Icon(Icons.add_shopping_cart,color: Colors.white,),
                              onPressed: ()
                              {
                                CartCubit.get(context).addCartData(productId: productId!);
                                CartCubit();
                              },
                            ),
                            // DropdownButton(
                            //   items: ["1", "2", "3", '4', '5']
                            //       .map((e) => DropdownMenuItem(
                            //             value: e,
                            //             child: Text(e),
                            //           ))
                            //       .toList(),
                            //   onChanged: (_) {
                            //     ShopCubit.get(context).changeSelectItem(_!);
                            //     print(_);
                            //   },
                            //   value: ShopCubit.get(context).selectedNumber,
                            // ),
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
        );
      },
    );
  },
);
  }
}
