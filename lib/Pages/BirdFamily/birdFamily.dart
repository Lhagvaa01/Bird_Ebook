// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, camel_case_types, unused_local_variable, unnecessary_brace_in_string_interps, sort_child_properties_last, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:bird_ebook/Pages/identify%20a%20bird/habitat.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Models/BirdDatas.dart';
import '../../Models/BirdFamilys.dart';
import '../../constant.dart';
import '../../post@get/api.dart';
import '../about/about.dart';
import '../birdList/birdList.dart';

class birdFamily extends StatefulWidget {
  final void Function(Locale) changeLanguage;

  const birdFamily({Key? key, required this.changeLanguage}) : super(key: key);

  @override
  State<birdFamily> createState() => _birdFamilyState();
}

class _birdFamilyState extends State<birdFamily> {
  List<Birdfamilys> family = [];

  @override
  void initState() {
    super.initState();
    getFamilyGroup(context);
  }

  getFamilyGroup(BuildContext ctx) {
    GetFamilys(ctx).then((value) {
      setState(() {
        family = value;
      });
    });
  }

  Timer? _timer;
  List<BirdDatas> Fadatas = [];
  getBird(BuildContext ctx, id) async {
    GetFamilysDetails(ctx, id).then((value) async {
      final responseData = jsonDecode(value);
      final statusCode = responseData['statusCode'];
      final bodyData = responseData['body'];

      if (statusCode == "200") {
        Fadatas = [];
        setState(() {
          for (var item in bodyData) {
            Fadatas.add(BirdDatas.fromJson(item));
          }
        });

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.birdFamilyTxt ?? '',
        ),
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
        leading: Fadatas.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    Fadatas.clear();
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Image.asset(
                    "assets/icons/return.png",
                    scale: 2,
                  ),
                ),
              )
            : Container(),
      ),
      body: Fadatas.isEmpty
          ? Container(
              padding: EdgeInsets.all(20),
              height: size.height,
              width: size.width,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: family.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return GestureDetector(
                    onTap: () {
                      getBird(ctx, family[index].pk.toString());
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(10),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: CircularProfileAvatar(
                                  '',
                                  child: Image.network(
                                    'http://${backUrl}/${family[index].tCFAMILYIMG}',
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) {
                                        return child;
                                      }
                                      return CircularProgressIndicator(
                                        value: progress.expectedTotalBytes !=
                                                null
                                            ? progress.cumulativeBytesLoaded /
                                                progress.expectedTotalBytes!
                                            : null,
                                      );
                                    },
                                  ),
                                  borderColor: Colors.white,
                                  borderWidth: 2,
                                  elevation: 5,
                                  radius: 50,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FittedBox(
                                child: Text(
                                  familys[index].tCFAMILYNAME.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  AppLocalizations.of(context)?.totalTxt ?? ''),
                              Text(
                                familys[index].birdCount.toString(),
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
            )
          : Container(
              padding: EdgeInsets.only(top: 30),
              height: size.height,
              width: size.width,
              child: ResponsiveGridList(
                horizontalGridMargin: 40,
                // verticalGridMargin: 50,
                minItemWidth: 100,
                children: List.generate(
                  Fadatas.length,
                  (index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BirdAbout(data: Fadatas[index]),
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
                                      ? 'http://${backUrlT}/media/${Fadatas[index].tCIMAGES}'
                                      : 'http://${backUrlT}/media/${Fadatas[index].tCIMAGES}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Fadatas.isNotEmpty
                                ? Image.network(
                                    'http://${backUrlT}/media/${Fadatas[index].tCIMAGES}',
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: progress.expectedTotalBytes !=
                                                  null
                                              ? progress.cumulativeBytesLoaded /
                                                  progress.expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  )
                                : Container(),
                          ),
                          Text(
                            Fadatas[index].tCBIRDNAME!,
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
            ),
    );
  }
}
