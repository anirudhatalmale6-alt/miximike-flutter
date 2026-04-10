part of '../client.dart';

class ProductClient extends Client {
  static Future<List<T>> getOrders<T>({
    String status = 'completed',
    bool forceReload = false,
  }) async {
    Dio dio = await Client.dio;
    CacheOptions cacheOptions = await Client.cacheOptions;
    List<T> responses = [];
    int page = 1;

    while (true) {
      Response<List<T>> response = await dio.get<List<T>>(
        '${Client.baseUrl}/wp-json/wc/v3/orders',
        queryParameters: {
          'customer': await Client._getUserId(),
          'status': status,
          'per_page': 100,
          'page': page,
        },
        options: Options(
          extra: {
            'withWooCommerceCredentials': true,
            ...cacheOptions
                .copyWith(
              policy: forceReload
                  ? CachePolicy.refresh
                  : CachePolicy.forceCache,
            )
                .toExtra(),
          },
        ),
      );

      if (response.data!.isEmpty) {
        break;
      }
      responses.addAll(response.data as Iterable<T>);

      if (response.data!.length < 100) {
        break;
      }

      page++;
    }

    return responses;
  }

  static Future<List<T>> getProducts<T>({
    Map<String, dynamic> queryParameters = const {},
    bool forceReload = false,
  }) async {
    Dio dio = await Client.dio;
    CacheOptions cacheOptions = await Client.cacheOptions;

    List<T> responses = [];
    int page = 1;

    while (true) {
      Response<List<T>> response = await dio.get<List<T>>(
        '${Client.baseUrl}/wp-json/wc/v3/products',
        queryParameters: {
          'orderby': 'title',
          'order': 'asc',
          'per_page': 100,
          'page': page,
          ...queryParameters,
        },
        options: Options(
          extra: {
            'withWooCommerceCredentials': true,
            ...cacheOptions
                .copyWith(
              policy: forceReload
                  ? CachePolicy.refresh
                  : CachePolicy.forceCache,
            )
                .toExtra(),
          },
        ),
      );

      if (response.data!.isEmpty) {
        break;
      }

      responses.addAll(response.data as Iterable<T>);

      if (response.data!.length < 100) {
        break;
      }

      page++;
    }

    return responses;
  }

  static Future<List<T>> getDownloads<T>({
    bool forceReload = false,
  }) async {
    Dio dio = await Client.dio;
    CacheOptions cacheOptions = await Client.cacheOptions;

    List<T> responses = [];

    // while (true) {
    Response<List<T>> response = await dio.get<List<T>>(
      '${Client.baseUrl}/wp-json/wc/v3/customers/${await Client._getUserId()}/downloads',
      // queryParameters: {
      //   'per_page': 100,
      //   'page': responses.length + 1,
      // },
      options: Options(
        extra: {
          'withWooCommerceCredentials': true,
          ...cacheOptions
              .copyWith(
            policy: forceReload
                ? CachePolicy.refresh
                : CachePolicy.forceCache,
          )
              .toExtra(),
        },
      ),
    );

    // if (response.data!.isEmpty) {
    //   break;
    // }

    responses.addAll(response.data as Iterable<T>);

    // if (response.data!.length < 100) {
    //   break;
    // }
    // }

    return responses;
  }
}
