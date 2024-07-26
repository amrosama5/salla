import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/cart_screen/cubit/cart_cubit.dart';
import 'package:shop_app/modules/cart_screen/cubit/cart_state.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'cubit/favorites_cubit.dart';
import 'cubit/favorites_state.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
  listener: (context, state) {},
  builder: (context, state) {
    return BlocConsumer<FavoritesCubit, FavoritesState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: ConditionalBuilder(
              condition: FavoritesCubit.get(context).getFavoritesModel != null,
              builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 150,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children:
                              [
                                Image(
                                  image: NetworkImage(
                                    FavoritesCubit.get(context)
                                        .getFavoritesModel!
                                        .data
                                        .data[index]
                                        .product
                                        .image,
                                  ),
                                ),
                                if (FavoritesCubit.get(context).getFavoritesModel!.data.data[index].product.discount>0)
                                  Container(
                                    color: Colors.red,
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 5),
                                    child: const Text(
                                      'DISCOUNT',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                              ]),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Text(
                                FavoritesCubit.get(context)
                                    .getFavoritesModel!
                                    .data
                                    .data[index]
                                    .product
                                    .name,
                                style: const TextStyle(fontSize: 22),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    FavoritesCubit.get(context)
                                        .getFavoritesModel!
                                        .data
                                        .data[index]
                                        .product
                                        .price
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 17, color: kPrimaryColor),
                                  ),
                                  const Spacer(),
                                  if (FavoritesCubit.get(context).getFavoritesModel!.data.data[index].product.discount>0)
                                    Text(
                                      FavoritesCubit.get(context)
                                        .getFavoritesModel!
                                        .data
                                        .data[index]
                                        .product
                                        .oldPrice
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  const Spacer(
                                    flex: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: kPrimaryColor,
                                    child: IconButton(
                                      onPressed: ()
                                      {
                                        FavoritesCubit.get(context).postFavoritesData(
                                          productId: FavoritesCubit.get(context)
                                              .getFavoritesModel!
                                              .data
                                              .data[index]
                                              .product
                                              .id,
                                          context: context
                                        );
                                      },
                                      icon: const Icon(
                                        color: Colors.white,
                                        Icons.favorite_border_outlined,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, i) => const Divider(
                  endIndent: 20,
                  indent: 20,
                  thickness: 2,
                ),
                itemCount:
                FavoritesCubit.get(context).getFavoritesModel!.data.data.length,
              ),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );
  },
);
  }
}
