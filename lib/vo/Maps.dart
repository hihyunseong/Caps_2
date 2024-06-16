class Maps{
  int idx;
  String title;
  String color;
  int lat;
  int lon;
  String createdAt;
  String updatedAt;

  Maps({required this.idx, required this.title, required this.color, required this.lat, required this.lon, required this.createdAt, required this.updatedAt});

  factory Maps.fromJson(Map<Object, dynamic> json) {
    return Maps(
      idx: int.parse(json['idx']),
      title: json['title'].toString(),
      color: json['color'].toString(),
      lat: int.parse(json['lat']),
      lon: int.parse(json['lon']),
      createdAt: json['createdAt'].toString(),
      updatedAt: json['updatedAt'].toString(),
    );
  }

  int getIdx(){
    return idx;
  }
  String getTitle(){
    return title;
  }
  String getColor(){
    return color;
  }
  int getLat(){
    return lat;
  }
  int getLon(){
    return lon;
  }
  String getCreatedAt(){
    return createdAt;
  }
  String getUpdatedAt(){
    return updatedAt;
  }
}