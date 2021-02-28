import 'package:astani/models/plant.dart';
import 'package:flutter/material.dart';

class DetailPlant extends StatelessWidget {
  DetailPlant({this.plant});
  final Plant plant;
  @override
  Widget build(BuildContext context) {
    List<Widget> steps=[];
    plant.steps.forEach((element) {
            steps.add(Row(
              children: [
                Expanded(child: Text("- "+element??'')),
              ],
            ));
          });
    return Scaffold(
      appBar: AppBar(title: Text(plant.name),),
      body: SafeArea(child: SingleChildScrollView(child: Container(
        padding: EdgeInsets.symmetric(horizontal:8),
        child:Column(
          children: [
          Container(height: 150,child: Hero(
            tag: plant.name??'',
            child: Image.network(plant.imageUrl,fit:BoxFit.cover)),),
          Row(
            children: [
              Expanded(child: Text("  "+plant.detail??'')),
            ],
          ),
          SizedBox(height:10),
          SizedBox(height:10),
          Row(
            children: [
              Text('Wilayah',style:TextStyle(fontWeight:FontWeight.w700)),
            ],
          ),
          SizedBox(height:10),
          Row(
            children: [
              Text(plant.seaLevel??'Adaptif'),
            ],
          ),
          SizedBox(height:10),
          
          Row(
            children: [
              Text('cara budi daya ',style:TextStyle(fontWeight:FontWeight.w700)),
            ],
          ),
          SizedBox(height:10),
          
        ]+steps+[SizedBox(height: 20,)]
        
        ,)
      ),)),
      
    );
  }
}