import 'package:flutter/material.dart';
import 'package:home/src/theme/strings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ModuleStrings.profilePage),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person),
            Text(ModuleStrings.profilePage),
          ],
        ),
      ),
    );
  }
}
