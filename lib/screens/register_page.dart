
import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import '../auth/login_or_register.dart';
import '../widgets/logintext.dart';
import '../widgets/my_button.dart';
import '../widgets/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  // Textová pole pro heslo a email
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  //přidat firestore nebo databázi pro ostatní údaje
   final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final void Function(PageType) onTap;

  RegisterPage({
    super.key,
    required this.onTap,
  });

  void register(BuildContext context) {
    final auth = AuthService();

    if (_pwController.text == _confirmPwController.text) {
      try {
        auth.signUpWithEmailPassword(_emailController.text, _pwController.text,_firstNameController.text, _lastNameController.text);
      } catch (e) {
        if (!context.mounted) return;
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 50),
              Text(
                "Enter your details to register",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              // Vstupní pole
               MyTextfield(
                hintText: "First Name",
                obscureText: false,
                controller: _firstNameController,
              ),
              const SizedBox(height: 12),
              MyTextfield(
                hintText: "Last Name",
                obscureText: false,
                controller: _lastNameController,
              ),
              const SizedBox(height: 12),
              MyTextfield(
                hintText: "Email",
                obscureText: false,
                controller: _emailController,
              ),
              const SizedBox(height: 12),
              MyTextfield(
                hintText: "Password",
                obscureText: true,
                controller: _pwController,
              ),
              const SizedBox(height: 12),
              MyTextfield(
                hintText: "Confirm password",
                obscureText: true,
                controller: _confirmPwController,
              ),
              const SizedBox(height: 30),
              // Tlačítko pro registraci
              MyButton(
                text: "Register",
                onTap: () => register(context),
              ),
              const SizedBox(height: 10),
              // Text pro přihlášení
              Logintext(
                text: "Already have an account?",
                actionText: "Login now.",
                onTap: () => onTap(PageType.login),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
