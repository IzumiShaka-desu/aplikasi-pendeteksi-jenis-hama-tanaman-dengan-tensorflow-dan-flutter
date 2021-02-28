import 'package:astani/models/pests.dart';
import 'package:flutter/material.dart';

class DetailPest extends StatelessWidget {
  DetailPest({this.pests});
  final Pests pests;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pests.name),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
                  child: Container(
            child: Column(children: [
              Hero(
                  tag: pests.name,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(pests.imageUrl),
                            fit: BoxFit.cover)),
                  )),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text("   "+
                    pests.detail,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(padding:EdgeInsets.symmetric(horizontal:5),child: Row(
                children: [
                  Text('- pengendalian :',style: TextStyle(fontWeight:FontWeight.w700),),
                ],
              ),),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text("   "+pests.control),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ]),
          ),
        ),
      ),
    );
  }
}
