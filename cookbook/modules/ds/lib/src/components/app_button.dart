import 'package:ds/ds.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final AppButtonAppearance appearance;
  final AppButtonColor color;
  final AppButtonSize size;
  final bool disabled;
  final bool isLoading;
  final String title;
  final Widget? iconLeft;
  final Widget? iconRight;
  final int? badge;
  final VoidCallback? onPressed;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.appearance = AppButtonAppearance.solid,
    this.color = AppButtonColor.principal,
    this.size = AppButtonSize.medium,
    this.disabled = false,
    this.isLoading = false,
    this.iconLeft,
    this.iconRight,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final overlayColor = switch (color) {
      AppButtonColor.principal => AppColor.primary.overlayMain,
      AppButtonColor.neutral => AppColor.neutral.overlayMain,
      AppButtonColor.success => AppColor.success.overlayMain,
      AppButtonColor.danger => AppColor.danger.overlayMain,
    };
    final mainColor = switch (color) {
      AppButtonColor.principal => AppColor.primary.main,
      AppButtonColor.neutral => AppColor.neutral.main,
      AppButtonColor.success => AppColor.success.main,
      AppButtonColor.danger => AppColor.danger.main,
    };

    return SizedBox(
      height:
          size == AppButtonSize.medium ? AppSizing.shapeMedium : AppSizing.shapeSmall,
      child: switch (appearance) {
        AppButtonAppearance.solid => _solidButton(overlayColor, mainColor),
        AppButtonAppearance.soft => _softButton(overlayColor),
        AppButtonAppearance.surface => _surfaceButton(overlayColor, mainColor),
        AppButtonAppearance.ghost => _ghostButton(overlayColor, mainColor),
        AppButtonAppearance.outline => _outlineButton(overlayColor, mainColor),
      },
    );
  }

  Widget _body({required Color textColor}) {
    final auxBadge = Padding(
      padding: EdgeInsets.only(right: iconRight != null ? AppSpacing.x4 : 0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.neutral.softer,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.symmetric(
            vertical: AppSpacing.x4, horizontal: AppSpacing.x4 + AppSpacing.x1),
        child: Text(
          badge?.toString() ?? '',
          style: TextStyle(
              fontSize: AppFontSize.xs, color: AppColor.neutral.onSofter),
        ),
      ),
    );
    final loading = SizedBox(
      height: AppSizing.iconMedium,
      width: AppSizing.iconMedium,
      child: CircularProgressIndicator(
        color: textColor,
        strokeWidth: AppSizing.x2,
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconLeft != null && isLoading) loading,
        if (iconLeft != null && !isLoading) iconLeft!,
        Padding(
          padding: EdgeInsets.only(
            left: iconLeft != null ? AppSpacing.x12 : 0,
            right: iconRight != null || badge != null ? AppSpacing.x12 : 0,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
        if (badge != null && !isLoading) auxBadge,
        if (iconRight != null && !isLoading) iconRight!,
        if (iconLeft == null && isLoading) loading,
      ],
    );
  }

  Widget _solidButton(overlayColor, color) {
    return FilledButton(
      onPressed: disabled || isLoading ? null : onPressed,
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
              disabled ? AppColor.neutral.softest : color),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttons),
          )),
          overlayColor: WidgetStatePropertyAll(overlayColor),
          iconColor: WidgetStatePropertyAll(
              disabled ? AppColor.neutral.soft : AppColor.danger.onMain)),
      child: _body(
          textColor: disabled ? AppColor.neutral.soft : AppColor.danger.onMain),
    );
  }

  Widget _softButton(overlayColor) {
    final auxColor = disabled
        ? AppColor.neutral.softest
        : switch (color) {
            AppButtonColor.principal => AppColor.primary.softest,
            AppButtonColor.neutral => AppColor.neutral.softest,
            AppButtonColor.success => AppColor.success.softest,
            AppButtonColor.danger => AppColor.danger.softest,
          };
    final textAndIconColor = disabled
        ? AppColor.neutral.soft
        : switch (color) {
            AppButtonColor.principal => AppColor.primary.onSoftest,
            AppButtonColor.neutral => AppColor.neutral.onSoftest,
            AppButtonColor.success => AppColor.success.onSoftest,
            AppButtonColor.danger => AppColor.danger.onSoftest,
          };

    return FilledButton(
      onPressed: disabled || isLoading ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(auxColor),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.buttons),
        )),
        overlayColor: WidgetStatePropertyAll(overlayColor),
        iconColor: WidgetStatePropertyAll(textAndIconColor),
      ),
      child: _body(textColor: textAndIconColor),
    );
  }

  Widget _outlineButton(overlayColor, color) {
    return FilledButton(
      onPressed: disabled || isLoading ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColor.surface.colorless),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttons),
            side: BorderSide(
                color: disabled ? AppColor.neutral.softest : color))),
        overlayColor: WidgetStatePropertyAll(overlayColor),
        iconColor:
            WidgetStatePropertyAll(disabled ? AppColor.neutral.soft : color),
      ),
      child: _body(textColor: disabled ? AppColor.neutral.soft : color),
    );
  }

  Widget _ghostButton(overlayColor, color) {
    return FilledButton(
      onPressed: disabled || isLoading ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColor.surface.colorless),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.buttons),
        )),
        overlayColor: WidgetStatePropertyAll(overlayColor),
        iconColor:
            WidgetStatePropertyAll(disabled ? AppColor.neutral.softer : color),
      ),
      child: _body(textColor: disabled ? AppColor.neutral.softer : color),
    );
  }

  Widget _surfaceButton(overlayColor, color) {
    return FilledButton(
      onPressed: disabled || isLoading ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColor.surface.defaults),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.buttons),
            side: BorderSide(color: AppColor.neutral.softest))),
        overlayColor: WidgetStatePropertyAll(overlayColor),
        iconColor:
            WidgetStatePropertyAll(disabled ? AppColor.neutral.softer : color),
      ),
      child: _body(textColor: disabled ? AppColor.neutral.softer : color),
    );
  }
}

enum AppButtonAppearance {
  solid,
  outline,
  soft,
  ghost,
  surface;
}

enum AppButtonColor {
  principal,
  neutral,
  success,
  danger;
}

enum AppButtonSize {
  medium,
  small;
}

Widget buttonPageExample() => SingleChildScrollView(
      child: Column(
        spacing: 4.0,
        children: [
          Text('SOLID'),
          _example(
            appearance: AppButtonAppearance.solid,
            color: AppButtonColor.principal,
            size: AppButtonSize.small,
            disabled: true,
          ),
          _example(
            appearance: AppButtonAppearance.solid,
            color: AppButtonColor.principal,
            isLoading: true,
          ),
          _example(
            appearance: AppButtonAppearance.solid,
            color: AppButtonColor.neutral,
          ),
          _example(
            appearance: AppButtonAppearance.solid,
            color: AppButtonColor.success,
          ),
          _example(
            appearance: AppButtonAppearance.solid,
            color: AppButtonColor.danger,
          ),
          AppDivider(),
          Text('SOFT'),
          _example(
            appearance: AppButtonAppearance.soft,
            color: AppButtonColor.principal,
            size: AppButtonSize.small,
            disabled: true,
          ),
          _example(
            appearance: AppButtonAppearance.soft,
            color: AppButtonColor.principal,
            isLoading: true,
          ),
          _example(
            appearance: AppButtonAppearance.soft,
            color: AppButtonColor.neutral,
          ),
          _example(
            appearance: AppButtonAppearance.soft,
            color: AppButtonColor.success,
          ),
          _example(
            appearance: AppButtonAppearance.soft,
            color: AppButtonColor.danger,
          ),
          AppDivider(),
          Text('OUTLINE'),
          _example(
            appearance: AppButtonAppearance.outline,
            color: AppButtonColor.principal,
            size: AppButtonSize.small,
            disabled: true,
          ),
          _example(
            appearance: AppButtonAppearance.outline,
            color: AppButtonColor.principal,
            isLoading: true,
          ),
          _example(
            appearance: AppButtonAppearance.outline,
            color: AppButtonColor.neutral,
          ),
          _example(
            appearance: AppButtonAppearance.outline,
            color: AppButtonColor.success,
          ),
          _example(
            appearance: AppButtonAppearance.outline,
            color: AppButtonColor.danger,
          ),
          AppDivider(),
          Text('GHOST'),
          _example(
            appearance: AppButtonAppearance.ghost,
            color: AppButtonColor.principal,
            size: AppButtonSize.small,
            disabled: true,
          ),
          _example(
            appearance: AppButtonAppearance.ghost,
            color: AppButtonColor.principal,
            isLoading: true,
          ),
          _example(
            appearance: AppButtonAppearance.ghost,
            color: AppButtonColor.neutral,
          ),
          _example(
            appearance: AppButtonAppearance.ghost,
            color: AppButtonColor.success,
          ),
          _example(
            appearance: AppButtonAppearance.ghost,
            color: AppButtonColor.danger,
          ),
          AppDivider(),
          Text('SURFACE'),
          _example(
            appearance: AppButtonAppearance.surface,
            color: AppButtonColor.principal,
            size: AppButtonSize.small,
            disabled: true,
          ),
          _example(
            appearance: AppButtonAppearance.surface,
            color: AppButtonColor.principal,
            isLoading: true,
          ),
          _example(
            appearance: AppButtonAppearance.surface,
            color: AppButtonColor.neutral,
          ),
          _example(
            appearance: AppButtonAppearance.surface,
            color: AppButtonColor.success,
          ),
          _example(
            appearance: AppButtonAppearance.surface,
            color: AppButtonColor.danger,
          ),
        ],
      ),
    );

Widget _example(
        {required AppButtonAppearance appearance,
        required AppButtonColor color,
        AppButtonSize size = AppButtonSize.medium,
        bool disabled = false,
        bool isLoading = false}) =>
    AppButton(
      title: 'Mensagens',
      appearance: appearance,
      color: color,
      size: size,
      isLoading: isLoading,
      onPressed: () {},
      disabled: disabled,
      iconLeft: Icon(Icons.message_sharp),
      iconRight: Icon(Icons.chevron_right),
      badge: 3,
    );
