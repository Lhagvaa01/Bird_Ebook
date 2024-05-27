// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';

import 'package:bird_ebook/Pages/MainPage/main.dart';
import 'package:bird_ebook/Pages/identify%20a%20bird/bodySize.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Models/BirdDatas.dart';
import '../../post@get/api.dart';
import '../birdList/birdList.dart';

class Result extends StatefulWidget {
  final void Function(Locale) changeLanguage;

  const Result({Key? key, required this.changeLanguage}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  List<BirdDatas> datas = [];
  Timer? _timer;
  String body = '''
    {
      "season_id": 1,
      "location_id": 1,
      "habitat_id": 5,
      "body_shape_id": 1,
      "bird_size_id": 4,
      "plumage_colour_id": 8
    }
  ''';

  @override
  void initState() {
    super.initState();
    searchDetail(body, context);
  }

  searchDetail(String body, BuildContext ctx) async {
    PostSearchDetail(body, ctx).then((value) async {
      final responseData = jsonDecode(value);
      final statusCode = responseData['statusCode'];
      final bodyData = responseData['body'];

      print("statusCode: $statusCode");

      if (statusCode == "200") {
        datas = [];
        for (var item in bodyData) {
          setState(() {
            datas.add(BirdDatas.fromJson(item));
          });
          
        }
        // final body = BirdDatas.fromJson(bodyData);
        print(datas);

        _timer?.cancel();
        await EasyLoading.dismiss();

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Birdlist(
        //         birdDataList: datas), // Pass birdDataList argument
        //   ),
        // );
      } else {
        _timer?.cancel();
        EasyLoading.showError('Failed with Error');
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
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.searchButtonTxt ?? ''),
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
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MainPage(changeLanguage: widget.changeLanguage)),
            );
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
          ),
          Text(
            AppLocalizations.of(context)?.findbirdTxt ?? '',
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
              AppLocalizations.of(context)?.resultTxt ?? '',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: size.height / 3.5,
            width: 360,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: datas.length,
              itemBuilder: (BuildContext ctx, int index) {
                return GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             CheckList(mylist: myLists[index])),
                      //   );
                      // });
                    },
                    child: Text(datas[index].tCBIRDNAME!));
              },
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
