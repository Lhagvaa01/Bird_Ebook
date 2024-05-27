import 'package:flutter/material.dart';

import 'Models/BirdDatas.dart';
import 'Models/MyLists.dart';
import 'Models/UserIcons.dart';
import 'Models/Users.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bird_ebook/l10n/l10n.dart';

String backUrl = "invoice.kacc.mn:8080";
// String backUrlT = "invoice.kacc.mn:8080";
String backUrlT = "172.20.10.6:8080";
List<UserIcons> icons = [];
List<MyLists> myLists = [];
List<BirdDatas> datas = [];
Users userField = Users();
String saveBirdPk = "0";

String language = "en";

bool isSaved = false;


