// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_constructors, unnecessary_new, prefer_interpolation_to_compose_strings, use_build_context_synchronously, prefer_typing_uninitialized_variables, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Models/UserIcons.dart';
import '../Models/Users.dart';
import '../constant.dart';
import 'package:http/http.dart' as http;

Future<String> CreateUserPost(Users body, BuildContext ctx) async {
  try {
    final uri = Uri.http(backUrl, '/createUser/');
    final jsonBody = jsonEncode(body.toMap()); // Convert Users object to JSON
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      // Handle error response
      print('Failed to create user: ${response.body}');
      // Display error message to the user or take appropriate action
    }
  } catch (e) {
    print('Error creating user: $e');
    // Handle network or other errors
  }
  throw Exception('Unexpected control flow');
}

Future<String> LoginUserPost(Users body, BuildContext ctx) async {
  try {
    final uri = Uri.http(backUrlT, '/loginUser/');
    final jsonBody = jsonEncode(body.toMap());
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );

    String responseB = utf8.decode(response.body.runes.toList());

    return responseB;
  } catch (e) {
    print('Error creating user: $e');
    // Handle network or other errors
    throw Exception('Error creating user: $e');
  }
}

Future<String> GetBirds(BuildContext ctx) async {
  try {
    final uri = Uri.http(backUrl, '/getBirds/');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    String responseB = utf8.decode(response.body.runes.toList());
    print(responseB);
    return responseB;
  } catch (e) {
    print('Error creating user: $e');
    // Handle network or other errors
    throw Exception('Error creating user: $e');
  }
}

Future<List<UserIcons>> GetIcons(BuildContext ctx) async {
  var response;
  var responseBodyD;
  Map<String, dynamic> responseBody;
  try {
    final uri = Uri.http(backUrlT, '/getIcons/');
    response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    responseBodyD = utf8.decode(response.bodyBytes);
    print(responseBodyD);

    // return responseB;
  } catch (e) {
    print('Error creating user: $e');
    // Handle network or other errors
    throw Exception('Error creating user: $e');
  }

  var getList = <UserIcons>[];
  if (response.statusCode == 200) {
    // Parse the response body as a map
    responseBody = json.decode(responseBodyD);
    // Extract the list from the map
    var bodyList = responseBody['body'];
    // Iterate over the list and add UserIcons objects to getList
    for (var gJson in bodyList) {
      getList.add(UserIcons.fromJson(gJson));
    }
    icons = getList;
    return getList;
  } else if (response.statusCode == 404) {
    print("responseBody");
  } else {
    toasty(ctx, "Сервэрийн алдаа: " + response.statusCode,
        bgColor: Colors.redAccent,
        textColor: whiteColor,
        gravity: ToastGravity.BOTTOM,
        length: Toast.LENGTH_LONG);
    throw "Unable to retrieve posts.";
  }
  return <UserIcons>[];
}

Future<String> EditUserPost(Users body, BuildContext ctx) async {
  var response;
  var responseBodyD;
  Map<String, dynamic> responseBody;
  try {
    final uri = Uri.http(backUrlT, '/postUpdUser/');
    final jsonBody = jsonEncode(body.toMap());
    response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );

    responseBodyD = utf8.decode(response.body.runes.toList());

    // return responseB;
  } catch (e) {
    print('Error creating user: $e');
    // Handle network or other errors
    throw Exception('Error creating user: $e');
  }
  var getList = Users();
  if (response.statusCode == 200) {
    responseBody = json.decode(responseBodyD);
    var bodyList = responseBody['body'];
    getList = Users.fromJson(bodyList);
    userField = getList;
    return response.statusCode.toString();
  } else if (response.statusCode == 404) {
    print("responseBody");
  } else {
    toasty(ctx, "Сервэрийн алдаа: " + response.statusCode,
        bgColor: Colors.redAccent,
        textColor: whiteColor,
        gravity: ToastGravity.BOTTOM,
        length: Toast.LENGTH_LONG);
    throw "Unable to retrieve posts.";
  }
  return "s";
}
