import 'package:caps_2/friend/model/friend_model.dart';
import 'package:caps_2/friend/model/request_friend_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class FriendRepository {
  final _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String testUrl = "localhost";
  final String memberUrl = "http://43.201.118.1:8080/api/v1/members";
  final String friendUrl = "http://43.201.118.1:8081/api/v1/friends";

  String? _loadAccToken;
  String? _loadRefToken;

  FriendRepository() {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    initializeHeader();
  }

  Future<void> initializeHeader() async {
    _loadAccToken = await _storage.read(key: 'accToken');
    _loadRefToken = await _storage.read(key: 'refToken');

    if (_loadAccToken != null) {
      _dio.options.headers['Authorization'] = 'Bearer $_loadAccToken';
      _dio.options.headers['x-refresh-token'] = 'Bearer $_loadRefToken';
    }
  }

  // 친구 요청
  Future<void> requestFriend(int userId) async {
    final res = await _dio.post(
      '$friendUrl/request',
      data: {
        'toUser': userId,
      },
    );

    return res.data;
  }

  // 친구 여부 확인
  Future<bool> isFriend(int userId) async {
    final res = await _dio.post(
      '$friendUrl/isFriend',
      data: {
        'toUser': userId,
      },
    );

    return res.data;
  }

  // 친구 요청 거절
  Future<void> declineFriend(int userId) async {
    final res = await _dio.post('$friendUrl/decline/$userId');

    return res.data;
  }

  // 친구 요청 수락
  Future<void> acceptFriend(int userId) async {
    final res = await _dio.post('$friendUrl/accept/$userId');

    return res.data;
  }

  // 친구정보 반환
  Future<FriendModel> getFriend(int userId) async {
    final res = await _dio.get('$friendUrl/$userId');

    return FriendModel.fromJson(res.data);
  }

  // 친구 삭제
  Future<void> deleteFriend(int userId) async {
    final res = await _dio.delete('$friendUrl/$userId');

    return res.data;
  }

  // 친구 요청 목록 반환
  Future<List<RequestFriendModel>> getFriendRequestToMeList() async {
    final res = await _dio.get('$friendUrl/requests');

    return res.data
        .map((e) => RequestFriendModel.fromJson(e))
        .cast<RequestFriendModel>()
        .toList();
  }

  // 친구 목록 반환
  Future<List<FriendModel>> getFriendList() async {
    final res = await _dio.get('$friendUrl/list');

    return res.data
        .map((e) => FriendModel.fromJson(e))
        .cast<FriendModel>()
        .toList();
  }

  // 친구 추가를 위해 이메일로 유저 검색
  Future<FriendModel> searchFriend(String email) async {
    final res = await _dio.get('$memberUrl/search/$email');
    print(res);
    return FriendModel.fromJson(res.data);
  }
}
