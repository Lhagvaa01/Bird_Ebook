// ignore_for_file: unnecessary_const, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:bird_ebook/Pages/Login/login.dart';
import 'package:bird_ebook/Pages/MainPage/main.dart';
import 'package:bird_ebook/Pages/birdList/birdList.dart';
import 'package:bird_ebook/Pages/profile/proFile.dart';
import 'package:bird_ebook/constant.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Models/UserIcons.dart';
import 'Pages/identify a bird/seoson.dart';
import '../../post@get/api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginMain(),
      // initialRoute: "/",
      // routes: {
      //   "/": (_) => HelloConvexAppBar(),
      //   "/home": (BuildContext context) => MainPage(),
      //   "/explorer": (BuildContext context) => Birdlist(),
      //   "/profile": (BuildContext context) => ProFile(),
      // },
    );
  }
}

class HelloConvexAppBar extends StatefulWidget {
  @override
  State<HelloConvexAppBar> createState() => _HelloConvexAppBarState();
}

class _HelloConvexAppBarState extends State<HelloConvexAppBar> {
  int selectedPage = 0;

  final _pageOption = [MainPage(), Season(), ProFile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOption[selectedPage],
      bottomNavigationBar: ConvexAppBar(
          gradient: LinearGradient(
            colors: [
              Color(0xFF860000),
              Color(0xFFEB1933)
            ], // Define your gradient colors
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            stops: [0.2, 4], // Optional: Define color stops
            // tileMode: TileMode.clamp, // Optional: Define tile mode
          ),
          style: TabStyle.react,
          items: [
            TabItem(icon: Icons.home, title: "Home"),
            TabItem(icon: Icons.explore, title: "Explorer"),
            TabItem(icon: Icons.account_balance, title: "Profile"),
          ],
          initialActiveIndex: selectedPage,
          onTap: (int i) => {
                setState(() {
                  selectedPage = i;
                }),
              }),
    );
  }
}
