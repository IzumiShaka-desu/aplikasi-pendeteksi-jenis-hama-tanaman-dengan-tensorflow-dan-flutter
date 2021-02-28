import 'package:astani/models/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:tflite/tflite.dart';
import 'package:weather_icons/weather_icons.dart';

SeaLevel getSeaLevel(double mdpl) {
  if (mdpl > 700) return SeaLevel.DATARAN_TINGGI;
  if (mdpl > 200) return SeaLevel.DATARAN_SEDANG;
  return SeaLevel.DATARAN_RENDAH;
}

PageRoute routeAnimRoute(Widget target) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => target,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.elasticOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

String getSeaLevelString(double mdpl) {
  switch (getSeaLevel(mdpl)) {
    case SeaLevel.DATARAN_TINGGI:
      return 'Dataran Tinggi';
      break;
    case SeaLevel.DATARAN_SEDANG:
      return 'Dataran Sedang';
      break;
    case SeaLevel.DATARAN_RENDAH:
      return 'Dataran Rendah';
      break;
  }
}

weathericon(String weather) {
  weather = weather.toLowerCase();
  if (weather.contains('cloud')) return BoxedIcon(WeatherIcons.cloudy);
  if (weather.contains('rain')) return BoxedIcon(WeatherIcons.rain_mix);
  if (weather.contains('wind')) return BoxedIcon(WeatherIcons.windy);
  if (weather.contains('storm')) return BoxedIcon(WeatherIcons.storm_showers);

  return BoxedIcon(WeatherIcons.day_sunny);
}

Future<List<ModelResult>> classifyImage(pathImage) async {
  List<ModelResult> results = [];
  await Tflite.loadModel(

      ///directory of model
      model: 'assets/models/modeloptimized.tflite',

      ///directory label of categories
      labels: 'assets/models/label.txt');

  List<dynamic> re = await Tflite.runModelOnImage(

      ///path image for path of image for image classifier
      path: pathImage,

      ///numResults is how many labels
      numResults: 38);
  re.forEach((element) {
    debugPrint(element.toString());
    results.add(ModelResult.fromJson(element));
  });

  //result = await Tflite.detectObjectOnImage(path: pathImage);

  return results;
}

List<String> getListString(List list) {
  List<String> list = [];
  list.forEach((element) {
    list.add(element.toString());
  });
  return list;
}
