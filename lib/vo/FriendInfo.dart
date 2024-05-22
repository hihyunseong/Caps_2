class FriendInfo{
  String idx;
  String email;
  String name;
  String profile;
  String createdAt;

  FriendInfo({required this.idx, required this.email, required this.name, required this.profile, required this.createdAt});

  factory FriendInfo.fromJson(Map<Object, dynamic> json) {
    return FriendInfo(
      idx: json['idx'].toString(),
      email: json['email'].toString(),
      name: json['name'].toString(),
      profile: json['profile'].toString(),
      createdAt: json['createdAt'].toString(),
    );
  }

  String getIdx(){
    return idx;
  }
  String getEmail(){
    return email;
  }
  String getName(){
    return name;
  }
  String getProfile(){
    return profile;
  }
  String getCreatedAt(){
    return createdAt;
  }
}