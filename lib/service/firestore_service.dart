import 'package:astani/models/pests.dart';
import 'package:astani/models/plant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService{
  
  FirebaseFirestore _ref=FirebaseFirestore.instance;
  Future<List<Pests>> getListPests() async{
        List<Pests> list=[];
       try{QuerySnapshot _querySnapshot=await _ref.collection('pests').get();
       _querySnapshot.docs.forEach((element) {
         list.add(Pests.fromJson(element.data()));
       });}catch(e){
         debugPrint(e.toString());
       }
       return list;
    }
  Future<List<Plant>> getListPlants()async{
    List<Plant> list=[];
   try{ QuerySnapshot _querySnapshot=await _ref.collection('plant-variety').get();
    _querySnapshot.docs.forEach((element) {
      list.add(Plant.fromJson(element.data()));
    });}catch(e){
         debugPrint(e.toString());
       }
    return list;
  }
}
