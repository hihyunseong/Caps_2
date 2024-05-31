import 'package:caps_2/friend/model/friend_model.dart';
import 'package:caps_2/friend/model/request_friend_model.dart';
import 'package:caps_2/friend/repository/friend_repository.dart';
import 'package:flutter/material.dart';

class FriendProvider extends ChangeNotifier {
  final _friendRepository = FriendRepository();

  final TextEditingController friendFindController = TextEditingController();

  // 친구 목록
  List<FriendModel> friendList = [];

  // 친구 요청 목록
  List<RequestFriendModel> friendRequestToMeList = [];

  // 친구 찾기 목록
  FriendModel? searchedFriend;

  FriendProvider() {
    getLatestList();
  }

  // 최신 업데이트
  Future<void> getLatestList() async {
    await _friendRepository.initializeHeader();
    await getFriendList();
    await getFriendRequestToMeList();
  }

  // 친구 목록 가져오기
  Future<void> getFriendList() async {
    try {
      friendList = await _friendRepository.getFriendList();
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // 친구 요청 목록 가져오기
  Future<void> getFriendRequestToMeList() async {
    try {
      friendRequestToMeList =
          await _friendRepository.getFriendRequestToMeList();
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // 친구 찾기 목록 가져오기
  Future<void> searchFriend(String email) async {
    try {
      searchedFriend = await _friendRepository.searchFriend(email);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // 친구 삭제하기
  Future<void> deleteFriend(int userId) async {
    try {
      await _friendRepository.deleteFriend(userId);
      await getLatestList();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // 친구 요청 수락하기
  Future<void> acceptFriend(int userId) async {
    try {
      await _friendRepository.acceptFriend(userId);
      await getLatestList();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // 친구 요청 거절하기
  Future<void> declineFriend(int userId) async {
    try {
      await _friendRepository.declineFriend(userId);
      await getLatestList();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // 친구 추가 요청 보내기
  Future<void> requestFriend(int userId) async {
    try {
      await _friendRepository.requestFriend(userId);
      await getLatestList();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
