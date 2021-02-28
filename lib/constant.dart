import 'package:astani/screens/detect_pests.dart';
import 'package:astani/screens/list_pests.dart';
import 'package:astani/screens/list_plant.dart';
import 'package:flutter/material.dart';

List<Map<String,Widget>> menu=[
  {
    "icon":Image.asset('assets/images/planticon.png'),
    "text":Text('Daftar tumbuhan')
  }, {
    "icon":Image.asset('assets/images/pesticon.png'),
    "text":Text('Daftar hama')
  }, {
    "icon":Image.asset('assets/images/findpests.png'),
    "text":Text('identifikasi hama')
  }, {
    "icon":Image.asset('assets/images/planticon.png'),
    "text":Text('Daftar tumbuhan')
  }
];
List<Widget> destination=[ListPlant(),ListPests(),PestClassifyer(),PestClassifyer()];
