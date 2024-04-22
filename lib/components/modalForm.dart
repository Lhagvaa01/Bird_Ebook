// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:bird_ebook/Models/MyLists.dart';
import 'package:bird_ebook/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../post@get/api.dart';

class MyForm extends StatefulWidget {
  final Function(bool) onClose;
  const MyForm({Key? key, required this.onClose}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final listName = TextEditingController();
  String selectedOption = 'Улаанбаатар';
  List<String> aimagNers = [
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
  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 218, 1, 30), // Set primary color
            ),
            dialogBackgroundColor: Colors.white, // Set background color
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedDate = pickedDate;
      });
  }

  MyLists list = MyLists();

  getMyListsSave(BuildContext ctx) {
    list = MyLists(
        pk: 0,
        tCUSERPK: userField.id.toString(),
        tCLOCATIONSPK: "1",
        tCBIRDPK: [int.parse(saveBirdPk)],
        tCLISTNAME: listName.text,
        tCDATE: formatter.format(selectedDate).toString());
      print("jsonEncode(list)");
      print(jsonEncode(list));
    GetMyListsSave(list, ctx).then((value) {
      print(value);
      var statusCode = jsonDecode(value);
      if (statusCode['statusCode'] == "200") {
        
        isSaved = true;
        Navigator.pop(context);
        widget.onClose(false);

      }
      // print(myLists.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Жагсаалт үүсгэх",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                width: 250,
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
                  items:
                      aimagNers.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(child: Text(value)),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 250, // Set the width of the SizedBox
              child: TextField(
                controller: listName,
                decoration: InputDecoration(
                  labelText: 'Жагсаалтын нэр',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            SizedBox(height: 35),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Огноо сонгох: ${formatter.format(selectedDate)}'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                getMyListsSave(context);
                // Navigator.pop(context);
              },
              child: Text("Хадгалах"),
            ),
          ],
        ),
      ),
    );
  }
}
