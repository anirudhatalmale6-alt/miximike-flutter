import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../utils/local_storage.dart';
import 'interceptor.dart';

part 'services/authentication.dart';
part 'services/product.dart';
part 'services/notification.dart';

class Client {
  static final baseUrl = dotenv.env['BASE_SERVICE_URL'] as String;

  static Future<Dio> get dio async => Dio(
      BaseOptions(
        receiveTimeout: const Duration(seconds: 15), // 15 seconds
        connectTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: <String, dynamic>{
          'Content-Type': 'application/json',
          'Cache-Control': 'no-cache',
        },
      )
  )..interceptors.addAll([
    DioInterceptor(),
    DioCacheInterceptor(
      options: await Client.cacheOptions,
    )
  ]);

  static Future<CacheOptions> get cacheOptions async {
    Directory tempDirectory = await getTemporaryDirectory();

    return CacheOptions(
      // A default store is required for interceptor.
      store: HiveCacheStore(
        tempDirectory.path,
        hiveBoxName: 'mixi_mike_cache',
      ),
      // Default.
      policy: CachePolicy.forceCache,
      // Returns a cached response on error but for statuses 401 & 403.
      // Also allows to return a cached response on network errors (e.g. offline usage).
      // Defaults to [null].
      hitCacheOnErrorExcept: [401, 403],
      // Overrides any HTTP directive to delete entry past this duration.
      // Useful only when origin server has no cache config or custom behaviour is desired.
      // Defaults to [null].
      maxStale: const Duration(days: 1),
      // Default. Allows 3 cache sets and ease cleanup.
      priority: CachePriority.high,
      // Default. Body and headers encryption with your own algorithm.
      cipher: null,
      // Default. Key builder to retrieve requests.
      keyBuilder: (RequestOptions request) {
        String uri = request.uri.toString();
        String data = request.data.toString();
        String method = request.method;
        String authorization = request.headers['Authorization'] ?? '';

        return const Uuid().v5(Namespace.url.value, '$uri$data$method$authorization');
      },
      // Default. Allows to cache POST requests.
      // Overriding [keyBuilder] is strongly recommended when [true].
      allowPostMethod: false,
    );
  }

  static Future<int> _getUserId() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    int? userId = localStorage.getInt(LocalStorage.userId) ?? 0;

    return userId;
  }
}
