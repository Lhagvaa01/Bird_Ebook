// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:bird_ebook/Pages/identify%20a%20bird/bodyShape.dart';
import 'package:bird_ebook/Pages/identify%20a%20bird/habitat.dart';
import 'package:flutter/material.dart';

class RoundedRadioButton extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const RoundedRadioButton({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!value) {
          onChanged?.call(true);
        }
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: value
            ? Center(
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class Habitat extends StatefulWidget {
  const Habitat({Key? key}) : super(key: key);

  @override
  State<Habitat> createState() => _HabitatState();
}

class _HabitatState extends State<Habitat> {
  String selectedOption = 'Option 1'; // Initialize selectedOption
  List<String> features = [
    'river valley',
    'urban',
    'taiga forest; Woodland',
    'parks, Gardens',
    'desert; semi-desert, arid steppe',
    'Farmland',
    'steppe',
    'mountain, slope, high altitude',
    'tundra',
  ];
  String selectedFeature = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        title: Text("Дэлгэрэнгүй хайлт"),
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
            "Эдгээр шүүлтүүрийг ашиглан хайж буй шувуугаа олоорой",
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
              "Амьдрах орчин",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: features.map((String feature) {
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10), // Add padding between radio buttons
                  child: Row(
                    children: [
                      RoundedRadioButton(
                        value: selectedFeature == feature,
                        onChanged: (bool? value) {
                          if (value ?? false) {
                            setState(() {
                              selectedFeature = feature;
                            });
                          }
                        },
                      ),
                      SizedBox(width: 10),
                      Text(
                        feature,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                );
              }).toList(),
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
                      MaterialPageRoute(builder: (context) => BodyShape()),
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
