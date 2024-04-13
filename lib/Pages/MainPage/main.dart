// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:convert';

import 'package:bird_ebook/Models/BirdDatas.dart';
import 'package:bird_ebook/Pages/identify%20a%20bird/seoson.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../post@get/api.dart';
import '../about/about.dart';
import '../birdList/birdList.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late InfiniteScrollController controller;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = InfiniteScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  List<BirdDatas> datas = [];

  getBird(BuildContext ctx) {
    GetBirds(ctx).then((value) {
      final responseData = jsonDecode(value);
      final statusCode = responseData['statusCode'];
      final bodyData = responseData['body'];

      print("statusCode: $statusCode");

      if (statusCode == "200") {
        datas = [];
        for (var item in bodyData) {
          datas.add(BirdDatas.fromJson(item));
        }
        // final body = BirdDatas.fromJson(bodyData);
        print(datas);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Birdlist(birdDataList: datas), // Pass birdDataList argument
          ),
        );
      } else {
        Alert(
          context: ctx,
          title: "Алдаа",
          desc: bodyData,
          buttons: [
            DialogButton(
              child: Text(
                "Хаах",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(ctx),
            )
          ],
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("PLANET MONGOLIA"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF860000),
                Color(0xFFEB1933)
              ], // Define your gradient colors
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              stops: [0.1, 3.5], // Optional: Define color stops
              // tileMode: TileMode.clamp, // Optional: Define tile mode
            ),
          ),
        ),
        centerTitle: true,
        leading: Container(
          child: Image.asset(
            "assets/images/logo.png",
            // width: size.width / 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 14,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF860000),
                    Color(0xFFEB1933)
                  ], // Define your gradient colors
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  stops: [0.1, 3.5], // Optional: Define color stops
                  // tileMode: TileMode.clamp, // Optional: Define tile mode
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: size.width / 3,
                          child: Column(
                            children: [
                              Text("SIGHTINGS"),
                              Text("300"),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(width: 1.5, color: Colors.black),
                              right:
                                  BorderSide(width: 1.5, color: Colors.black),
                            ),
                          ),
                          width: size.width / 3,
                          child: Column(
                            children: [Text("SPECIES"), Text("550")],
                          ),
                        ),
                        Container(
                          width: size.width / 3,
                          child: Column(
                            children: [Text("IMAGES"), Text("7000")],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Container(
                    child: Image.asset(
                      "assets/images/zurg1.jpg",
                      fit: BoxFit.cover,
                      height: size.height / 3,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Season()),
                            );
                          },
                          child: Container(
                            height: 150,
                            width: 155,
                            margin: EdgeInsets.only(top: 40),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 153, 151, 151),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    "assets/images/bird.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                Text(
                                  "IDENTIFY A BIRD",
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            getBird(context);
                          },
                          child: Container(
                            height: 150,
                            width: 155,
                            margin: EdgeInsets.only(top: 40),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 153, 151, 151),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(
                                      8.0), // Adjust padding as needed
                                  child: Image.asset(
                                    "assets/images/search.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                Text(
                                  "BIRD LIST",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
