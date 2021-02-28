import 'package:astani/utils.dart';
import 'package:flutter/widgets.dart';

class ModelResult {
  String label;
  double confidence;
  ModelResult({this.label, this.confidence});

  factory ModelResult.fromJson(Map json) =>
      ModelResult(confidence: json['confidence'], label: json['label']);
}

class MdplResult{
  double mdpl;
  get seaLevel =>getSeaLevel(mdpl);
  get roundMdpl=>mdpl.toInt();
  get seaLevelString =>getSeaLevelString(mdpl);
  MdplResult({@required this.mdpl});
}

enum SeaLevel{
  DATARAN_TINGGI,
  DATARAN_SEDANG,
  DATARAN_RENDAH
}
