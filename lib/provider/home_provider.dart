import 'dart:convert';

import 'package:astani/models/info.dart';
import 'package:astani/models/plant.dart';
import 'package:astani/models/result.dart';
import 'package:astani/service/firestore_service.dart';
import 'package:astani/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier {



  Future<double> getAltitude() async {
    double altitude=0;
    try{Position _position = await getCurrentPosition();
    var res =await http.Client().get("https://api.airmap.com/elevation/v1/ele/?points=${_position.latitude},${_position.longitude}");
    if(res.statusCode==200){
     var result= jsonDecode(res.body);
     altitude=double.parse(result['data'][0].toString());
    }}catch(e){print(e.toString());}
    return altitude;
  }
  Future<Info> getinfo()async{
    Weather weather=await currentWeather();
    double elevation=await getAltitude();
    return Info(weather:weather,mdpl:MdplResult(mdpl: elevation));
  }
  Future<List<Plant>> getRecomendedPlant()async{
      List<Plant> result=[];
      Info info=await getinfo();
      String seaLevel=getSeaLevelString(info.mdpl.mdpl);
      List<Plant> a=await FirestoreService().getListPlants();
      a.forEach((element) {
        if(element.seaLevel==null ||element.seaLevel.contains(seaLevel) || element.seaLevel==""){
          result.add(element);
        }
      });
      return result;
  }
  Future<Weather> currentWeather() async {
    Position position = await getLastKnownPosition();
    var _apiKey = '9a380260c3eff2a3e6f9d6463face987';

    WeatherFactory weatherFactory =
        WeatherFactory(_apiKey, language: Language.INDONESIAN);
    Weather result= await weatherFactory.currentWeatherByLocation(
        position.latitude, position.longitude);
    return result;
  }
}
