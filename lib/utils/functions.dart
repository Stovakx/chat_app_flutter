//logout

import 'package:chatapp/auth/auth_service.dart';
import 'package:flutter/material.dart';

void logout(BuildContext context) {
  final auth = AuthService();
  auth.signOut();
  Navigator.pop(context);
}
