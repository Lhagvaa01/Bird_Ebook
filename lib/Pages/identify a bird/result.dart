// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, sized_box_for_whitespace

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
import '../../constant.dart';
import '../../post@get/api.dart';
import '../about/about.dart';
import '../birdList/birdList.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Result extends StatefulWidget {
  final void Function(Locale) changeLanguage;

  const Result({Key? key, required this.changeLanguage}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  List<BirdDatas> datas = [];
  Timer? _timer;
  bool isEmpty = false;
  String body = '''
    {
      "season_id": 1,
      "location_id": 1,
      "habitat_id": 1,
      "body_shape_id": 1,
      "bird_size_id": 1,
      "plumage_colour_id": 1
    }
  ''';

  @override
  void initState() {
    super.initState();
    searchDetail(jsonEncode(searchBodyJson), context);
  }

  searchDetail(String body, BuildContext ctx) async {
    PostSearchDetail(body, ctx).then((value) async {
      final responseData = jsonDecode(value);
      final statusCode = responseData['statusCode'];
      final bodyData = responseData['body'];

      print("statusCode: $statusCode");

      if (statusCode == "200") {
        if (bodyData.isNotEmpty) {
          datas = [];
          for (var item in bodyData) {
            setState(() {
              datas.add(BirdDatas.fromJson(item));
            });
          }
        } else {
          isEmpty = true;
        }

        _timer?.cancel();
        await EasyLoading.dismiss();
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
      body: SingleChildScrollView(
        child: Column(
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
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
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
                            selectedLocation,
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
                              child: Text(getMounthtxt(),
                                  style: TextStyle(fontSize: 20)))
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
            datas.isNotEmpty
                ? Container(
                    height: size.height / 2.3,
                    width: 360,
                    child: ResponsiveGridList(
                      horizontalGridMargin: 20,
                      // verticalGridMargin: 50,
                      minItemWidth: 100,
                      children: List.generate(
                        datas.length,
                        (index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BirdAbout(data: datas[index]),
                              ),
                            );
                          },
                          child: Container(
                            // padding: const EdgeInsets.all(5),
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              // border: Border.all(),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 100,
                                  // width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        datas.isNotEmpty
                                            ? 'http://${backUrl}/media/${datas[index].tCIMAGES}'
                                            : 'http://${backUrl}/media/${datas[index].tCIMAGES}',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: datas.isNotEmpty
                                      ? Image.network(
                                          'http://${backUrl}/media/${datas[index].tCIMAGES}',
                                          loadingBuilder:
                                              (context, child, progress) {
                                            if (progress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: progress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? progress
                                                            .cumulativeBytesLoaded /
                                                        progress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                        )
                                      : Container(),
                                ),
                                Text(
                                  datas[index].tCBIRDNAME!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    child: Text("Илэрц олдсонгүй"),
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
      ),
    );
  }
}
