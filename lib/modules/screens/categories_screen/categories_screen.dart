import 'package:ecommerce_app/layouts/layout_cubit/layout_cubit.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoryData =
        BlocProvider.of<LayoutCubit>(context).categories;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: GridView.builder(
        itemCount: categoryData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.02),
            ),
            child: Column(
              children: [
                Expanded(
                  child:
                      Image.network(categoryData[index].url!, fit: BoxFit.fill),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(categoryData[index].title!,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
              ],
            ),
          );
        },
      ),
    ));
  }
}
