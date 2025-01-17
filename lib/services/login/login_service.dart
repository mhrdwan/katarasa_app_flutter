// services/login/login_service.dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:katarasa/constants/constants.dart';

Future<dynamic> apiLogin(String? email, String? password) async {
  try {
    final data = await http.post(
        Uri.parse('${Constants.baseUrl}compro/auth/login-corporate'),
        body: {'email': email, 'password': password});
    return json.decode(data.body);
  } catch (e) {
    return null;
  }
}

Future<dynamic> profileUser() async {
  try {
    final token = await Constants().read(key: 'token');
    final data = await http.get(
      Uri.parse('${Constants.baseUrl}compro/auth/data-corporate'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(data);
    return json.decode(data.body);
  } catch (e) {
    print(e);
    return null;
  }
}
