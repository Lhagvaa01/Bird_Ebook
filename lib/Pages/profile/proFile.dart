// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps

import 'dart:math';

import 'package:bird_ebook/Models/MyLists.dart';
import 'package:bird_ebook/Pages/editProfile/editProfile.dart';
import 'package:bird_ebook/Pages/myList/checkList.dart';
import 'package:bird_ebook/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Models/UserIcons.dart';
import '../../post@get/api.dart';
import 'package:avatar_glow/avatar_glow.dart';

class ProFile extends StatefulWidget {
  const ProFile({super.key});

  @override
  State<ProFile> createState() => _ProFileState();
}

class _ProFileState extends State<ProFile> {
  List<UserIcons> filteredItems = [];
  bool _animate = true;
  @override
  void initState() {
    super.initState();
    filteredItems =
        icons.where((item) => item.id == userField.tCUSERICON).toList();
    getMyLists(context);
  }

  getMyLists(BuildContext ctx) {
    GetMyLists(ctx).then((value) {
      setState(() {
        myLists = value;
        print("icons[0]: ");
        print(myLists.length);
      });
    });
  }

  int sumNum = 0;
  String sumBirdNumber() {
    sumNum = 0;
    for (MyLists bird in myLists) {
      sumNum += bird.tCBIRDPK!.length;
    }
    return sumNum.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                // padding: EdgeInsets.only(top: 30),
                child: Image.asset(
                  "assets/images/slider1.jpg",
                  fit: BoxFit.cover,
                  height: size.height / 3,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  Container(
                    width: size.width,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF860000), Color(0xFFEB1933)],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        stops: [0.1, 3.5],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 50),
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Edit profile",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      //  rossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your list",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  sumBirdNumber(),
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 240, 6, 6),
                                      fontSize: 30),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Favorite Birds",
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    indent: 20,
                    endIndent: 20,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: size.height / 1.67,
            left: 0,
            right: 0,
            bottom: 10,
            child: ListView(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: size.height / 3.5,
                        width: 360,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: myLists.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CheckList(mylist: myLists[index])),
                                  );
                                });
                              },
                              child: Container(
                                // margin: EdgeInsets.symmetric(horizontal: 10),
                                margin: EdgeInsets.only(bottom: 20),
                                padding: EdgeInsets.all(10),
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FittedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              myLists[index]
                                                  .tCLISTNAME
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          Text(DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(
                                                  myLists[index].tCDATE!))),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Нийт хадгалсан шувуу"),
                                        Text(
                                          myLists[index]
                                              .tCBIRDPK!
                                              .length
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height / 3.8,
            left: size.width / 5.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child:
                AvatarGlow(
                  animate: _animate,
                  child: Material(
                    elevation: 8.0,
                    shape: const CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      radius: 30,
                      child: Image.network(
                        scale: 0.5,
                        'http://${backUrlT}${filteredItems[0].image}',
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
                  ),
                ),

                ),
                Text(
                  userField.tCUSERNAME!,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
