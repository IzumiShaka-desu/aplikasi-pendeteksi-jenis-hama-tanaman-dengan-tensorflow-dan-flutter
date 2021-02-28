class Pests{
  String name,detail,control,imageUrl;
  Pests({this.name,this.detail,this.control,this.imageUrl});
  factory Pests.fromJson(Map json)=>Pests(name:json['name'],detail:json['detail'],control:json['control'],imageUrl: json['imageUrl']??'');
}