// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_constructors, unnecessary_new

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

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
    final uri = Uri.http(backUrl, '/loginUser/');
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

Future<String> GetBirds( BuildContext ctx) async {
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

