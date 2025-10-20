import 'package:flutter/material.dart';

class ShowkaseWidget extends StatelessWidget {
  final String sectionTitle;
  final Widget child;
  const ShowkaseWidget({super.key, required this.sectionTitle, required this.child});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      child: Text(sectionTitle),
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => _ShowkasePage(
          sectionTitle: sectionTitle,
          child: child,
        )),
      ),
    );
  }
}

class _ShowkasePage extends StatelessWidget {
  final String sectionTitle;
  final Widget child;
  const _ShowkasePage({required this.sectionTitle, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(sectionTitle)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: child,
        ),
      ),
    );
  }
}

