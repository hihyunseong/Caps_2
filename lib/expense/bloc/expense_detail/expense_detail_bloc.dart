import 'package:bloc/bloc.dart';
import 'package:caps_2/expense/repository/expense_detail_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'expense_detail_bloc.freezed.dart';
part 'expense_detail_event.dart';
part 'expense_detail_state.dart';

class ExpenseDetailBloc extends Bloc<ExpenseDetailEvent, ExpenseDetailState> {
  ExpenseDetailBloc() : super(const ExpenseDetailState.initial()) {
    on<ExpenseDetailEvent>((event, emit) async {
      await event.map(
        started: (event) async {
          Dio dio = Dio()
            ..interceptors.addAll(
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

          final loadAccToken = await _storage.read(key: 'accToken');
          final loadRefToken = await _storage.read(key: 'refToken');

          if (loadAccToken != null) {
            dio.options.headers['Authorization'] = 'Bearer $loadAccToken';
            dio.options.headers['x-refresh-token'] = 'Bearer $loadRefToken';
          }

          ExpenseDetailRepository expenseDetailRepository =
              ExpenseDetailRepository(
            dio,
            baseUrl: pinUrl,
          );

          try {
            final res = await expenseDetailRepository.getExpenseDetail(
              pinIdx: event.pinIdx,
            );
            emit(ExpenseDetailState.success(
              response: res,
            ));
          } catch (e) {
            emit(const ExpenseDetailState.failure());
          }
        },
      );
    });
  }

  final String pinUrl = "http://43.201.118.1:8080/api/v1/pin";
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
}
