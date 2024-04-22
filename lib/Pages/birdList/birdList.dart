// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_local_variable, non_constant_identifier_names, unused_import, avoid_print

import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

import '../../Models/BirdDatas.dart';
import 'AlphabetListScrollView.dart';

class Birdlist extends StatefulWidget {
  final List<BirdDatas>? birdDataList;
  const Birdlist({Key? key, this.birdDataList}) : super(key: key);

  @override
  State<Birdlist> createState() => _BirdlistState();
}

List<String> BirdNames = [];

class _BirdlistState extends State<Birdlist> {
  final searchField = TextEditingController();
  List<BirdDatas> filteredBirdDataList = [];
  @override
  void initState() {
    super.initState();
    BirdNames = [];
    filteredBirdDataList = widget.birdDataList!;
    for (var name in widget.birdDataList!) {
      BirdNames.add(name.tCBIRDNAME!);
    }
    print(widget.birdDataList!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Шувууны жагсаалт"),
        elevation: 0,
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
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Image.asset(
              "assets/icons/return.png",
              scale: 2,
            ),
          ),
        ),
      ),
      body: AlphabetListScrollView(
          items: BirdNames, birdDataList: filteredBirdDataList),
    );
  }
}
