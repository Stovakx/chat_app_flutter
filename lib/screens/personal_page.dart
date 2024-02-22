import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalPage extends StatelessWidget {
  final String id;

  const PersonalPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream:
          FirebaseFirestore.instance.collection('Users').doc(id).snapshots(),
      builder: (context, snapshot) {
        //když se data načítají
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(""),
              centerTitle: true,
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        //zobrazení po načtení dat
        var userData = snapshot.data!.data() as Map<String, dynamic>;
        return Scaffold(
            appBar: AppBar(
              title: Text(userData["fullName"]),
              centerTitle: true,
            ),
            body: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      children: [Text("Photo Here"),Text("Photo Here"),Text("Photo Here"),Text("Photo Here"),Text("Photo Here"),],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8,),
                          child: Row(
                            children: [
                              const Text(
                                "Full Name: ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                userData["fullName"],
                                style: const TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left:13),
                          child: Row(
                            children: [
                              const Text(
                                "Email: ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                userData['email'],
                                style: const TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                )));
      },
    );
  }
}
