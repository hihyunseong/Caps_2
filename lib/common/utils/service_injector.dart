import 'package:caps_2/auth/repository/sign_up_repository.dart';
import 'package:caps_2/map/repository/shared_map_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceInjector {
  ServiceInjector._();

  static final GetIt injector = GetIt.instance;

  static Future<void> injectDependencies() async {
    injector.allowReassignment = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    const String memberUrl = "http://43.201.118.1:8080/api/v1/members";
    const String mapUrl = 'http://43.201.118.1:8082/api/v1/maps';

    const FlutterSecureStorage storage = FlutterSecureStorage();

    String? accToken = await storage.read(key: 'accToken');
    String? refToken = await storage.read(key: 'refToken');

    final Dio mapDio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
      ),
    )..interceptors.addAll(
        <Interceptor>[
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              if (accToken != null && refToken != null) {
                options.headers['Authorization'] = 'Bearer $accToken';
                options.headers['x-refresh-token'] = 'Bearer $refToken';
              }
              return handler.next(options); //continue
            },
          ),
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: true,
            error: true,
            compact: true,
            maxWidth: 90,
          ),
        ],
      );

    final Dio memberDio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
      ),
    )..interceptors.addAll(
        <Interceptor>[
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: true,
            error: true,
            compact: true,
            maxWidth: 90,
          ),
        ],
      );

    injector.registerLazySingleton<SignUpRepository>(
      () => SignUpRepository(
        memberDio,
        baseUrl: memberUrl,
      ),
    );
    injector.registerLazySingleton<SharedMapRepository>(
      () => SharedMapRepository(
        mapDio,
        baseUrl: mapUrl,
      ),
    );
  }
}
