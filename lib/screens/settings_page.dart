import 'package:chatapp/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/functions.dart';
import '../widgets/my_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
              onPressed: () => logout(context), icon: const Icon(Icons.logout))
        ],
      ),
      drawer: const MyDrawer(),
      body: Expanded(
          child: Container(
            padding: const EdgeInsets.only(right: 15, top: 12),
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
            child: Column(
                    children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Dark mode", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                const SizedBox(width: 15,),
                CupertinoSwitch(value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode, onChanged: (value)=> Provider.of<ThemeProvider>(context, listen: false).toggleTheme())
              ],
            )
                    ],
                  ),
          )),
    );
  }
}
