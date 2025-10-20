import 'package:flutter/material.dart';
import 'package:home/src/theme/strings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ModuleStrings.settingsPage),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings),
            Text(ModuleStrings.settingsPage),
          ],
        ),
      ),
    );
  }
}
