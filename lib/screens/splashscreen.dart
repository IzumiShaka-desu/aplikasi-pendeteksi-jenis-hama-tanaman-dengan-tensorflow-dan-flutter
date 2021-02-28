import 'dart:async';

import 'package:flutter/material.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), ()=>goToHome());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Color.fromRGBO(93, 93, 93, 1),
      child: Center(child:Container(height: 200,child: Image.asset('assets/images/asta.gif'),)),
    );
  }
  goToHome(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>Home()));
  }
}