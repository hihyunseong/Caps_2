class MemberInfo{
  int idx;
  String email;
  String name;
  String profile;
  String createdAt;
  String updatedAt;

  MemberInfo({required this.idx, required this.email, required this.name, required this.profile, required this.createdAt, required this.updatedAt});

  factory MemberInfo.fromJson(Map<Object, dynamic> json) {
    return MemberInfo(
      idx: int.parse(json['idx']),
      email: json['email'].toString(),
      name: json['name'].toString(),
      profile: json['profile'].toString(),
      createdAt: json['createdAt'].toString(),
      updatedAt: json['updatedAt'].toString(),
    );
  }

  int getIdx(){
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
  String getUpdatedAt(){
    return updatedAt;
  }
}