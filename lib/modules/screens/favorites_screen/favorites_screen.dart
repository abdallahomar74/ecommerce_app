import 'package:ecommerce_app/layouts/layout_cubit/layout_cubit.dart';
import 'package:ecommerce_app/layouts/layout_cubit/layout_states.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12.5),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    cubit.filterFavoriteProducts(input: value);
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 7.5, horizontal: 12),
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: cubit.refreshFavoriteScreen,
                    child: cubit.favorites.isEmpty
                        ? const Center(
                            child: Text("add items to favorites"),
                          )
                        : ListView.builder(
                            itemCount: cubit.filteredFavoriteProducts.isEmpty
                                ? cubit.favorites.length
                                : cubit.filteredFavoriteProducts.length,
                            itemBuilder: (context, index) {
                              return _favoriteProductItems(
                                  cubit: cubit,
                                  model: cubit.filteredFavoriteProducts.isEmpty
                                      ? cubit.favorites[index]
                                      : cubit.filteredFavoriteProducts[index]);
                            },
                          ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _favoriteProductItems(
    {required ProductModel model, required LayoutCubit cubit}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.grey.withOpacity(0.2),
    ),
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12.5),
    child: Row(
      children: [
        Image.network(
          model.image!,
          width: 100,
          height: 100,
          fit: BoxFit.fill,
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                model.name!,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                    overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${model.price!} \$"),
                  const SizedBox(
                    width: 5,
                  ),
                  if (model.price != model.oldPrice)
                    Text(
                      "${model.oldPrice!} \$",
                      style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    onPressed: () {
                      // add | remove
                      cubit.addOrRemoveFavorites(
                          productId: model.id.toString());
                    },
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: mainColor,
                    child: const Text("Remove"),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(30)),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {
                          cubit.addOrRemoveCarts(
                              productId: model.id.toString());
                        },
                        icon: Icon(Icons.shopping_cart,
                            color: cubit.cartId.contains(model.id.toString())
                                ? mainColor
                                : Colors.grey),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}
