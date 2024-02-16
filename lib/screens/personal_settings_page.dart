import 'package:chatapp/auth/auth_service.dart';
import 'package:chatapp/widgets/my_button.dart';
import 'package:flutter/material.dart';

class PersonalSettingsPage extends StatefulWidget {
  const PersonalSettingsPage({Key? key}) : super(key: key);

  @override
  _PersonalSettingsPageState createState() => _PersonalSettingsPageState();
}

class _PersonalSettingsPageState extends State<PersonalSettingsPage> {
  final AuthService _authService = AuthService();
  //TODO:
  //stylizace, udělat větší padding když isEditting = false, aby při překliknutí se nezvětšoval tak prostor.. 
  //funkce pro uprávu dat v auth_service funkce taky... 
  //
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal settings"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildEditableField("Full name:", "John Doe"),
            buildEditableField("Birth Date:", "01/01/1990"),
            buildEditableField("Phone number:", "+1234567890"),
            buildEditableField("Location:", "New York, USA"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                  text: "apply",
                  onTap: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildEditableField(String label, String data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 12),
          isEditing
              ? Expanded(
                  child: TextFormField(
                    initialValue: data,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // Implement logic to update data
                    },
                  ),
                )
              : Text(
                  data,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
        ],
      ),
    );
  }
}
