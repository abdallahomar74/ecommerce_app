import 'dart:convert';
import 'package:ecommerce_app/layouts/layout_cubit/layout_states.dart';
import 'package:ecommerce_app/models/banner_model.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/modules/screens/cart_screen/cart_screen.dart';
import 'package:ecommerce_app/modules/screens/categories_screen/categories_screen.dart';
import 'package:ecommerce_app/modules/screens/favorites_screen/favorites_screen.dart';
import 'package:ecommerce_app/modules/screens/home_screen/home_screen.dart';
import 'package:ecommerce_app/modules/screens/profile_screen/profile_screen.dart';
import 'package:ecommerce_app/shared/constans/constans.dart';
import 'package:ecommerce_app/shared/network/local_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(InitialLayoutState());

  List<Widget> layoutScreens = [
    const CategoriesScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    const ProfileScreen(),
    const HomeScreen(),
  ];

  int bottomNavIndex = 4;
  void changeBottomNavIndex({required int index}) {
    bottomNavIndex = index;
    emit(ChangeBottomNavIndexState());
  }

  // method to get user data
  UserModel? userModel;
  Future<void> getUserData() async {
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/profile"),
      headers: {
        "Authorization": token!,
        "lang": "en",
      },
    );
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      userModel = UserModel.fromJson(data: responseData['data']);

      emit(GetUserDataSuccessState());
    } else {
      emit(FailedToGetUserDataState(error: responseData['message']));
    }
  }

  // method to get Banners data
  List<BannerModel> banners = [];
  Future<void> getBannersData() async {
    banners.clear();
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/banners"),
      headers: {
        "lang": "en",
      },
    );
    final responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']) {
        banners.add(BannerModel.fromJson(data: item));
      }
      emit(GetBannersDataSuccessState());
    } else {
      emit(FailedToGetBannersDataState());
    }
  }

  List<CategoryModel> categories = [];
  Future<void> getCategoriesData() async {
    categories.clear();
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/categories"),
      headers: {
        "lang": "en",
      },
    );
    final responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['data']) {
        categories.add(CategoryModel.fromJson(data: item));
      }
      emit(GetCategoriesDataSuccessState());
    } else {
      emit(FailedToGetCategoriesDataState());
    }
  }

  List<ProductModel> products = [];
  Future<void> getProductsData() async {
    products.clear();
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/home"),
      headers: {
        "lang": "en",
        "Authorization": token!,
      },
    );
    var responseBody = jsonDecode(response.body);

    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['products']) {
        products.add(ProductModel.fromJson(data: item));
      }
      emit(GetProductsDataSuccessState());
    } else {
      emit(FailedToGetProductsDataState());
    }
  }

  List<ProductModel> filteredProducts = [];
  void filterProducts({required String input}) {
    filteredProducts = products
        .where((element) =>
            element.name!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    emit(FilterProductsSuccessState());
  }

  Future<void> refreshHomeScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    emit(RefreshLoadingState());
    await getBannersData();
    await getCategoriesData();
    await getProductsData();
    filteredProducts.clear();
    emit(RefreshSuccessState());
  }

  Set<String> favoriteId = {};
  List<ProductModel> favorites = [];
  Future<void> getFavoritesData() async {
    favorites.clear();
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/favorites"),
      headers: {
        "lang": "en",
        "Authorization": token!,
      },
    );
    var responseBody = jsonDecode(response.body);

    if (responseBody['status'] == true) {
      for (var items in responseBody["data"]["data"]) {
        favoriteId.add(items["product"]["id"].toString());
        favorites.add(ProductModel.fromJson(data: items['product']));
      }

      emit(GetFavoritesDataSuccessState());
    } else {
      emit(FailedToGetFavoritesDataState());
    }
  }

  void addOrRemoveFavorites({required String productId}) async {
    favorites.clear();
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/favorites"),
        headers: {
          "lang": "en",
          "Authorization": token!,
        },
        body: {
          "product_id": productId
        });
    var responseBody = jsonDecode(response.body);

    if (responseBody['status'] == true) {
      if (favoriteId.contains(productId)) {
        favoriteId.remove(productId);
      } else {
        favoriteId.add(productId);
      }
      await getFavoritesData();
      emit(AddOrRemoveFavoritesSuccessState());
    } else {
      emit(FailedToAddOrRemoveFavoritesState());
    }
  }

  List<ProductModel> filteredFavoriteProducts = [];
  void filterFavoriteProducts({required String input}) {
    filteredFavoriteProducts = favorites
        .where((element) =>
            element.name!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    emit(FilterFavoriteProductsSuccessState());
  }

  Future<void> refreshFavoriteScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    emit(RefreshLoadingState());
    await getFavoritesData();
    filteredFavoriteProducts.clear();
    emit(RefreshSuccessState());
  }

  List<ProductModel> cartItems = [];
  Set<String> cartId = {};
  int totalPrice = 0;
  Future<void> getCarts() async {
    cartItems.clear();
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/carts"),
      headers: {
        "lang": "en",
        "Authorization": token!,
      },
    );
    var responseBody = jsonDecode(response.body);
    totalPrice = responseBody['data']['total'].toInt();
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['cart_items']) {
        cartId.add(item['product']['id'].toString());
        cartItems.add(ProductModel.fromJson(data: item["product"]));
      }
      emit(GetCartsDataSuccessState());
    } else {
      emit(FailedToGetCartsDataState());
    }
  }

  void addOrRemoveCarts({required String productId}) async {
    cartItems.clear();
    Response response = await http
        .post(Uri.parse("https://student.valuxapps.com/api/carts"), headers: {
      "lang": "en",
      "Authorization": token!,
    }, body: {
      "product_id": productId
    });
    var responseBody = jsonDecode(response.body);

    if (responseBody['status'] == true) {
      if (cartId.contains(productId)) {
        cartId.remove(productId);
      } else {
        cartId.add(productId);
      }
      await getCarts();
      emit(AddOrRemoveCartsSuccessState());
    } else {
      emit(FailedToAddOrRemoveCartsState());
    }
  }

  Future<void> refreshCartScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    emit(RefreshLoadingState());
    await getCarts();
    emit(RefreshSuccessState());
  }

  void changePassword(
      {required String userCurrentPassword,
      required String newPassword}) async {
    emit(ChangePasswordLoadingState());
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/change-password"),
        body: {
          "current_password": userCurrentPassword,
          "new_password": newPassword
        },
        headers: {
          "lang": "en",
          "Authorization": token!,
        });
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (responseBody["status"] == true) {
        await CacheNetwork.insertToCache(key: 'password', value: newPassword);
        currentPassword = await CacheNetwork.getCacheData(key: "password");
        emit(ChangePasswordSuccessState());
      } else {
        emit(FailedToChangePasswordWithFailureState(
            error: responseBody["message"]));
      }
    } else {
      emit(FailedToChangePasswordWithFailureState(
          error: "Something went wrong, please try again later."));
    }
  }

  void updateData(
      {required String name,
      required String phone,
      required String email}) async {
    emit(UpdateDataLoadingState());
    try {
      Response response = await http.put(
        Uri.parse("https://student.valuxapps.com/api/update-profile"),
        headers: {
          "lang": "en",
          "Authorization": token!,
        },
        body: {"name": name, "phone": phone, "email": email},
      );
      var responseBody = jsonDecode(response.body);
      if (responseBody["status"] == true) {
        await getUserData();
        emit(UpdateDataSuccessState());
      } else {
        emit(
            FailedToUpdateDataWithFailureState(error: responseBody["message"]));
      }
    } catch (e) {
      emit(FailedToUpdateDataWithFailureState(error: e.toString()));
    }
  }
}
