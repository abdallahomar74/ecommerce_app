import 'package:ecommerce_app/layouts/layout_cubit/layout_cubit.dart';
import 'package:ecommerce_app/layouts/routing/routes.dart';
import 'package:ecommerce_app/modules/screens/authentication_screens/aut_cubit/auth_cubit.dart';
import 'package:ecommerce_app/shared/constans/constans.dart';
import 'package:ecommerce_app/shared/network/local_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.chacheInitialization();
   token = await CacheNetwork.getCacheData(key: 'token');
  currentPassword = await CacheNetwork.getCacheData(key: 'password');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(create: (context) => LayoutCubit()..getCarts()..getBannersData()..getCategoriesData()..getProductsData()..getFavoritesData()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: MyRoute.onGenerateRoute,
            onGenerateInitialRoutes: (_) => MyRoute.initRoutes));
  }
}
