import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Models/BirdDatas.dart';
import 'Models/BirdFamilys.dart';
import 'Models/MyLists.dart';
import 'Models/UserIcons.dart';
import 'Models/Users.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bird_ebook/l10n/l10n.dart';

String backUrl = "invoice.kacc.mn:8080";
String backUrlT = "invoice.kacc.mn:8080";
// String backUrlT = "172.20.10.5:8080";
List<UserIcons> icons = [];
List<MyLists> myLists = [];
List<Birdfamilys> familys = [];
List<BirdDatas> datas = [];
Users userField = Users();
String saveBirdPk = "0";

String language = "en";

bool isSaved = false;

String searchBody = '''
    {
      "season_id": 0,
      "location_id": 0,
      "habitat_id": 0,
      "body_shape_id": 0,
      "bird_size_id": 0,
      "plumage_colour_id": 0
    }
  ''';

Map<String, dynamic> searchBodyJson = jsonDecode(searchBody);

String selectedLocation = "Улаанбаатар";

String getMounthtxt() {
  DateTime now = DateTime.now();
  String month = DateFormat.MMMM().format(now);

  return month;
}

List<String> seasonsJson = [""];
List<String> habitatJson = [""];
List<String> bodyShapeJson = [""];
List<String> bodySizeJson = [""];
List<String> bodyColorJson = [""];

String getTxt(String json) {
  String value = jsonEncode(json)
      .split(',')[1]
      .replaceAll('}"', '')
      .toString()
      .split(":")[1]
      .trim();

  return value;
}

String getTxtId(String json) {
  String value = jsonEncode(json)
      .split(',')[0]
      .replaceAll('}"', '')
      .toString()
      .split(":")[1]
      .trim();

  return value;
}
