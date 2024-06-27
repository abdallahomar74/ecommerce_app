import 'package:ecommerce_app/modules/screens/splash_screen/splash_cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..initSplash(),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToLayout) {
            Navigator.pushReplacementNamed(context, 'layout');
          } else if (state is SplashNavigateToLogin) {
            Navigator.pushReplacementNamed(context, 'login');
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.lightBlueAccent],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.4, 0.7],
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Expanded(
                          child: Center(
                        child: Image.asset(
                          "assets/images/splash.png",
                          height: 250,
                          width: 250,
                        ),
                      )),
                      const Text(
                        "Developed by Abdallah Mostafa",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
