// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Models/Users.dart';
import '../../constant.dart';
import '../../post@get/api.dart';

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  final email = TextEditingController();
  final otp = TextEditingController();
  final pass = TextEditingController();

  bool isemail = true;
  bool isotp = false;
  bool ispass = false;

  sendOtp(BuildContext ctx) {
    if (email.text.isEmpty) {
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
      String json = jsonEncode(toJson());
      print(json);
      ForgetPassPost(json, ctx).then((value) {
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
          toasty(ctx, "Мэйл илгээлээ",
              bgColor: Colors.green,
              textColor: whiteColor,
              gravity: ToastGravity.BOTTOM,
              length: Toast.LENGTH_LONG);

          setState(() {
            isemail = false;
            isotp = true;
            ispass = false;
          });
          // Navigator.pop(context);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => HelloConvexAppBar()),
          // );
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TCEMAIL'] = email.text;
    return data;
  }

  checkOtp(ctx) {
    print(otp.text);
    if (otp.text == userField.otpC.toString()) {
      setState(() {
        isemail = false;
        isotp = false;
        ispass = true;
      });
    } else{
      toasty(ctx, "Код буруу байна",
              bgColor: Colors.red,
              textColor: whiteColor,
              gravity: ToastGravity.BOTTOM,
              length: Toast.LENGTH_LONG);
    }
  }


  Users _users = Users();

  userFieldUpdate(BuildContext ctx) {
    _users = Users(
        id: userField.id,
        tCEMAIL: userField.tCEMAIL,
        tCPASSWORD: pass.text,
        tCUSERNAME: userField.tCUSERNAME,
        tCUSERICON: userField.tCUSERICON,
        otpC: 0);
    EditUserPost(_users, ctx).then((value) {
      setState(() {
        if (value == "200") {
          toasty(ctx, "Амжилттай нууц үг солигдлоо",
              bgColor: Colors.green,
              textColor: whiteColor,
              gravity: ToastGravity.BOTTOM,
              length: Toast.LENGTH_LONG);

          Navigator.pop(ctx);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Нууц үг мартсан?"),
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
            Navigator.pop(context);
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.height / 4,
              padding: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Image.asset(
                    "assets/icons/password restore.png",
                  ),
                  Text("Баталгаажуулах код и-мэйл хаяг руу илгээх")
                ],
              ),
            ),
            isemail
                ? Container(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email_outlined),
                        labelText: 'И-Мэйл хаяг оруулна уу',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  )
                : Container(),
            isotp
                ? Container(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: TextField(
                      controller: otp,
                      decoration: InputDecoration(
                        icon: Icon(Icons.code_sharp),
                        labelText: 'Код оруулна уу',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  )
                : Container(),
            ispass
                ? Container(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: TextField(
                      controller: pass,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Шинэ нууц үг',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 30,
            ),
            isemail
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        sendOtp(context);
                      });
                    },
                    child: Container(
                      width: size.width / 2,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius as needed
                        color: Colors.red,
                      ),
                      child: Text(
                        "Илгээх",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                : Container(),
            isotp
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        checkOtp(context);
                      });
                    },
                    child: Container(
                      width: size.width / 2,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius as needed
                        color: Colors.red,
                      ),
                      child: Text(
                        "Шалгах",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                : Container(),
            ispass
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        userFieldUpdate(context);
                      });
                    },
                    child: Container(
                      width: size.width / 2,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius as needed
                        color: Colors.red,
                      ),
                      child: Text(
                        "Хадгалах",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
