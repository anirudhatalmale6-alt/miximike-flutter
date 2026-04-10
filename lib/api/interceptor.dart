import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/local_storage.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    bool withUserCredentials = options.extra['withUserCredentials'] ?? false;
    bool withWooCommerceCredentials = options.extra['withWooCommerceCredentials'] ?? false;

    if (withUserCredentials) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      String? authorization = localStorage.getString(LocalStorage.authorization);

      if (authorization != null) {
        options.headers['Authorization'] = 'Basic $authorization';
      }
    }

    if (withWooCommerceCredentials) {
      String consumerKey = dotenv.env['WOOCOMMERCE_CONSUMER_KEY'] as String;
      String consumerSecretKey = dotenv.env['WOOCOMMERCE_CONSUMER_SECRET'] as String;

      options.headers['Authorization'] = 'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecretKey'))}';
    }

    super.onRequest(options, handler);
  }
}

