import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';


class DioClient {
  static Dio create({required String baseUrl}) {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));
    final storage = GetStorage();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final requiresToken = options.extra["requiresToken"] ?? true;
          if (requiresToken) {
            final token = storage.read("accessToken");
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            final refreshToken = storage.read("refreshToken");

            if (refreshToken != null) {
              try {
                final refreshResponse = await dio.post(
                  "/token/refresh",
                  data: {"refreshToken": refreshToken},
                  options: Options(extra: {"requiresToken": false}),
                );

                final newAccess = refreshResponse.data['accessToken'];
                final newRefresh = refreshResponse.data['refreshToken'];

                storage.write("accessToken", newAccess);
                storage.write("refreshToken", newRefresh);

                final retryRequest = e.requestOptions;
                retryRequest.headers['Authorization'] = 'Bearer $newAccess';
                final clonedResponse = await dio.fetch(retryRequest);
                return handler.resolve(clonedResponse);
              } catch (err) {
                storage.erase();
                // Get.offAllNamed(AppRoutes.login);
                return handler.reject(e);
              }
            } else {
              storage.erase();
              // Get.offAllNamed(AppRoutes.login);
            }
          }
          return handler.next(e);
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    return dio;
  }
}
