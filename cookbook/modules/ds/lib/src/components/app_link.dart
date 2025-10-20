import 'package:ds/ds.dart';
import 'package:flutter/material.dart';

class AppLink extends StatelessWidget {
  final AppLinkColor color;
  final VoidCallback? onTap;
  final String label;
  final Widget? icon;

  const AppLink(
      {super.key,
      required this.label,
      this.color = AppLinkColor.principal,
      this.onTap,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final auxColor = switch(color) {
      AppLinkColor.principal => AppColor.primary.main,
      AppLinkColor.neutral => AppColor.neutral.main,
      AppLinkColor.success => AppColor.success.main,
      AppLinkColor.danger => AppColor.danger.main,
      AppLinkColor.info => AppColor.info.main,
      AppLinkColor.warning => AppColor.warning.main,
      AppLinkColor.black => AppColor.neutral.alwaysBlack,
      AppLinkColor.light => AppColor.neutral.alwaysWhite,
    };

    final overlayColor = switch(color) {
      AppLinkColor.principal => AppColor.primary.overlayMain,
      AppLinkColor.neutral => AppColor.neutral.overlayMain,
      AppLinkColor.success => AppColor.success.overlayMain,
      AppLinkColor.danger => AppColor.danger.overlayMain,
      AppLinkColor.info => AppColor.info.overlayMain,
      AppLinkColor.warning => AppColor.warning.overlayMain,
      AppLinkColor.black => AppColor.neutral.overlayMain,
      AppLinkColor.light => AppColor.neutral.overlayMain,
    };

    final finalColor = onTap == null ? AppColor.neutral.softer : auxColor;

    return Material(
      child: InkWell(
        hoverColor: overlayColor,
        focusColor: overlayColor,
        overlayColor: WidgetStatePropertyAll(overlayColor),
        onTap: onTap,
        child: Theme(
            data: ThemeData(
              iconTheme: IconThemeData(
                color: finalColor,
                size: AppSizing.x16,
              )
            ),
            child: Ink(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: finalColor))
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: AppSpacing.x4,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: finalColor,
                      fontWeight: FontWeight.w500,
                      fontSize: AppFontSize.base,
                    ),
                  ),
                  if (icon != null) icon!,
                ],
              ),
            ),
        ),
      ),
    );
  }
}

enum AppLinkColor {
  principal,
  neutral,
  success,
  danger,
  info,
  warning,
  black,
  light;
}

Widget linkPageExample() => SingleChildScrollView(
      child: Column(
        spacing: 8.0,
        children: [
          AppLink(
            label: 'Saber mais',
            icon: Icon(Icons.chevron_right),
          ),
          AppLink(
            label: 'Saber mais',
            icon: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          AppLink(
            label: 'Saber mais',
            color: AppLinkColor.neutral,
            icon: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          AppLink(
            label: 'Saber mais',
            color: AppLinkColor.success,
            icon: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          AppLink(
            label: 'Saber mais',
            color: AppLinkColor.danger,
            icon: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          AppLink(
            label: 'Saber mais',
            color: AppLinkColor.info,
            icon: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          AppLink(
            label: 'Saber mais',
            color: AppLinkColor.warning,
            icon: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          AppLink(
            label: 'Saber mais',
            color: AppLinkColor.black,
            icon: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Container(
            color: Colors.black,
            child: AppLink(
              label: 'Saber mais',
              color: AppLinkColor.light,
              icon: Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
