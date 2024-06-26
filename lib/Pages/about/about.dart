// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_brace_in_string_interps, avoid_print, prefer_conditional_assignment, unnecessary_null_comparison

import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:bird_ebook/Models/BirdDatas.dart';
import 'package:bird_ebook/Pages/myList/MyList.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../post@get/api.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BirdAbout extends StatefulWidget {
  final BirdDatas data;
  const BirdAbout({super.key, required this.data});

  @override
  State<BirdAbout> createState() => _BirdAboutState();
}

class _BirdAboutState extends State<BirdAbout> {
  AudioPlayer player = AudioPlayer();
  bool isPlay = false;

  var isLoading = false;

  Future<void> playAudioUrl(String url) async {
    await player.play(UrlSource(url));
  }

  void togglePlayPause(String url) {
    setState(() {
      isPlay = !isPlay;
    });

    if (isPlay) {
      playAudioUrl(url);
    } else {
      player.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.data.isSaved);
    if (widget.data.isSaved == null) {
      widget.data.isSaved = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    player.stop();
  }

  removeList(String birdPk, BuildContext ctx) {
    removeBirdLists(birdPk, userField.id, ctx).then((value) {
      setState(() {
        print("value: ");
        print(value);
        var json = jsonDecode(value);

        print("json['statusCode']: ");
        print(json['statusCode']);
        if (json['statusCode'] == "200") {
          widget.data.isSaved = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.detailsTxt ?? ''),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              // height: size.height/2,
              child: Image.network(
                fit: BoxFit.fill,
                'http://${backUrl}/media/${widget.data.tCIMAGES}',
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    return child;
                  }
                  return Container();
                  // retur
                },
              ),
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.data.tCBIRDNAME!,
                      style: TextStyle(fontSize: 30),
                    ),
                    GestureDetector(
                      onTap: () {
                        saveBirdPk = widget.data.pk.toString();
                        if (!widget.data.isSaved!) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyList()),
                          ).then((value) {
                            setState(() {
                              if (isSaved) {
                                print("isSaved");
                                print(isSaved);
                                widget.data.isSaved = true;
                              }

                              isSaved = false;
                            });
                          });
                        } else {
                          removeList(saveBirdPk, context);
                        }
                      },
                      child: Image.asset(
                        widget.data.isSaved!
                            // ignore: dead_code
                            ? "assets/icons/save.png"
                            : "assets/icons/unsave.png",
                      ),
                    ),
                  ],
                )),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  // Container(
                  //   width: size.width,
                  //   child: Text(
                  //     AppLocalizations.of(context)?.soundTxt ?? '',
                  //     style: TextStyle(fontSize: 20),
                  //     textAlign: TextAlign.start,
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            AppLocalizations.of(context)?.soundTxt ?? '',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            final url =
                                'http://${backUrl}/media/${widget.data.tCVOICES}';
                            togglePlayPause(url);
                          },
                          icon: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black),
                            child: Icon(
                              isPlay ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    width: size.width,
                    child: Text(
                      AppLocalizations.of(context)?.indicatorTxt ?? '',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 70,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color(0xFFEB1933),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: Text(
                                  AppLocalizations.of(context)?.sizeTxt ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                widget.data.tCBIRDSIZEPK!,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color(0xFFEB1933),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: Text(
                                  AppLocalizations.of(context)?.lifespanTxt ??
                                      '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                widget.data.tCLIFETIME!,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color(0xFFEB1933),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: Text(
                                  AppLocalizations.of(context)?.habitatTxt ??
                                      '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              FittedBox(
                                child: Text(
                                  widget.data.tCHABITATPK!,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: size.width,
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    child: Text(
                      AppLocalizations.of(context)?.specificationTxt ?? '',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    width: size.width,
                    child: Text(
                      widget.data.tCINFO!,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: size.width,
                    child: widget.data.tCLOCATIONIMG != null
                        ? Image.network(
                            'http://${backUrl}/media/${widget.data.tCLOCATIONIMG}',
                            fit: BoxFit.fill,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) {
                                return child;
                              }
                              return CircularProgressIndicator(
                                value: progress.expectedTotalBytes != null
                                    ? progress.cumulativeBytesLoaded /
                                        progress.expectedTotalBytes!
                                    : null,
                              );
                            },
                          )
                        : Container(), // Placeholder or any other widget you want to show if image URL is null
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
