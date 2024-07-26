import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/categories_cubit.dart';
import 'cubit/categories_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: ConditionalBuilder(
              condition: CategoriesCubit.get(context).categoriesModel!=null,
              builder: (context) => ListView.separated(
                  itemBuilder: (context, i) => buildCategoriesItems(
                      image: CategoriesCubit.get(context).categoriesModel!.data.data[i].image,
                      name: CategoriesCubit.get(context).categoriesModel!.data.data[i].name),
                  separatorBuilder: (context, i) => const Divider(
                        height: 2,
                        color: Colors.black,
                        indent: 20,
                        endIndent: 20,
                      ),
                  itemCount: CategoriesCubit.get(context).categoriesModel!.data.data.length
              ),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );
  }

  Widget buildCategoriesItems({required String name, required String image}) =>
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 130,
              width: 130,
              child: Image(
                image: NetworkImage(
                  image,
                ),
              ),
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward))
          ],
        ),
      );
}
