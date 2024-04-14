// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, sized_box_for_whitespace, avoid_print

import 'package:bird_ebook/Pages/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Models/UserIcons.dart';
import '../../Models/Users.dart';
import '../../constant.dart';
import '../../post@get/api.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<UserIcons> filteredItems = [];

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  var isVisiblity = true;

  @override
  void initState() {
    super.initState();
    filteredItems =
        icons.where((item) => item.id == userField.tCUSERICON).toList();
    email.text = userField.tCEMAIL!;
    password.text = userField.tCPASSWORD!;
    name.text = userField.tCUSERNAME!;
  }

  Users _users = Users();

  userFieldUpdate(BuildContext ctx) {
    _users = Users(
        id: userField.id,
        tCEMAIL: email.text,
        tCPASSWORD: password.text,
        tCUSERNAME: name.text,
        tCUSERICON: filteredItems[0].id);
    EditUserPost(_users, ctx).then((value) {
      setState(() {
        if (value == "200") {
          toasty(ctx, "Амжилттай хадгаллаа",
              bgColor: Colors.green,
              textColor: whiteColor,
              gravity: ToastGravity.BOTTOM,
              length: Toast.LENGTH_LONG);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("EDIT PROFILE"),
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
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30.0,
              ), // Adjust the top padding as needed
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.5,
                            color: Color.fromARGB(255, 236, 30, 30)),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Image.network(
                        'http://${backUrlT}${filteredItems[0].image}',
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
                      ),
                    ),
                    SizedBox(height: 10), // Add space between circle and text
                    Text(
                      userField.tCUSERNAME!,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: icons.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        filteredItems[0] = icons[index];
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Image.network(
                        'http://${backUrlT}${icons[index].image}',
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
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 40, left: 50, right: 50),
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About you",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: "Хэрэглэгчийн нэр",
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: password,
                                obscureText: isVisiblity ? true : false,
                    decoration: InputDecoration(
                      labelText: "Нууц үг",
                        suffixIcon: IconButton(onPressed: (){
                                    setState(() {
                                      isVisiblity = !isVisiblity;
                                    });
                                  }, icon: isVisiblity ? Icon(Icons.visibility_off) : Icon(Icons.visibility),),
                                   
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: "Э-Мэйл хаяг",
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
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
                            userFieldUpdate(context);
                          },
                          child: Text(
                            'Хадгалах',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
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
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginMain()),
                            );
                          },
                          child: Text(
                            'Гарах',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
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
