import 'dart:io';

import 'package:astani/models/result.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils.dart';

class PestClassifyer extends StatefulWidget {
  @override
  _PestClassifyerState createState() => _PestClassifyerState();
}

class _PestClassifyerState extends State<PestClassifyer> {
  GlobalKey<ScaffoldState> _sfkey = GlobalKey<ScaffoldState>();
  var imagePath;
  bool isHealth=false;
  List<ModelResult> results = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _sfkey,
      appBar: AppBar(title: Text('')),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            SizedBox(),
            Container(
                height: (size.width - 10) * 0.9,
                width: (size.width - 10),
                child: (imagePath == null)
                    ? Center(
                        child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () => pickImage(),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  size: size.width * 0.3,
                                  color: Colors.grey,
                                ),
                                Text('Pilih foto')
                              ],
                            ),
                          ),
                        ),
                      ))
                    : Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Image.file(File(imagePath))),
                          Positioned(
                              top: 10,
                              right: 10,
                              child: Material(
                                type: MaterialType.transparency,
                                child: InkWell(
                                  onTap: () => setState(() {
                                    imagePath = null;
                                    results = [];
                                  }),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white24,
                                        shape: BoxShape.circle),
                                    child: Center(child: Icon(Icons.close)),
                                  ),
                                ),
                              ))
                        ],
                      )),
            SizedBox(),
            (imagePath == null)
                ? Container()
                : MaterialButton(
                    color: Colors.blue,
                    child: Text('klasifikasikan'),
                    onPressed: () => classifyExec(),
                  ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top:5,left:5,right:5),
                child:(isHealth)? Center(child:Text('selamat tanaman anda sehat')):ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (_, index) => Column(
                          children: [
                            Row(children: [
                              Text(results[index].label.replaceAll('_', ' ')),
                            ]),
                            Row(
                              children: [
                                Slider(
                                    min: 0,
                                    max: 100,
                                    value: results[index].confidence * 100,
                                    onChanged: null)
                              ],
                            )
                          ],
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }

  classifyExec() async {
    try {
      bool health=false;
      List<ModelResult> result = await classifyImage(imagePath);
      result.forEach((element) {
       if(element.label.contains('healthy'))health=true;

      });
      setState(() {
        results = result;
        isHealth=health;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future pickImage() async {
    isHealth=false;
    try {
      PickedFile images =
          await ImagePicker().getImage(source: ImageSource.gallery);
      setState(() {
        imagePath = images.path ?? null;
      });
    } catch (e) {
      debugPrint(e);
    }
  }
}
