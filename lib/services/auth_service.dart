import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:techconnect_frontend/models/new_user_dto.dart';
import 'package:techconnect_frontend/utils/constants.dart';
class AuthService extends ChangeNotifier {

  final String _baseUrl = '172.20.0.3:8090';
  final storage = FlutterSecureStorage();

  Future<String?> signUp(NewUserDto userDto) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final url = Uri.http(_baseUrl, '/api/security/auth/sign-up');
    final response = await http.post(url, headers: headers, body: json.encode(userDto));
    final Map<String, dynamic> decodeResponse = json.decode(response.body);
    print(response.statusCode);
    print(decodeResponse);
    if (decodeResponse.containsKey("httpStatus") && decodeResponse["httpStatus"] == 201) {
      return null;
    }

    if (decodeResponse.containsKey("httpStatus") && decodeResponse["httpStatus"] != 201) {
      return decodeResponse["message"];
    }

    if (decodeResponse.containsKey("password")) {
      return CommonConstant.NOT_VALID_PASSWORD;
    }
    return null;
  }

  // Future<Map<String, dynamic>?> signIn(String username, String password) async {
    Future<String?> signIn(String username, String password) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> body = {"username": username, "password": password};

    final url = Uri.http(_baseUrl, '/api/security/auth/sign-in');
    final response = await http.post(url, headers: headers, body: json.encode(body));
    final Map<String, dynamic> decodeResponse = json.decode(response.body);
    print(response.statusCode);
    print(decodeResponse);
    if (response.statusCode == 200) {
      _saveInStorage(decodeResponse);
      return null;
    }

    if (decodeResponse["errorCode"] == 'BAD_CREDENTIALS') {
      return CommonConstant.BAD_CREDENTIALS;
    }
    return "";
  }

  Future _saveInStorage(Map<String, dynamic> decodeResponse) async {
      await storage.write(key: "accessToken", value: decodeResponse["accessToken"]);
      await storage.write(key: "refreshToken", value: decodeResponse["refreshToken"]);
      await storage.write(key: "idUser", value: decodeResponse["id"].toString());
      await storage.write(key: "username", value: decodeResponse["username"]);
      await storage.write(key: "email", value: decodeResponse["email"]);
      // await storage.write(key: "roles", value: decodeResponse["roles"]);
  }

  Future signOut() async {
    await storage.deleteAll();
    return;
  }

  Future<String> isAuthenticated() async {
    return await storage.read(key: "accessToken") ?? '';
  }
}