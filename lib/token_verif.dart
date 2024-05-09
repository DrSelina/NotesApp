import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:test_app_1/main.dart';

final talker = TalkerFlutter.init();

Future tokenAddS(Response response) async {
  final userMap = jsonDecode(response.toString()) as Map<String, dynamic>;
  final user = UserS.fromJson(userMap);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("email", user.email);
  prefs.setString("password", user.password);
  prefs.setString("token", user.accessToken);

  talker.log("${user.email}\n${user.accessToken}\n${user.password}");
}

class UserS {
  final String email;
  final String password;
  final String accessToken;

  UserS(
    this.email,
    this.password,
    this.accessToken,
  );

  UserS.fromJson(Map<String, dynamic> json)
      : email = json['login'] as String,
        password = json['password'] as String,
        accessToken = json['token'] as String;
}

Future tokenAddL(Response response) async {
  final userMap = jsonDecode(response.toString()) as Map<String, dynamic>;
  final user = UserL.fromJson(userMap);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("token", user.accessToken);

  final idTake =
      await dio.get('https://fastapi-simple-notes.vercel.app/users/me/',
          options: Options(
            headers: {'Authorization': "Bearer ${user.accessToken}"},
          ));

  final idMap = jsonDecode(idTake.toString()) as Map<String, dynamic>;
  final userid = UserId.fromJson(idMap);
  prefs.setInt("id", userid.id);

  talker.log(userid.id);
  talker.log(user.accessToken);
}

class UserL {
  final String accessToken;

  UserL(
    this.accessToken,
  );

  UserL.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'] as String;
}

class UserId {
  final dynamic id;

  UserId(
    this.id,
  );

  UserId.fromJson(Map<String, dynamic> json) 
  : id = json['id'] as int;
}
