part of '../client.dart';

class AuthenticationClient {
  static Future<Response<T>> signIn<T>({
    required String token,
  }) async {
    Dio dio =  await Client.dio;
    CacheOptions cacheOptions = await Client.cacheOptions;

    return dio.get<T>(
      '${Client.baseUrl}/wp-json/wp/v2/users/me',
      options: Options(
          headers: {
            'Authorization': 'Basic $token'
          },
          extra: {
            ...cacheOptions.copyWith(
              policy: CachePolicy.refresh,
            ).toExtra(),
          }
      ),
    );
  }

  static Future<Response<T>> signUp<T>({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    Dio dio =  await Client.dio;
    String adminToken = dotenv.env['WORDPRESS_ADMIN_TOKEN'] as String;

    return dio.post<T>(
      '${Client.baseUrl}/wp-json/wp/v2/users',
      data: {
        'username': username,
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
      },
      options: Options(
          headers: {
            'Authorization': 'Basic $adminToken'
          },
      ),
    );
  }
}
