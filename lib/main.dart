// ignore_for_file: unnecessary_const, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:bird_ebook/Pages/Login/login.dart';
import 'package:bird_ebook/Pages/MainPage/main.dart';
import 'package:bird_ebook/Pages/birdList/birdList.dart';
import 'package:bird_ebook/Pages/profile/proFile.dart';
import 'package:bird_ebook/constant.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Models/UserIcons.dart';
import 'Pages/identify a bird/seoson.dart';
import '../../post@get/api.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bird_ebook/l10n/l10n.dart';

void main() {
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getUserIcons(context);
  }

  getUserIcons(BuildContext ctx) {
    GetIcons(ctx).then((value) {
      print(icons);
    });
  }

  Locale _locale = const Locale('en');

  void _changeLanguage(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        const Locale('en'),
        const Locale('mn'),
      ],
      locale: _locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: HelloConvexAppBar(changeLanguage: _changeLanguage),
      builder: EasyLoading.init(),
    );
  }
}

class HelloConvexAppBar extends StatefulWidget {
  final void Function(Locale) changeLanguage;

  const HelloConvexAppBar({Key? key, required this.changeLanguage}) : super(key: key);

  @override
  State<HelloConvexAppBar> createState() => _HelloConvexAppBarState();
}

class _HelloConvexAppBarState extends State<HelloConvexAppBar> {
  int selectedPage = 0;

  late List<Widget> _pageOptions;

  @override
  void initState() {
    super.initState();
    _pageOptions = [
      MainPage(changeLanguage: widget.changeLanguage),
      Season(changeLanguage: widget.changeLanguage),
      ProFile(changeLanguage: widget.changeLanguage),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        gradient: LinearGradient(
          colors: [
            Color(0xFF860000),
            Color(0xFFEB1933)
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          stops: [0.2, 4],
        ),
        style: TabStyle.react,
        items: [
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.explore, title: "Explorer"),
          TabItem(icon: Icons.account_balance, title: "Profile"),
        ],
        initialActiveIndex: selectedPage,
        onTap: (int i) {
          setState(() {
            selectedPage = i;
          });
        },
      ),
    );
  }
}
