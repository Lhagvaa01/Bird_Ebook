// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, sized_box_for_whitespace, avoid_print, avoid_unnecessary_containers, unnecessary_new

import 'dart:convert';
import 'dart:math';

import 'package:bird_ebook/Pages/MainPage/main.dart';
import 'package:bird_ebook/Pages/profile/proFile.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Models/Users.dart';
import '../../constant.dart';
import '../../main.dart';
import '../../post@get/api.dart';
import '../SignUp/signUp.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({super.key});

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email.text = "user";
    password.text = "pass";
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

      LoginUserPost(_users, ctx).then((value) {
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
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HelloConvexAppBar()),
          );
        } else {
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
                    height: size.height / 2.5,
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
                            "Login",
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
                                  labelText: 'Enter your text',
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
                                decoration: InputDecoration(
                                  icon: Icon(Icons.lock),
                                  suffixIcon: Icon(Icons.visibility_off),
                                  labelText: 'Enter your text',
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
                                        builder: (context) => ProFile()),
                                  );
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    getUserIcons(context);
                                  },
                                  child: Container(
                                    width: size.width,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      textAlign: TextAlign.end,
                                      "Forget?",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
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
                                      onPressed: () {
                                        login(context);
                                      },
                                      child: Text('Нэвтрэх'),
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
                          "Sign up",
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
