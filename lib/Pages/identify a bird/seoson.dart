// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

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

class Season extends StatefulWidget {
  const Season({Key? key}) : super(key: key);

  @override
  State<Season> createState() => _SeasonState();
}

class _SeasonState extends State<Season> {
  String selectedOption = 'Улаанбаатар';
  List<String> features = [
    'Any time of year',
    'Breeding',
    'Spring migration',
    'Autumn Migration',
    'Wintering'
  ];
  String selectedFeature = '';

  List<String> AimagNers = [
    "Улаанбаатар",
    "Архангай",
    "Баян-Өлгий",
    "Баянхонгор",
    "Булган",
    "Говь-Алтай",
    "Говьсүмбэр",
    "Дархан-Уул",
    "Дорноговь",
    "Дорнод",
    "Дундговь",
    "Завхан",
    "Орхон",
    "Өвөрхангай",
    "Өмнөговь",
    "Сүхбаатар",
    "Сэлэнгэ",
    "Төв",
    "Увс",
    "Ховд",
    "Хөвсгөл",
    "Хэнтий"
  ];


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: Image.asset(
              "assets/icons/return.png",
              scale: 2,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 35, left: 60, right: 60),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Add border
                borderRadius: BorderRadius.circular(10), // Add border radius
              ),
              child: SizedBox(
                width: double.infinity,
                child: DropdownButton<String>(
                  value: selectedOption,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 20,
                  style: TextStyle(color: Colors.black),
                  underline: Container(), 
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedOption = newValue!;
                    });
                  },
                  isExpanded: true,
                  items: AimagNers.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(child: Text(value)), 
                    );
                  }).toList(), 
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Set the border radius
              child: Image.asset(
                "assets/images/Map Images/${selectedOption}.png",
                fit: BoxFit.fitWidth,
                height: size.height / 4,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, right: 60, left: 60),
            width: size.width,
            child: Text(
              "Season",
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
                      Text(feature),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Habitat()),
              );
            },
            child: Container(
              width: size.width,
              padding: EdgeInsets.all(50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 50,
                    color: Color(0xFFEB1933),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
