

class Plant {
  List steps;
  String name, detail, imageUrl, seaLevel;
  Plant({this.name, this.imageUrl, this.detail, this.seaLevel, this.steps});
  factory Plant.fromJson(Map json) => Plant(
      name: json['name'],
      imageUrl: json['imageUrl'],
      detail: json['detail'],
      seaLevel: json['seaLevel'],
      steps:json['step']);
}
