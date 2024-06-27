import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/layouts/layout_cubit/layout_cubit.dart';
import 'package:ecommerce_app/layouts/layout_cubit/layout_states.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/shared/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: RefreshIndicator(
              onRefresh: cubit.refreshHomeScreen,
              child: ListView(
                
                shrinkWrap: true,
                children: [
                  TextFormField(
                    onChanged: (input) {
                      cubit.filterProducts(input: input);
                    },
                    decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        fillColor: Colors.grey.withOpacity(0.2),
                        filled: true,
                        contentPadding: EdgeInsets.zero),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  cubit.banners.isEmpty
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : SizedBox(
                          height: 125,
                          width: double.infinity,
                          child: CarouselSlider.builder(
                            itemCount: 6,
                            itemBuilder: (BuildContext context, int itemIndex,
                                    int pageViewIndex) =>
                                Image.network(
                              cubit.banners[itemIndex].url!,
                              fit: BoxFit.fill,
                            ),
                            options: CarouselOptions(
                              viewportFraction: 0.6,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Categories",
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  cubit.categories.isEmpty
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : SizedBox(
                          height: 70,
                          width: double.infinity,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 20,
                              );
                            },
                            physics: const BouncingScrollPhysics(),
                            itemCount: cubit.categories.length,
                            itemBuilder: (context, index) {
                              return CircleAvatar(
                                radius: 35,
                                child: Image.network(
                                  cubit.categories[index].url!,
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Products",
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  cubit.products.isEmpty
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 0.7),
                          shrinkWrap: true,
                          itemCount: cubit.filteredProducts.isEmpty
                              ? cubit.products.length
                              : cubit.filteredProducts.length,
                          itemBuilder: (context, index) {
                            return _productItem(
                                model: cubit.filteredProducts.isEmpty
                                    ? cubit.products[index]
                                    : cubit.filteredProducts[index],
                                cubit: cubit);
                          },
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _productItem({required ProductModel model, required LayoutCubit cubit}) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(0.2),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                model.image!,
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              model.name!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${model.price!} \$",
                            style: const TextStyle(fontSize: 13),
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.price != model.oldPrice)
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${model.oldPrice!} \$",
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12.5,
                                decoration: TextDecoration.lineThrough),
                          ),
                        )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    cubit.addOrRemoveFavorites(productId: model.id.toString());
                  },
                  icon: Icon(
                    Icons.favorite,
                    size: 20,
                    color: cubit.favoriteId.contains(model.id.toString())
                        ? Colors.red
                        : Colors.grey,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(30)
        ),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          
          child: IconButton(
            onPressed: () {
              cubit.addOrRemoveCarts(productId: model.id.toString());
            },
            icon: Icon(Icons.shopping_cart,
                color: cubit.cartId.contains(model.id.toString())
                    ? mainColor
                    : Colors.grey),
          ),
        ),
      )
    ],
  );
}
