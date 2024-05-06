class FriendInfo{
  String? idx;
  String? email;
  String? name;
  String? profile;
  String? createdAt;

  FriendInfo({required this.idx, required this.email, required this.name, required this.profile, required this.createdAt});

  factory FriendInfo.fromJson(Map<String, dynamic> json) {
    return FriendInfo(
      idx: json['idx'],
      email: json['email'],
      name: json['name'],
      profile: json['profile'],
      createdAt: json['createdAt'],
    );
  }
}