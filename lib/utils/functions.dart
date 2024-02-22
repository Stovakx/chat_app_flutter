//logout

import 'package:chatapp/auth/auth_service.dart';
import 'package:flutter/material.dart';

void logout(BuildContext context) {
  final auth = AuthService();
  auth.signOut();
  Navigator.pop(context);
}


//fullName regex validation
bool isValidFullName(String fullName) {
  final RegExp regex = RegExp(r'^[A-Z][a-z]+\s[A-Z][a-z]+$');
  return regex.hasMatch(fullName);
}

//email regex validaation
bool isValidEmail(String email) {
  final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return regex.hasMatch(email);
}
