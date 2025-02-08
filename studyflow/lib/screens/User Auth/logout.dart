import 'package:flutter/material.dart';
import 'package:studyflow/services/api_service.dart';

import 'signin.dart';

void logout(BuildContext context) async {
  String? token = await ApiService().getToken(); //debugging

  print("Token before logout: $token");

  await ApiService().logout();
  await Future.delayed(Duration(milliseconds: 200)); //optional

  print("Token after logout: $token");
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );
}
