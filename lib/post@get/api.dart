// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_constructors, unnecessary_new, prefer_interpolation_to_compose_strings, use_build_context_synchronously, prefer_typing_uninitialized_variables, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Models/BirdFamilys.dart';
import '../Models/MyLists.dart';
import '../Models/UserIcons.dart';
import '../Models/Users.dart';
import '../constant.dart';
import 'package:http/http.dart' as http;

Future<String> CreateUserPost(Users body, BuildContext ctx) async {
  try {
    final uri = Uri.http(backUrlT, '/createUser/');
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
    final uri = Uri.http(backUrlT, '/getBirds/');
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

Future<String> GetFamilysDetails(BuildContext ctx, String id) async {
  try {
    final uri = Uri.http(backUrlT, '/get_BirdFilter/' + id + "/");
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

Future<List<MyLists>> GetMyLists(BuildContext ctx) async {
  var response;
  var responseBodyD;
  Map<String, dynamic> responseBody;
  var uri = Uri.http(backUrlT, '/get_MyLists/');
  try {
    if (userField.id.toString() != "null") {
      uri = Uri.http(backUrlT, '/get_MyLists/' + userField.id.toString());
    } else {
      uri = Uri.http(backUrlT, '/get_MyLists/' + "1");
    }
    print(uri);
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

  var getList = <MyLists>[];
  if (response.statusCode == 200) {
    // Parse the response body as a map
    responseBody = json.decode(responseBodyD);
    // Extract the list from the map
    var bodyList = responseBody['body'];
    print(bodyList);
    // Iterate over the list and add UserIcons objects to getList
    for (var gJson in bodyList) {
      getList.add(MyLists.fromJson(gJson));
    }
    myLists = getList;
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
  return <MyLists>[];
}

Future<String> removeBirdLists(birdPk, loginId, BuildContext ctx) async {
  var response;
  var responseBodyD;
  Map<String, dynamic> responseBody;
  try {
    final uri = Uri.http(
        backUrlT, '/removeFavorite/' + loginId.toString() + "/" + birdPk);
    print(uri);
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

  if (response.statusCode == 200) {
    isSaved = false;

    return responseBodyD;
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
  return "";
}

Future<List<MyLists>> EditMyLists(String jsonBody, BuildContext ctx) async {
  var response;
  var responseBodyD;
  Map<String, dynamic> responseBody;
  try {
    final uri = Uri.http(backUrlT, '/edit_MyLists/');
    // final jsonBody = jsonEncode(body);
    final response = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );

    responseBodyD = utf8.decode(response.bodyBytes);
    print(responseBodyD);
    // return responseB;
  } catch (e) {
    print('Error creating user: $e');
    // Handle network or other errors
    throw Exception('Error creating user: $e');
  }
  var getList = <MyLists>[];
  print("object");
  print(jsonDecode(responseBodyD)['statusCode']);

  if (jsonDecode(responseBodyD)['statusCode'] == "200") {
    // Parse the response body as a map
    responseBody = json.decode(responseBodyD);
    // Extract the list from the map
    var bodyList = responseBody['body'];
    print(bodyList);
    // Iterate over the list and add UserIcons objects to getList

    getList.add(MyLists.fromJson(bodyList));
    myLists = getList;
    return getList;
  } else if (jsonDecode(responseBodyD)['statusCode'] == "404") {
    print("responseBody");
  } else {
    toasty(ctx, "Сервэрийн алдаа: " + jsonDecode(responseBodyD)['statusCode'],
        bgColor: Colors.redAccent,
        textColor: whiteColor,
        gravity: ToastGravity.BOTTOM,
        length: Toast.LENGTH_LONG);
    throw "Unable to retrieve posts.";
  }
  return <MyLists>[];
}

Future<String> ForgetPassPost(String jsonBody, BuildContext ctx) async {
  try {
    final uri = Uri.http(backUrlT, '/forgotPass/');
    // final jsonBody = jsonEncode(body);
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

Future<String> GetMyListsSave(MyLists body, BuildContext ctx) async {
  try {
    final uri = Uri.http(backUrlT, '/create_MyLists/');
    final jsonBody = jsonEncode(body);
    print(jsonBody);
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      // Check if the response body is not empty
      if (response.body.isNotEmpty) {
        // Decode the response body using UTF-8 encoding
        String responseB = utf8.decode(response.bodyBytes);
        return responseB;
      } else {
        throw Exception('Empty response body');
      }
    } else {
      throw Exception(
          'HTTP request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error creating user: $e');
    // Handle network or other errors
    throw Exception('Error creating user: $e');
  }
}

Future<String> PostSearchDetail(String body, BuildContext ctx) async {
  var response;
  var responseBodyD;
  Map<String, dynamic> responseBody;
  print(body);

  try {
    final uri = Uri.http(backUrlT, '/post_SearchDetail/');
    print(uri);
    response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    // Try to decode the response body
    try {
      responseBodyD = utf8.decode(response.bodyBytes);
    } catch (e) {
      print('Error decoding response body: $e');
      throw Exception('Error decoding response body: $e');
    }

    print('Response body: $responseBodyD');
  } catch (e) {
    print('Error creating user: $e');
    throw Exception('Error creating user: $e');
  }

  if (response.statusCode == 200) {
    try {
      if (response.body.isNotEmpty) {
        // Decode the response body using UTF-8 encoding
        String responseB = utf8.decode(response.bodyBytes);
        return responseB;
      } else {
        throw Exception('Empty response body');
      }
    } catch (e) {
      print('Error parsing JSON: $e');
      throw Exception('Error parsing JSON: $e');
    }
    // return response.statusCode.toString();
  } else if (response.statusCode == "404") {
    print("Not found: 404");
    return "404";
  } else {
    toasty(ctx, "Server error: ${response.statusCode}",
        bgColor: Colors.redAccent,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        length: Toast.LENGTH_LONG);
    throw "Unable to retrieve posts. Status code: ${response.statusCode}";
  }
}

Future<List<String>> GetDetailJson(BuildContext ctx, String url) async {
  try {
    final uri = Uri.http(backUrlT, url);
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // Check if the response body is not empty
      if (response.body.isNotEmpty) {
        // Decode the response body using UTF-8 encoding
        String responseBody = utf8.decode(response.bodyBytes);
        // Parse the JSON response
        var jsonData = jsonDecode(responseBody);

        // Extract the 'body' field from the JSON response
        var bodyData = jsonData['body'];

        List<String> resultList = [];
        for (var item in bodyData) {
          print(item);
          resultList.add(item.toString());
        }

        // if (bodyData is List) {
        //   // Iterate through the body data if it's a list
        //   for (var item in bodyData) {
        //     // Assuming the item is a map and you need specific field from it, e.g., "TCSEASONNAME"
        //     if (item is Map && item.containsKey('TCSEASONNAME')) {
        //       resultList.add(item['TCSEASONNAME'].toString());
        //     }
        //     if (item is Map && item.containsKey('TCHABITATNAME')) {
        //       resultList.add(item['TCHABITATNAME'].toString());
        //     }
        //     if (item is Map && item.containsKey('TCBODYSHAPEIMG')) {
        //       resultList.add(item['TCBODYSHAPEIMG'].toString());
        //     }
        //     if (item is Map && item.containsKey('TCBIRDSIZENAME')) {
        //       resultList.add(item['TCBIRDSIZENAME'].toString());
        //     }
        //     if (item is Map && item.containsKey('TCPLUMAGECOLOURNAME')) {
        //       resultList.add(item['TCPLUMAGECOLOURNAME'].toString());
        //     }
        //   }
        // } else {
        //   throw Exception('Unexpected JSON format for body');
        // }

        return resultList;
      } else {
        throw Exception('Empty response body');
      }
    } else {
      throw Exception(
          'HTTP request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching details: $e');
    throw Exception('Error fetching details: $e');
  }
}

Future<List<Birdfamilys>> GetFamilys(BuildContext ctx) async {
  var response;
  var responseBodyD;
  Map<String, dynamic> responseBody;
  try {
    final uri = Uri.http(backUrlT, '/get_FamilyNameCount/');
    response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    responseBodyD = utf8.decode(response.bodyBytes);

    // return responseB;
  } catch (e) {
    print('Error creating user: $e');
    // Handle network or other errors
    throw Exception('Error creating user: $e');
  }

  var getList = <Birdfamilys>[];
  if (response.statusCode == 200) {
    // Parse the response body as a map
    responseBody = json.decode(responseBodyD);
    // Extract the list from the map
    var bodyList = responseBody['body'];
    // Iterate over the list and add UserIcons objects to getList
    for (var gJson in bodyList) {
      getList.add(Birdfamilys.fromJson(gJson));
    }
    familys = getList;
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
  return <Birdfamilys>[];
}
