
import 'package:flutter/material.dart';

import '../auth/login_or_register.dart';
import '../widgets/logintext.dart';
import '../widgets/my_button.dart';
import '../widgets/my_textfield.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final void Function(PageType) onTap;
  ForgotPasswordPage({super.key, required this.onTap});
  
  void forgotPassword(){}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "Enter your email to password recovery.",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextfield(hintText: "Your email", obscureText: false, controller: _emailController, borderRadius: 0,),
                      const SizedBox(height: 30),
            // Tlačítko pro registraci
            MyButton(
              text: "Register",
              onTap: forgotPassword,
            ),
            const SizedBox(height: 10),
            // Text pro přihlášení
            Logintext(
              text: "You remembered your password?",
              actionText: "Click here.",
              onTap: () => onTap(PageType.login), 
            ),
        ],
      )),
    );
  }
}
