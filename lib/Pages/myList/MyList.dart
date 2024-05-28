// ignore_for_file: prefer_const_constructors, unused_field, unused_import

import 'dart:convert';

import 'package:bird_ebook/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Models/MyLists.dart';
import '../../components/modalForm.dart';
import '../../post@get/api.dart';

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  bool _isModalOpen = false;

  // Function to update the state when the modal is dismissed
  void _updateModalState(bool isOpen) {
    setState(() {
      _isModalOpen = isOpen;
      if (isSaved) {
        Navigator.pop(context);
      } else {
        getMyLists(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getMyLists(context);
  }

  getMyLists(BuildContext ctx) {
    GetMyLists(ctx).then((value) {
      setState(() {
        myLists = value;
      });
    });
  }

  MyLists _myList = MyLists();

  editList(MyLists birdPk, ctx) {
    List<int> updatedList = birdPk.tCBIRDPK!;
    updatedList.add(int.parse(saveBirdPk));
    _myList = MyLists(
        pk: birdPk.pk,
        tCUSERPK: userField.id.toString(),
        tCLOCATIONSPK: "1",
        tCBIRDPK: updatedList,
        tCLISTNAME: birdPk.tCLISTNAME,
        tCDATE: birdPk.tCDATE);
    String json = jsonEncode(_myList);
    EditMyLists(json, ctx).then((value) {
      setState(() {
        myLists = value;
        isSaved = true;
        Navigator.pop(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Жагсаалт"),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [Color(0xFF860000), Color(0xFFEB1933)],
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
            child: Image.asset(
              "assets/icons/return.png",
              scale: 2,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => MyForm(
                    onClose: _updateModalState,
                  ),
                );
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: size.width,
          height: size.height,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: myLists.length,
            itemBuilder: (BuildContext ctx, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    editList(myLists[index], context);
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
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Text(
                                myLists[index].tCLISTNAME.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Text(DateFormat('yyyy-MM-dd').format(
                                DateTime.parse(myLists[index].tCDATE!))),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Нийт хадгалсан шувуу"),
                          Text(
                            myLists[index].tCBIRDPK!.length.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
