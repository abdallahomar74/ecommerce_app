import 'package:ecommerce_app/layouts/layout_screen.dart';
import 'package:ecommerce_app/modules/screens/profile_screen/change_password_screen.dart';
import 'package:ecommerce_app/modules/screens/authentication_screens/login_screen.dart';
import 'package:ecommerce_app/modules/screens/authentication_screens/register_screen.dart';
import 'package:ecommerce_app/modules/screens/home_screen/home_screen.dart';
import 'package:ecommerce_app/modules/screens/profile_screen/profile_screen.dart';
import 'package:ecommerce_app/modules/screens/profile_screen/update_user_data_screen.dart';
import 'package:ecommerce_app/modules/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class MyRoute {
  
static  List<Route> initRoutes = [
    MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const SplashScreen(),
         ),
  ];



static  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch(settings.name){
      case 'splash' :return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const SplashScreen(),
      );
      case 'register' :return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>  RegisterScreen(),
      );
      case 'login' :return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>  LoginScreen(),
      );
      case 'home' :return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>  const HomeScreen(),
      );
      case 'profile' :return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>  const ProfileScreen(),
      );
      case 'layout' :return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>  const  LayoutScreen(),
      );
      case 'changepassword' :return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>   ChangePasssword(),
      );
      case 'updatedata' :return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>   UpdateData(),
      );
      default :return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>  LoginScreen(),
      );
    }
    
  }
}
