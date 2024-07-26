import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/FavouritesScreen/cubit/favorites_state.dart';
import 'package:shop_app/modules/show_item.dart';
import 'package:shop_app/shared/componets/widgets.dart';
import 'package:shop_app/shared/styles/colors.dart';
import '../../models/get_cart_model.dart';
import '../FavouritesScreen/cubit/favorites_cubit.dart';
import '../ProductsScreen/cubit/products_cubit.dart';
import '../ProductsScreen/cubit/products_state.dart';
import 'cubit/cart_cubit.dart';
import 'cubit/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {},
          builder: (context, state) {
            return BlocConsumer<FavoritesCubit, FavoritesState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Scaffold(
                  body: ConditionalBuilder(
                    condition: CartCubit.get(context).getCartModel != null,
                    builder: (context) => ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, i) => buildCartItem(
                          CartCubit.get(context)
                              .getCartModel!
                              .cartDetails
                              .products![i],
                          context,
                          i),
                      separatorBuilder: (context, i) => const Divider(
                        thickness: 3,
                        indent: 20,
                        endIndent: 20,
                      ),
                      itemCount: CartCubit.get(context)
                          .getCartModel!
                          .cartDetails
                          .products!
                          .length,
                    ),
                    fallback: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  bottomNavigationBar: ConditionalBuilder(
                    condition: CartCubit.get(context).getCartModel != null,
                    builder: (context) => Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      height: 160,
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Subtotal (1 items)',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.grey),
                                      ),
                                      Text(
                                        '${CartCubit.get(context).getCartModel!.cartDetails.subTotal.round()}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Shipping Fee',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        'Free',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.green),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'TOTAL',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${CartCubit.get(context).getCartModel!.cartDetails.total.round()}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: CustomMaterialButton(
                              text: 'Check Out',
                              widget: const SizedBox(
                                height: 0,
                                width: 0,
                              ),
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                              color: Colors.green,
                              onPressed: () {},
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    fallback: (context) => const SizedBox(),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget buildCartItem(ProductInCart productModel, context, i) => InkWell(
        onTap: () {
          navigatTo(context: context, widget: ShowItem(index: i));
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .232,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.9,
                    height: MediaQuery.of(context).size.height / 6.5,
                    child: Image(
                      image: NetworkImage(productModel.product.image),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 50,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 6.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            productModel.product.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 3,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productModel.product.price.toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor),
                              ),
                              if (productModel.product.discount != 0)
                                Text(
                                  productModel.product.old_price.toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (productModel.quantity > 1) {
                            CartCubit.get(context).updateCartData(
                                quantity: productModel.quantity - 1,
                                inCartProductId: productModel.inCartID);
                          }
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        productModel.quantity.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (productModel.quantity >= 1) {
                            CartCubit.get(context).updateCartData(
                              quantity: productModel.quantity + 1,
                              inCartProductId: productModel.inCartID,
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          CartCubit.get(context)
                              .addCartData(productId: productModel.product.id)
                              .then((value) {
                            CartCubit.get(context).getCartData();
                            if (ProductsCubit.get(context)
                                    .favorites[productModel.product.id] ==
                                false) {
                              FavoritesCubit.get(context).postFavoritesData(
                                  productId: productModel.product.id,
                                  context: context);
                              CartCubit.get(context).getCartData();
                            }
                          });
                        },
                        icon: ProductsCubit.get(context)
                                    .favorites[productModel.product.id] ==
                                true
                            ? const Icon(Icons.favorite, color: Colors.red)
                            : Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.grey.shade700,
                              ),
                      ),
                      TextButton(
                        onPressed: () {
                          CartCubit.get(context)
                              .addCartData(productId: productModel.product.id)
                              .then((value) {
                            FavoritesCubit.get(context).postFavoritesData(
                                productId: productModel.product.id,
                                context: context);
                          });
                        },
                        child: Text(
                          'Move to Wishlist',
                          style: TextStyle(
                              fontSize: 10, color: Colors.grey.shade700),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: ()
                        {
                          CartCubit.get(context).addCartData(productId: productModel.product.id).then((value) {
                            CartCubit.get(context).getCartData();
                          });
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          CartCubit.get(context).addCartData(productId: productModel.product.id).then((value) {
                            CartCubit.get(context).getCartData();
                          });
                        },
                        child: const Text(
                          'Remove',
                          style: TextStyle(fontSize: 10, color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
