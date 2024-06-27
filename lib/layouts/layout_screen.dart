import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:ecommerce_app/layouts/layout_cubit/layout_cubit.dart';
import 'package:ecommerce_app/layouts/layout_cubit/layout_states.dart';
import 'package:ecommerce_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Image.asset("assets/images/logo.png",
                  height: 80, width: 140, color: Colors.white),
              backgroundColor: Colors.indigo,
              titleSpacing: 25,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                cubit.changeBottomNavIndex(index: 4);
              },
              backgroundColor: secondColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(
                Icons.home,
                color: cubit.bottomNavIndex == 4
                    ?  const Color.fromARGB(255, 167, 134, 255)
                    : Colors.white,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar(
              icons: const [
                Icons.category,
                Icons.favorite,
                Icons.shopping_cart,
                Icons.person
              ],
              activeIndex: cubit.bottomNavIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.softEdge,
              leftCornerRadius: 32,
              rightCornerRadius: 32,
              onTap: (index) {
                cubit.changeBottomNavIndex(index: index);
              },
              backgroundColor: secondColor,
              activeColor: const Color.fromARGB(255, 167, 134, 255),
              inactiveColor: Colors.white,
              backgroundGradient: const LinearGradient(
                colors: [secondColor, mainColor],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.4, 0.7],
                tileMode: TileMode.repeated,
              ),
            ),
            body: cubit.layoutScreens[cubit.bottomNavIndex],
          ),
        );
      },
    );
  }
}
