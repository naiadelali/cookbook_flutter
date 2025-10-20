import 'package:flutter/material.dart';
import 'package:home/src/theme/strings.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ModuleStrings.explorePage),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.explore),
            Text(ModuleStrings.explorePage),
          ],
        ),
      ),
    );
  }
}
