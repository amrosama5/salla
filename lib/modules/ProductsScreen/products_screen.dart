import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/FavouritesScreen/cubit/favorites_state.dart';
import 'package:shop_app/modules/ProductsScreen/cubit/products_cubit.dart';
import 'package:shop_app/shared/componets/widgets.dart';
import 'package:shop_app/shared/styles/colors.dart';
import '../CategoriesScreen/cubit/categories_cubit.dart';
import '../CategoriesScreen/cubit/categories_state.dart';
import '../FavouritesScreen/cubit/favorites_cubit.dart';
import '../show_item.dart';
import 'cubit/products_state.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});
  @override
  Widget build(BuildContext context) 
  {
    return BlocConsumer<FavoritesCubit, FavoritesState>(
    listener: (context, state) {},
    builder: (context, state) {
    return BlocConsumer<ProductsCubit, ProductsState>(
    listener: (context, state) {},
    builder: (context, state) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
    listener: (context, state){},
    builder: (context, state) {
    return Scaffold(
            backgroundColor: Colors.white,
            body: ConditionalBuilder(
                condition: ProductsCubit.get(context).homeModel != null && CategoriesCubit.get(context).categoriesModel != null,
                builder: (context) => productsBuilder(
                    ProductsCubit.get(context).homeModel,
                    CategoriesCubit.get(context).categoriesModel!,
                    context),
                fallback: (context) => const Center(
                      child: CircularProgressIndicator(),
                    )),
          );

  },
);
  },
);
  },
);
  }

  Widget productsBuilder(
      HomeModel? homeModel, CategoriesModel? categoriesModel, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items: homeModel!.data.banners
                  .map((e) => ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image(
                          image: NetworkImage(e.image.toString()),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 200,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1.0)),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                  ),
                ),
                buildCategoriesListView(categoriesModel),
                const SizedBox(
                  height: 10,
                ),
                const Text('New Products',
                    style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,),),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 3,
              childAspectRatio: 1 / 1.8,
              children: List.generate(
                homeModel.data.products.length,
                    (index) => buildGridProducts(homeModel.data.products[index], context, index = index,),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoriesListView(CategoriesModel? categoriesModel) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => GestureDetector(
              onTap: ()
              {

              },
              child: SizedBox(
                height: 130,
                width: 130,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(
                        categoriesModel.data.data[index].image,
                      ),
                      height: 130,
                      width: 130,
                    ),
                    Container(
                      color: Colors.black.withOpacity(.6),
                      width: double.infinity,
                      height: 20,
                      child: Text(
                        categoriesModel.data.data[index].name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
            itemCount: categoriesModel!.data.data.length,
          ),
        ),
      );
  Widget buildGridProducts(ProductsData productsData, context, index) =>
      InkWell(
        onTap: ()
        {
          navigatTo(context: context, widget: ShowItem(index: index,productId:productsData.id));
          print(index);
          print(productsData.id);
        },
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
            [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(productsData.image),
                    width: double.infinity,
                    height: 200,
                  ),
                  if (productsData.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productsData.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1.4,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:
                              [
                                Text(
                                  productsData.price.toString(),
                                  textAlign: TextAlign.end,
                                  style:
                                  const TextStyle(
                                      fontSize: 20,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                const Text('EGP',maxLines: 1,overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                if (productsData.discount != 0)
                                  Text(
                                    '${productsData.old_price}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                const SizedBox(
                                  width: 5,
                                ),
                                if (productsData.discount != 0)
                                  Text(
                                    '${productsData.discount} OFF',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.red,
                                    ),
                                  ),
                              ],
                            )
                          ],
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor:
                        ProductsCubit.get(context).favorites[productsData.id] ==
                                    false
                                ? Colors.grey
                                : kPrimaryColor,
                        child: IconButton(
                            color: Colors.white,
                            onPressed: ()
                            {
                              FavoritesCubit.get(context).postFavoritesData(
                                productId: productsData.id,
                                context: context
                              );
                            },
                            icon:const Icon(Icons.favorite_border_outlined)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
