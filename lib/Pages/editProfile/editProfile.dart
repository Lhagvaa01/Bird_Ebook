// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:bird_ebook/Pages/Login/login.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
      body: Column(
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
                          width: 1.5, color: Color.fromARGB(255, 236, 30, 30)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  SizedBox(height: 10), // Add space between circle and text
                  Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 16),
                  ),
                  
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // ignore: sized_box_for_whitespace
          Container(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
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
                SizedBox(height: 15,),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'User Name',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                   SizedBox(height: 50,),
                  GestureDetector(
                    onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginMain()),
                            );
                          },
                    child: Text(
                    "Log out",
                    style: 
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red, ),
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
