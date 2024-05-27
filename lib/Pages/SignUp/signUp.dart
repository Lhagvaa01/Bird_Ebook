// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, sized_box_for_whitespace, avoid_print, avoid_unnecessary_containers, unnecessary_new, non_constant_identifier_names, unused_import

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../Models/Users.dart';
import '../../constant.dart';
import '../Login/login.dart';
import '../SignUp/signUp.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
// ignore: library_prefixes
import '../../post@get/api.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpMain extends StatefulWidget {
  const SignUpMain({super.key});

  @override
  State<SignUpMain> createState() => _SignUpMainState();
}

class _SignUpMainState extends State<SignUpMain> {
  final username = TextEditingController();
  final password = TextEditingController();

  final cpassword = TextEditingController();
  final email = TextEditingController();
  var isVisiblity = false;
  var isVisiblityC = false;

  Users _users = Users();

  register(BuildContext ctx) {
    if (username.text.isEmpty) {
      Alert(
        context: ctx,
        title: "Алдаа",
        desc: "Хэрэглэгчийн нэр оруулна уу!",
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
      _users = Users(
          tCUSERNAME: username.text,
          tCPASSWORD: password.text,
          tCEMAIL: email.text,
          tCUSERICON: 6
          );

      CreateUserPost(_users, ctx).then((value) {
        toasty(ctx, "Амжилттай бүртгэгдлээ",
            bgColor: Colors.green,
            textColor: whiteColor,
            gravity: ToastGravity.BOTTOM,
            length: Toast.LENGTH_LONG);
        Navigator.pop(context);
      });
    }
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
          FittedBox(
            child: Container(
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
                  Container(
                    height: 45,
                    width: 80,
                    margin: EdgeInsets.only(top: 40, right: 30),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color(0xFFCAC7C7),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/usa.png",
                        ),
                        Text("ENG"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: 100,
          // ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width - 80,
                    height: size.height / 1.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 3, color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Container(
                          width: size.width,
                          padding: EdgeInsets.all(20),
                          child: Text(
                            textAlign: TextAlign.start,
                           AppLocalizations.of(context)?.registerTxt ?? '',
                            style: TextStyle(color: Colors.red, fontSize: 30),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              TextField(
                                controller: username,
                                decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)?.usernameHint ?? '',
                                    border: OutlineInputBorder()),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: email,
                                decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)?.emailHint ?? '',
                                    border: OutlineInputBorder()),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: password,
                                obscureText: isVisiblity ? true : false,
                                decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)?.passwordHint ?? '',
                                    suffixIcon: IconButton(onPressed: (){
                                    setState(() {
                                      isVisiblity = !isVisiblity;
                                    });
                                  }, icon: isVisiblity ? Icon(Icons.visibility_off) : Icon(Icons.visibility),),
                                    border: OutlineInputBorder()),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: cpassword,
                                obscureText: isVisiblityC ? true : false,
                                decoration: InputDecoration(
                                    labelText:AppLocalizations.of(context)?.repeadPasswordHint ?? '',
                                    suffixIcon: IconButton(onPressed: (){
                                    setState(() {
                                      isVisiblityC = !isVisiblityC;
                                    });
                                  }, icon: isVisiblityC ? Icon(Icons.visibility_off) : Icon(Icons.visibility),),
                                    border: OutlineInputBorder()),
                              ),
                              SizedBox(
                                height: 20,
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
                                      onPressed: () {
                                        register(context);
                                      },
                                      child: Text(AppLocalizations.of(context)?.registerTxt ?? ''),
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => LoginMain()),
                      // );
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
                         AppLocalizations.of(context)?.loginTxt ?? '',
                          style: TextStyle(color: Colors.red, fontSize: 25),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
