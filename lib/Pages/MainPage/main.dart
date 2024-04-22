// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, empty_constructor_bodies

import 'dart:convert';

import 'package:bird_ebook/Models/BirdDatas.dart';
import 'package:bird_ebook/Pages/Login/login.dart';
import 'package:bird_ebook/Pages/identify%20a%20bird/seoson.dart';
import 'package:bird_ebook/Pages/profile/proFile.dart';
import 'package:bird_ebook/constant.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../post@get/api.dart';
import '../about/about.dart';
import '../birdList/birdList.dart';
import 'slider.dart';

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

  getBird(BuildContext ctx) {
    datas.isEmpty
        ? GetBirds(ctx).then((value) {
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
                  builder: (context) => Birdlist(
                      birdDataList: datas), // Pass birdDataList argument
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
          })
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Birdlist(birdDataList: datas), // Pass birdDataList argument
            ),
          );
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
        // actions: [
        //   IconButton(
        //     padding: EdgeInsets.only(right: 30),
        //     onPressed: () {},
        //     icon: Icon(Icons.menu, size: 40,),
        //   )
        // ],
      ),
      endDrawer: const NavigationDrawer(),
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
                              Text("Үзүүлэлт"),
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
                            children: [Text("Төрөл зүйл"), Text("550")],
                          ),
                        ),
                        Container(
                          width: size.width / 3,
                          child: Column(
                            children: [Text("Зураг"), Text("7000")],
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
              width: size.width,
              child: Column(
                children: [
                  ImageSlider(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Season()),
                            );
                          },
                          child: Container(
                            height: 150,
                            width: 155,
                            margin: EdgeInsets.only(top: 40),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 121, 119, 119),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    "assets/images/isearch.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                Text(
                                  "Дэлгэрэнгүй хайлт",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
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
                                color: Color.fromARGB(255, 121, 119, 119),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(
                                      8.0), // Adjust padding as needed
                                  child: Image.asset(
                                    "assets/images/sbird.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                Text(
                                  "Жагсаалт",
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

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
        width: 250,
        child: Column(
          children: [
            Container(
              // padding: EdgeInsets.only(top: 60, left: 20),
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height / 4,
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
                    child: Row(
                      children: [
                        CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Image.network(
                      'http://${backUrlT}${icons[0].image}',
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) {
                          return child;
                        }
                        return CircularProgressIndicator(
                          value: progress.expectedTotalBytes != null
                              ? progress.cumulativeBytesLoaded /
                                  progress.expectedTotalBytes!
                              : null,
                        );
                      },
                    ),
                  ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          userField.tCUSERNAME.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Container(
                      width: size.width / 2,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius as needed
                        color: Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Home",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Birdlist()),
                      );
                    },
                    child: Container(
                      child: Container(
                        width: size.width / 2,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the radius as needed
                          color: Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Хайлт",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Container(
                      width: size.width / 2,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius as needed
                        color: Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.list,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Жагсаалт",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProFile()),
                      );
                    },
                    child: Container(
                      child: Container(
                        width: size.width / 2,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the radius as needed
                          color: Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_box,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "ProFile",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginMain()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 250),
                      child: Container(
                        width: size.width / 2,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the radius as needed
                          color: Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Гарах",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
