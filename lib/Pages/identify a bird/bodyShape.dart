// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bird_ebook/Pages/identify%20a%20bird/bodySize.dart';
import 'package:flutter/material.dart';

class BodyShape extends StatefulWidget {
  const BodyShape({super.key});

  @override
  State<BodyShape> createState() => _BodyShapeState();
}

class _BodyShapeState extends State<BodyShape> {
  @override
  
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        title: Text("IDENTIFY A BIRD"),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                Color(0xFF860000),
                Color(0xFFEB1933),
              ],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              stops: const [0.1, 3.5],
            ),
          ),
        ),
        centerTitle: true,
      
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 35, left: 60, right: 60),
          ),
          Text(
            "Use these filters to find the bird you are looking for",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, right: 50, left: 50),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), border: Border.all()),
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        SizedBox(width: 10),
                        FittedBox(
                            child: Text(
                          "Bulgan",
                          style: TextStyle(fontSize: 20),
                        ))
                      ],
                    ),
                  ),
                  VerticalDivider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.access_time),
                        SizedBox(width: 10),
                        FittedBox(
                            child: Text("June", style: TextStyle(fontSize: 20)))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15, right: 30, left: 30),
            child: Divider(
              thickness: 2,
              color: Colors.grey,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, right: 60, left: 60),
            width: size.width,
            child: Text(
              "Body Shape",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_circle_left,
                    size: 50,
                    color: Color(0xFFEB1933),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BodySize()),
                    );
                  },
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 50,
                    color: Color(0xFFEB1933),
                  ),
                ),
              ],
            ),
          ),
     ],
      ),
    );
  }
}
