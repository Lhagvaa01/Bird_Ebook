// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, sized_box_for_whitespace, avoid_print, avoid_unnecessary_containers, unnecessary_new, use_build_context_synchronously, unused_field

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bird_ebook/Pages/MainPage/main.dart';
import 'package:bird_ebook/Pages/forget/forget.dart';
import 'package:bird_ebook/Pages/profile/proFile.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Models/Users.dart';
import '../../constant.dart';
import '../../main.dart';
import '../../post@get/api.dart';
import '../SignUp/signUp.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginMain extends StatefulWidget {
  final void Function(Locale) changeLanguage;

  const LoginMain({required this.changeLanguage});

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  final email = TextEditingController();
  final password = TextEditingController();
  var isVisiblity = false;
  Timer? _timer;
  late double _progress;

  void changeLanguage(Locale locale) {
    widget.changeLanguage(locale);
  }

  @override
  void initState() {
    super.initState();
    email.text = "maahaliuk@gmail.com";
    password.text = "maa";
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }

  Users _users = Users();

  login(BuildContext ctx) {
    if (email.text.isEmpty || password.text.isEmpty) {
      Alert(
        context: ctx,
        title: "Алдаа",
        desc: "Хэрэглэгчийн нэр болон нууц үг оруулна уу!",
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
    } else {
      _users = Users(tCPASSWORD: password.text, tCEMAIL: email.text);

      LoginUserPost(_users, ctx).then((value) async {
        final responseData = jsonDecode(value);
        final statusCode = responseData['statusCode'];
        final bodyData = responseData['body'];

        print("statusCode: $statusCode");

        if (statusCode == "200") {
          final users = Users.fromJson(bodyData);
          print("bodyData: ");
          print(bodyData);
          userField = users;
          print("Logged in user: ${users.tCUSERNAME}");
          toasty(ctx, "Амжилттай нэвтэрлээ",
              bgColor: Colors.green,
              textColor: whiteColor,
              gravity: ToastGravity.BOTTOM,
              length: Toast.LENGTH_LONG);
          _timer?.cancel();
          await EasyLoading.dismiss();
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HelloConvexAppBar(changeLanguage: changeLanguage)),
          );
        } else {
          await EasyLoading.dismiss();
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
  }

  getUserIcons(BuildContext ctx) {
    GetIcons(ctx).then((value) {
      print("icons[0]: ");
      print(icons[0].image);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        // alignment: AlignmentDirectional.center,
        children: [
          Transform.rotate(
            alignment: Alignment(-0.1, -1.1),
            angle: pi / 4,
            child: Container(
              width: 500,
              height: 800,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF860000),
                    Color(0xFFEB1933)
                  ], // Define your gradient colors
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.66, 3.5], // Optional: Define color stops
                  // tileMode: TileMode.clamp, // Optional: Define tile mode
                ),
              ),
            ),
          ),
          Transform.rotate(
            alignment: Alignment(-4.0, 0.8),
            angle: pi / 4,
            child: Container(
              width: 500,
              height: 800,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF860000),
                    Color(0xFFEB1933)
                  ], // Define your gradient colors
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.66, 3.5], // Optional: Define color stops
                  // tileMode: TileMode.clamp, // Optional: Define tile mode
                ),
              ),
            ),
          ),

          Transform.rotate(
            alignment: Alignment(-5.8, 7.4),
            angle: pi / 4,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.black, width: 12)),
            ),
          ),
          // SizedBox(
          //   height: 200,
          // ),
          Container(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 50, left: 20),
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: size.width / 2,
                        ),
                      ),
                      Container(
                        child: Text(
                          "PLANET MONGOLIA",
                          style: TextStyle(color: Color(0xFFF1DF3F)),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (language == "mn") {
                        language = 'en';
                        changeLanguage(const Locale('en'));
                      } else {
                        language = 'mn';
                        changeLanguage(const Locale('mn'));
                      }
                      print(language);
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 80,
                    margin: EdgeInsets.only(top: 40, right: 30),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xFFCAC7C7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          language == "mn"
                              ? "assets/icons/mn.png"
                              : "assets/icons/usa.png",
                        ),
                        Text(language.toUpperCase()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // SizedBox(
          //   height: 100,
          // ),
          Container(
            padding: EdgeInsets.only(left: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width - 80,
                  height: size.height / 2.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Container(
                        width: size.width - 80,
                        height: 60,
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Text(
                          textAlign: TextAlign.start,
                          AppLocalizations.of(context)?.loginTxt ?? '',
                          style: TextStyle(color: Colors.red, fontSize: 30),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            TextField(
                              controller: email,
                              decoration: InputDecoration(
                                icon: Icon(Icons.person_outlined),
                                labelText: AppLocalizations.of(context)
                                        ?.usernameHint ??
                                    '',
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: password,
                              obscureText: isVisiblity ? true : false,
                              decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisiblity = !isVisiblity;
                                    });
                                  },
                                  icon: isVisiblity
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                ),
                                labelText: AppLocalizations.of(context)
                                        ?.passwordHint ??
                                    '',
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProFile(
                                          changeLanguage: changeLanguage)),
                                );
                              },
                              child: GestureDetector(
                                onTap: () {
                                  getUserIcons(context);
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Forget()),
                                    );
                                  },
                                  child: Container(
                                    width: size.width,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      textAlign: TextAlign.end,
                                      AppLocalizations.of(context)?.forgetTxt ??
                                          '',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: size.width,
                              child: Center(
                                child: Container(
                                  width: size.width / 2,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () async {
                                      _timer?.cancel();
                                      await EasyLoading.show(
                                        status: 'loading...',
                                        maskType: EasyLoadingMaskType.black,
                                        // indicator: Indicator()
                                      );
                                      login(context);
                                    },
                                    child: Text(AppLocalizations.of(context)
                                            ?.loginTxt ??
                                        ''),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpMain()),
                    );
                  },
                  child: Container(
                    // padding: EdgeInsets.all(20),
                    width: size.width - 120,
                    height: 40,
                    decoration: BoxDecoration(
                      // color: Colors.amber,
                      border: Border.all(width: 3, color: Colors.red),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.zero,
                        topRight: Radius.zero,
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child:
                        // Text("")
                        Center(
                      child: Text(
                        AppLocalizations.of(context)?.registerTxt ?? '',
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
