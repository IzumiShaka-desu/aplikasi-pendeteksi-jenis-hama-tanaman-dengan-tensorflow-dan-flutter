import 'package:astani/models/plant.dart';
import 'package:astani/service/firestore_service.dart';
import 'package:flutter/material.dart';

import 'detail_plant.dart';

class ListPlant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar tanaman')),
      body: FutureBuilder<List<Plant>>(
        future: FirestoreService().getListPlants(),
        builder: (ctx, snapshot) => Container(
            child: (!snapshot.hasData)
                ? Center(
                    child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator()))
                : GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (ctx, index) => Container(
                          padding: EdgeInsets.all(5),
                          child:Material(
                                type: MaterialType.transparency,
                                child: InkWell(
                                  onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder:(ctx)=>DetailPlant(plant:snapshot.data[index]))),
                                  child:  Container(
                              height: 200,
                              padding: EdgeInsets.only(bottom: 5),
                              child: Column(
                                children: [
                                  Hero(
                                      tag: snapshot.data[index].name,
                                      child: Container(
                                        height: 120,
                                        child: Image.network(
                                          snapshot.data[index].imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                  Container(
                                      padding: EdgeInsets.all(8),
                                      child: Text(snapshot.data[index].name))
                                ],
                              ),
                            )),
                          ),
                        ))),
      ),
    );
  }
}
