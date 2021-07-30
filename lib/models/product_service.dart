import 'package:dio/dio.dart';
import 'package:fabric_app/models/product_model.dart';
import 'package:fabric_app/models/sliders_model.dart';
import 'package:fabric_app/src/services/auth_service.dart';
import 'package:flutter/foundation.dart';

import 'categories_model.dart';

class ProductService {
  static const apiUrl = 'http://192.168.10.10:8000/api';
      // kDebugMode
      // ? 'http://192.168.212.183:8000/api'
      // :
      // 'http://ecom-api.polobaaz.com/api';

  void categories() {
    void getHttp() async {
      try {
        var response = await Dio().get('$apiUrl/categories');
        return response.data.map((e) => Categories.fromJson(e)).toList();
      } catch (e) {
        print('$apiUrl/categories');
        print(e);
        rethrow;
      }
    }
  }

  orderProducts(String id) async {
    try {
      var response = await Dio().get('$apiUrl/order-products/$id');
      return response.data;
    } catch (e) {
      print('$apiUrl/orders');
      print(e);
      rethrow;
    }
  }

  orders() async {
    try {
      var response = await Dio().get('$apiUrl/orders/${AuthService.user.id}');
      return response.data;
    } catch (e) {
      print('$apiUrl/orders');
      print(e);
      rethrow;
    }
  }

  Future<List<SliderModel>> sliders() async {
    try {
      var response = await Dio().get('$apiUrl/sliders');
      return response.data
          .map((e) => SliderModel.fromJson(e))
          .toList()
          .cast<SliderModel>();
    } catch (e) {
      print('$apiUrl/sliders');
      rethrow;
    }
  }

  Future<List<Product>> getAllNewArrivalProducts() async {
    try {
      var response = await Dio().get('$apiUrl/get-all-new-arrival-products');
      return response.data['data']
          .map((e) => Product.fromJson(e))
          .toList()
          .cast<Product>();
    } on Error catch (e) {
      print('$apiUrl/get-all-new-arrival-products');
      rethrow;
    }
  }

  Future<List<Product>> getProductsByCategory(int id) async {
    try {
      var response = await Dio().get('$apiUrl/get-products-by-category/$id');
      return response.data['data']
          .map((e) => Product.fromJson(e))
          .toList()
          .cast<Product>();
    } on Error catch (e) {
      print('$apiUrl/get-products-by-category/$id');
      print(e.stackTrace);
      rethrow;
    }
  }

  Future<List<Product>> getAllHotProducts() async {
    try {
      var response = await Dio().get('$apiUrl/get-all-hot-products');
      return response.data.map((e) => Product.fromJson(e)).toList();
    } on Error catch (e) {
      print('$apiUrl/get-all-hot-products');
      print(e.stackTrace);
      rethrow;
    }
  }

  void register() {}

  void login() {}

  void shipping() {}

  void makePayment() {}
}
