// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:bird_ebook/Pages/editProfile/editProfile.dart';
import 'package:flutter/material.dart';

class ProFile extends StatefulWidget {
  const ProFile({super.key});

  @override
  State<ProFile> createState() => _ProFileState();
}

class _ProFileState extends State<ProFile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Image.asset(
                  "assets/images/zurg1.jpg",
                  fit: BoxFit.cover,
                  height: size.height / 3.5,
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
                                "Edit Profile",
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
                        Row(
                          children: [
                            Icon(
                              Icons.list,
                              size: 40,
                            ),
                            Text(
                              "Your List",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35),
                            )
                          ],
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
                                  "13",
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
                        height: 70,
                        width: 360,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(245, 218, 218, 215),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Ulaanbatar",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    "29",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70,
                        width: 360,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(245, 218, 218, 215),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Ulaanbatar",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    "29",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70,
                        width: 360,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(245, 218, 218, 215),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Ulaanbatar",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    "29",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70,
                        width: 360,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(245, 218, 218, 215),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Ulaanbatar",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    "29",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                ),
                Text(
                  "Name",
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
