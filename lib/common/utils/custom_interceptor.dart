// import 'package:dio/dio.dart';

// class CustomInterceptor extends Interceptor {
//   final Dio dio;

//   CustomInterceptor({
//     required this.dio,
//   });

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     if (err.requestOptions.path == '/v1/auth/reissue' &&
//         err.response?.statusCode == 401) {
//       AuthService.shared.deleteToken();
//       return;
//     } else if (err.response?.statusCode == 401) {
//       final auth = await secureStorageDatasource.getLocalAuth();
//       final newAuth = await authDatasource.reissueToken(auth);
//       await secureStorageDatasource.setLocalAuth(newAuth);

//       RequestOptions requestOptions = err.requestOptions;
//       requestOptions.headers['Authorization'] = 'Bearer ${newAuth.accessToken}';

//       final opts = Options(
//         method: requestOptions.method,
//         headers: requestOptions.headers,
//       );

//       dio
//           .request(
//             requestOptions.path,
//             options: opts,
//             data: requestOptions.data,
//             queryParameters: requestOptions.queryParameters,
//           )
//           .then(
//             (response) => handler.resolve(response),
//             onError: (e) => handler.reject(e),
//           );
//       return;
//     }
//     super.onError(err, handler);
//   }
// }
