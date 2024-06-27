import 'package:ecommerce_app/layouts/layout_cubit/layout_cubit.dart';
import 'package:ecommerce_app/layouts/layout_cubit/layout_states.dart';
import 'package:ecommerce_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      body: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 35, right: 10),
            child: Column(
              children: [
                Expanded(
                  child: cubit.cartItems.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                          onRefresh: cubit.refreshCartScreen,
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: cubit.cartItems.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Image.network(
                                      cubit.cartItems[index].image!,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.fill,
                                    ),
                                    const SizedBox(width: 12.5),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${cubit.cartItems[index].name!}\$",
                                            style: const TextStyle(
                                                color: mainColor,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  "${cubit.cartItems[index].price!}\$"),
                                              if (cubit
                                                      .cartItems[index].price !=
                                                  cubit.cartItems[index]
                                                      .oldPrice)
                                                Text(
                                                  "${cubit.cartItems[index].oldPrice!}\$",
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              OutlinedButton(
                                                onPressed: () {
                                                  cubit.addOrRemoveFavorites(
                                                      productId: cubit
                                                          .cartItems[index].id
                                                          .toString());
                                                },
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: cubit.favoriteId
                                                          .contains(cubit
                                                              .cartItems[index]
                                                              .id
                                                              .toString())
                                                      ? Colors.red
                                                      : Colors.grey,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  cubit.addOrRemoveCarts(
                                                      productId: cubit
                                                          .cartItems[index].id
                                                          .toString());
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ),
                const SizedBox(height: 15,),
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: Text(
                    "Total Price =  ${cubit.totalPrice} \$",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
