import 'package:chatapp/screens/home_page.dart';
import 'package:chatapp/screens/settings_page.dart';
import 'package:chatapp/utils/functions.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // Custom header drawer
          Container(
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 52,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your App Name',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Položky draweru
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 15),
                      child: ListTile(
                        title: const Text("C H A T S"),
                        leading: const Icon(Icons.home),
                        //funkce hází error (invalid constant)
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: ListTile(
                        title: const Text("S E T T I N G S"),
                        leading: const Icon(Icons.settings),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingsPage()));
                        },
                      ),
                    )
                  ],
                ),
                 Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, bottom: 20),
                      child: ListTile(
                        title: const Text("L O G O U T"),
                        leading: const Icon(Icons.logout),
                        onTap: () => logout(context),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
