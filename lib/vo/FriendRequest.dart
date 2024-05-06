class FriendRequest{

  String? idx;
  String? fromUser;
  String? toUser;

  FriendRequest({required this.idx, required this.fromUser, required this.toUser});

  factory FriendRequest.fromJson(Map<String, dynamic> json) {
    return FriendRequest(
      idx: json['idx'],
      fromUser: json['fromUser'],
      toUser: json['toUser'],
    );
  }

}