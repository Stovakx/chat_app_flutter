import 'package:chatapp/auth/auth_service.dart';
import 'package:chatapp/utils/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersonalSettingsPage extends StatefulWidget {
  const PersonalSettingsPage({Key? key}) : super(key: key);

  @override
  _PersonalSettingsPageState createState() => _PersonalSettingsPageState();
}

class _PersonalSettingsPageState extends State<PersonalSettingsPage> {
  final AuthService _authService = AuthService();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  Map<String, dynamic>? userData;
  DateTime selectedDate = DateTime.now();
  bool isEditing = false;

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  //TODO: přidat vyskakovací modal/dialog, kde uživatel bude potvrzovat změny heslem
void changeData() async {
  _authService.getUserData();
  // Uložení kontextu pro použití uvnitř asynchronní operace
  final scaffoldContext = context;

  // Získání hodnot z textových polí
  String fullName = fullNameController.text.trim();
  String email = emailController.text.trim();
  String location = locationController.text.trim();

  // Inicializace prázdné mapy pro změny
  Map<String, dynamic> newData = {};
  
  // Kontrola změn a přidání změněných hodnot do mapy newData
  if (fullName.isNotEmpty && fullName != userData!["fullName"]) {
    // Oveření formátu fullName pomocí regulárního výrazu
    if (!isValidFullName(fullName)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid full name')),
      );
      return;
    }
    newData["fullName"] = fullName;
  }

  if (email.isNotEmpty && email != userData!["email"]) {
    // Oveření formátu emailu pomocí regulárního výrazu
    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email')),
      );
      return;
    }
    newData["email"] = email;
  }

  if (location.isNotEmpty && location != userData!["location"]) {
    newData["location"] = location;
  }

  // Pokud nejsou žádné změny, ukončíme funkci
  if (newData.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No changes detected')),
    );
    return;
  }
  
  try {
    // Aktualizace dat
    await _authService.updateUserData(userData!["uid"], newData);
    if (context.mounted) {
      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
          const SnackBar(content: Text('Data updated successfully')));
    }
    toggleEditing(); // Změna stavu po úspěšné aktualizaci dat
  } catch (e) {
    // Zobrazit chybu ohledně aktualizace
    if (context.mounted) {
      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
        SnackBar(content: Text('Failed to update data: $e')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _authService.getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Personal settings"),
              centerTitle: true,
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Personal settings"),
              centerTitle: true,
            ),
            body: Center(child: Text("Error: ${snapshot.error}")),
          );
        }
        var userData = snapshot.data!.data() as Map<String, dynamic>;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Personal settings"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: isEditing
                  ? [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text("Full Name: ",
                                      style: TextStyle(fontSize: 18)),
                                  TextField(
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        constraints: BoxConstraints(
                                          maxWidth: 150,
                                        ),
                                        hintText: "Full Name"),
                                    controller: fullNameController,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("Email: ",
                                      style: TextStyle(fontSize: 18)),
                                  TextField(
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        constraints: BoxConstraints(
                                          maxWidth: 150,
                                        ),
                                        hintText: "email",
                                        hintStyle: TextStyle(fontSize: 18)),
                                    controller: emailController,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("Birthdate: ",
                                      style: TextStyle(fontSize: 18)),
                                  GestureDetector(
                                    onTap: () async {
                                      final DateTime? newDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: selectedDate,
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime.now(),
                                        initialEntryMode:
                                            DatePickerEntryMode.input,
                                      );
          
                                      if (newDate != null) {
                                        setState(() {
                                          selectedDate = newDate;
                                        });
                                      }
                                    },
                                    child: Text(
                                      "${selectedDate.day}.${selectedDate.month}.${selectedDate.year}",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("Location: ",
                                      style: TextStyle(fontSize: 18)),
                                  TextField(
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        constraints: BoxConstraints(
                                          maxWidth: 150,
                                        ),
                                        hintText: "Location"),
                                    controller: locationController,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.green),
                              onPressed: changeData,
                              child: const Text(
                                "Save changes",
                                style: TextStyle(fontSize: 18),
                              )),
                          TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.red),
                              onPressed: toggleEditing,
                              child: const Text(
                                "Decline",
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ]
                  : [
                      Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Full Name: ",
                                  style: TextStyle(fontSize: 18)),
                              Text("Email: ", style: TextStyle(fontSize: 18)),
                              Text("Birthdate: ",
                                  style: TextStyle(fontSize: 18)),
                              Text("Location: ",
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userData["fullName"],
                                  style: const TextStyle(fontSize: 18)),
                              Text(userData["email"],
                                  style: const TextStyle(fontSize: 18)),
                              Text(
                                userData["birthdate"] ?? "",
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                userData["location"] ?? "",
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.blueAccent),
                            onPressed: toggleEditing,
                            child: const Text("Change data",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
                    ],
            ),
          ),
        );
      },
    );
  }
}
