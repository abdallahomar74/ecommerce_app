import 'dart:convert';

import 'package:ecommerce_app/modules/screens/authentication_screens/aut_cubit/auth_states.dart';
import 'package:ecommerce_app/shared/constans/constans.dart';
import 'package:ecommerce_app/shared/network/local_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

//register http
  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/register"),
        headers: {
          'lang': 'en',
        },
        body: {
          'name': name,
          'phone': phone,
          'email': email,
          'password': password,
        });
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      emit(RegisterSuccessState());
    } else {
      emit(FailedToRegisterState(message: responseBody['message']));
    }
  }

  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/login"),
        body: {
          'email': email,
          'password': password,
        },
        headers: {
          'lang': 'en',
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["status"] == true) {
          // debugPrint("User Login Success And His Data is : $data");
          await CacheNetwork.insertToCache(key: "token", value: data['data']['token']);
          await CacheNetwork.insertToCache(key: "password", value: password);
          token = await CacheNetwork.getCacheData(key: "token");
          currentPassword = await CacheNetwork.getCacheData(key: "password");
          emit(LoginSuccessState());
        } else {
          debugPrint("Failed To Login and The reason is : ${data['message']}");
          emit(FailedToLoginState(message: data['message']));
        }
      }
    } catch (e) {
      emit(FailedToLoginState(message: e.toString()));
    }
  }
}
