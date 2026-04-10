part of '../client.dart';

class NotificationClient extends Client {
  static Future<Response<T>> getNotifications<T>({
    Map<String, dynamic> queryParameters = const {},
    bool forceReload = false,
  }) async {
    Dio dio = await Client.dio;
    CacheOptions cacheOptions = await Client.cacheOptions;
    int categoryId = int.parse(dotenv.env['WORDPRESS_NOTIFICATION_CATEGORY_ID'] as String);

    return dio.get<T>(
        '${Client.baseUrl}/wp-json/wp/v2/posts',
        queryParameters: {
          'categories': categoryId,
          ...queryParameters,
        },
        options: Options(
          extra: {
            'withUserCredentials': true,
            ...cacheOptions.copyWith(
              policy: forceReload ? CachePolicy.refresh : CachePolicy.forceCache,
            ).toExtra(),
          },
        )
    );
  }
}
