import 'package:chatapp/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersonalSettingsPage extends StatefulWidget {
  const PersonalSettingsPage({Key? key}) : super(key: key);

  @override
  _PersonalSettingsPageState createState() => _PersonalSettingsPageState();
}

class _PersonalSettingsPageState extends State<PersonalSettingsPage> {
  final AuthService _authService = AuthService();
  bool isEditing = false;

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
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
          body: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: isEditing
                  ? [
                    //odstramit const potom... nebudou fungovat inputs a apply changes 
                      const Row(
                        children: [
                          Column(
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
                          SizedBox(width: 10,),
                          //inputs
                          Column(
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
                              onPressed: () {},
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
                                userData["birthdate"] ??
                                    "", // Check for null and provide default value
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                userData["location"] ??
                                    "", // Check for null and provide default value
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
