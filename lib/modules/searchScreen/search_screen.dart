import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/FavouritesScreen/cubit/favorites_cubit.dart';
import 'package:shop_app/modules/FavouritesScreen/cubit/favorites_state.dart';
import 'package:shop_app/modules/searchScreen/cubit/search_cubit.dart';
import 'package:shop_app/shared/componets/widgets.dart';
import '../../shared/styles/colors.dart';
import 'cubit/search_state.dart';

class SearchScreen extends StatelessWidget
{

  var textController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<FavoritesCubit, FavoritesState>(
  listener: (context, state) {},
  builder: (context, state) {
    return BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(

            ),
            endDrawer: Drawer(

            ),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomFormField(
                    paddingOutForm: const EdgeInsets.all(20),
                    labelText: 'Search',
                    hintText:'Search' ,
                    prefixIcon: const Icon(Icons.search),
                    keyboardType: TextInputType.text,
                    validator: (value)
                    {
                      if(value!.isEmpty){
                        return 'You must enter word to search';
                      }
                      return null;
                    },
                    onSubmitted: (value)
                    {
                      if(formKey.currentState!.validate())
                      {
                        SearchCubit.get(context).searchData(
                            text:value
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if(state is SearchLoadingState)
                    const LinearProgressIndicator(),
                  if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
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
                                child: Image(
                                  image: NetworkImage(
                                    SearchCubit.get(context)
                                        .searchModel!
                                        .data
                                        .data[index]
                                        .image,
                                  ),
                                ),
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
                                      SearchCubit.get(context)
                                          .searchModel!
                                          .data
                                          .data[index]
                                          .name,
                                      style: const TextStyle(fontSize: 22),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          SearchCubit.get(context)
                                              .searchModel!
                                              .data
                                              .data[index]
                                              .price
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 17, color: kPrimaryColor),
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
                      itemCount: SearchCubit.get(context).searchModel!.data.data.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
  },
),
    );
  }
}
