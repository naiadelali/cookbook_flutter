import 'package:ds/ds.dart';
import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  final AppDividerAppearance appearance;
  final AppDividerOrientation orientation;
  final String? label;

  const AppDivider(
      {super.key,
      this.appearance = AppDividerAppearance.solid,
      this.orientation = AppDividerOrientation.horizontal,
      this.label});

  @override
  Widget build(BuildContext context) {
    var color = appearance == AppDividerAppearance.soft
        ? AppColor.neutral.softer
        : AppColor.neutral.main;
    var text = Text(
      label ?? '',
      style: TextStyle(
        color: AppColor.neutral.main,
        height: AppLineHeight.x150,
        fontSize: AppFontSize.base,
        letterSpacing: AppLetterSpacing.normal,
      ),
    );

    return orientation == AppDividerOrientation.horizontal
        ? Row(
            spacing: AppSpacing.x12,
            children: [
              Flexible(child: Divider(color: color)),
              if (label != null) ...[
                text,
                Flexible(child: Divider(color: color))
              ]
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.x12,
            children: [
              VerticalDivider(
                color: color,
              ),
              if (label != null) ...[text, VerticalDivider(color: color)]
            ],
          );
  }
}

enum AppDividerAppearance {
  soft,
  solid;
}

enum AppDividerOrientation {
  horizontal,
  vertical;
}

Widget dividerPageExample() => Column(
      children: [
        AppDivider(
          appearance: AppDividerAppearance.soft,
          orientation: AppDividerOrientation.horizontal,
        ),
        AppDivider(
          appearance: AppDividerAppearance.solid,
          orientation: AppDividerOrientation.horizontal,
          label: 'Divider',
        ),
        AppDivider(
          appearance: AppDividerAppearance.soft,
          orientation: AppDividerOrientation.vertical,
        ),
        AppDivider(
          appearance: AppDividerAppearance.solid,
          orientation: AppDividerOrientation.vertical,
          label: 'Divider',
        )
      ],
    );
