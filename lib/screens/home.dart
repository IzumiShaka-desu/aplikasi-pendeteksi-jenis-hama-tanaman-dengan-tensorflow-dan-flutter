import 'package:astani/models/info.dart';
import 'package:astani/models/plant.dart';
import 'package:astani/provider/home_provider.dart';
import 'package:astani/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';

import '../constant.dart';
import 'detail_plant.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final provider = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(5),
          child: Column(children: [
            Row(
              children: [
                Image.asset('assets/images/icons.png', width: size.width / 2.8),
              ],
            ),
            SizedBox(height:20),
            Container(
                padding: EdgeInsets.only(top: 20),
                height: 200,
                child: FutureBuilder<Info>(
                    future: provider.getinfo(),
                    builder: (ctx, snapshot) => Container(
                          child: (snapshot.hasData)
                              ? Column(
                                  children: [
                                    Text(
                                        "${snapshot.data.weather.areaName} (${snapshot.data.weather.country})"),
                                    Text(
                                        "${snapshot.data.mdpl.seaLevelString} (${snapshot.data.mdpl.roundMdpl} mdpl)"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            '${snapshot.data.weather.tempFeelsLike.celsius.toInt()}°C ',
                                            style: TextStyle(
                                                fontSize: 36,
                                                fontWeight: FontWeight.bold)),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                weathericon(snapshot
                                                    .data.weather.weatherMain),
                                                Text(
                                                    '${snapshot.data.weather.weatherDescription} ${snapshot.data.weather.weatherMain.toLowerCase()}'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                BoxedIcon(WeatherIcons.windy),
                                                Text(
                                                    '${snapshot.data.weather.windSpeed} meter per menit')
                                              ],
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  BoxedIcon(
                                                      WeatherIcons.humidity),
                                                  Text(
                                                      'Kelembaman ${snapshot.data.weather.humidity.toInt()} %')
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )
                              : Center(
                                  child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator())),
                        ))),
            Row(
              children: [
                Expanded(
                    child:
                        Text('rekomendasi tumbuhan Berdasarkan wilayah anda:')),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 150,
              child: FutureBuilder<List<Plant>>(
                future: provider.getRecomendedPlant(),
                builder: (ctx, snapshot) => (!snapshot.hasData)
                    ? Container(child: Center(child:Text('tidak ada rekomendasi')),)
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (ctx, index) => Container(
                              height: 90,
                              width: 120,
                              child: Material(
                                type: MaterialType.transparency,
                                child: InkWell(
                                  onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder:(ctx)=>DetailPlant(plant:snapshot.data[index]))),
                                  child: Card(
                                    child: Container(
                                      height: 80,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Hero(
                                              tag: snapshot.data[index].name,
                                              child: Image.network(
                                                snapshot.data[index].imageUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5.0),
                                            child:
                                                Text(snapshot.data[index].name),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
              ),
            ),
            SizedBox(height:20),
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (ctx, index) => Container(
                      height: size.width / 3,
                      padding: EdgeInsets.all(5),
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () => goTo(index, context),
                          child: Container(
                            child: Column(
                              children: [
                                Expanded(
                                    child: Container(
                                  child: menu[index]['icon'],
                                )),
                                Expanded(
                                  child: menu[index]['text'],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
          ]),
        )),
      ),
    );
  }

  goTo(int index, BuildContext context) =>
      Navigator.of(context).push(routeAnimRoute(destination[index]));
}
