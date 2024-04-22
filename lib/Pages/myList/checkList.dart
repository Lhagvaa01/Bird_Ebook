// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bird_ebook/Models/BirdDatas.dart';
import 'package:bird_ebook/Pages/myList/MyList.dart';
import 'package:flutter/material.dart';

import '../../Models/MyLists.dart';
import '../../constant.dart';
import '../birdList/AlphabetListScrollView.dart';

class CheckList extends StatefulWidget {
  final MyLists ?mylist;
  const CheckList ({required this.mylist, super.key});

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList > {
List<String> BirdNames = [];
List<BirdDatas> birdDataList = [];
@override
  void initState() {
    super.initState();
    BirdNames = [];
    for(var data in datas){
      if(widget.mylist!.tCBIRDPK!.contains(data.pk)){
        BirdNames.add(data.tCBIRDNAME!);
        birdDataList.add(data);
      }
    }
    print(BirdNames);
    print(birdDataList);
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
      body: AlphabetListScrollView(items: BirdNames, birdDataList: birdDataList),
      
    );
  }
}