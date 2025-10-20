import 'package:ds/ds.dart';
import 'package:ds/src/components/app_badge.dart';
import 'package:ds/src/example_pages/showkase_widget.dart';
import 'package:ds/src/example_pages/typography_demo_page.dart';
import 'package:flutter/material.dart';

class DsExamplesPage extends StatelessWidget {
  const DsExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppSpacing.x8,
          children: [
            ShowkaseWidget(
              sectionTitle: 'Switch',
              child: SwitchesDemoPage(),
            ),
            ShowkaseWidget(
              sectionTitle: 'Buttons',
              child: buttonPageExample(),
            ),
            ShowkaseWidget(
              sectionTitle: 'Radio Button',
              child: radioButtonPageExample(),
            ),
            ShowkaseWidget(
              sectionTitle: 'Link',
              child: linkPageExample(),
            ),
            ShowkaseWidget(
              sectionTitle: 'Badge',
              child: appBadgePageExample(),
            ),
            ShowkaseWidget(
              sectionTitle: 'Divider',
              child: dividerPageExample(),
            ),
            ShowkaseWidget(
              sectionTitle: 'Checkbox',
              child: CheckboxesDemoPage(),
            ),
            ShowkaseWidget(
              sectionTitle: 'Tipografia',
              child: TypographyDemoPage(),
            ),
          ],
        ),
      ),
    ));
  }
}
