import 'package:flutter/material.dart';

import '../screens/forgot_password_page.dart';
import '../screens/login_page.dart';
import '../screens/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  var currentPage = PageType.login;

  void togglePages(PageType pageType) {
    setState(() {
      currentPage = pageType;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (currentPage) {
      case PageType.login:
        return LoginPage(
          onTap: (pageType) => togglePages(pageType), 
        );
      case PageType.register:
        return RegisterPage(
          onTap: (pageType) => togglePages(pageType), 
        );
        case PageType.forgotPassword:
        return ForgotPasswordPage(
          onTap: (pageType) => togglePages(pageType)
        );
      default:
        return Container();
    }
  }
}

enum PageType {
  login,
  register,
  forgotPassword,
}
