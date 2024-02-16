

import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import '../auth/login_or_register.dart';
import '../widgets/logintext.dart';
import '../widgets/my_button.dart';
import '../widgets/my_textfield.dart';

class LoginPage extends StatelessWidget {
  //Text controller pro heslo a email
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final void Function(PageType) onTap;

  LoginPage({super.key, required this.onTap});

  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _pwController.text);
    } catch (e) {
      if (!context.mounted) return;
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // app pic/logo
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),

          //zpráva když se přohlášený uživatel vrátí
          Text(
            "Welcome back, we missed you!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // email
          MyTextfield(
            hintText: "Email",
            obscureText: false,
            controller: _emailController,
            borderRadius: 0,
          ),
          const SizedBox(
            height: 12,
          ),
          //pw
          MyTextfield(
            hintText: "Password",
            obscureText: true,
            controller: _pwController,
            borderRadius: 0,
          ),
          const SizedBox(
            height: 3,
          ),
          Logintext(
            text: "Forgot password?",
            actionText: "Click here.",
            onTap: () => onTap(PageType.forgotPassword),
          ),
          const SizedBox(
            height: 30,
          ),
          //login button
          MyButton(
            text: "Login",
            onTap: () => login(context),
          ),
          const SizedBox(
            height: 10,
          ),
          //register text + link
          Logintext(
            text: "Not a member?",
            actionText: "Register now!",
            onTap: () => onTap(PageType.register),
          ),
        ]),
      ),
    );
  }
}
