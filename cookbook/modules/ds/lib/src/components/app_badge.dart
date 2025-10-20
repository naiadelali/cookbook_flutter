import 'package:ds/ds.dart';
import 'package:flutter/material.dart';

Widget preview() {
  return AppBadge(title: 'Teste Wings', icon: Icon(Icons.check_circle_outline));
}

class AppBadge extends StatefulWidget {
  final AppBadgeAppearance appearance;
  final AppBadgeColor color;
  final AppBadgeSize size;
  final String? title;
  final Widget? icon;
  final bool animatePing;

  const AppBadge(
      {super.key,
      this.appearance = AppBadgeAppearance.solid,
      this.color = AppBadgeColor.info,
      this.size = AppBadgeSize.medium,
      this.title,
      this.icon,
      this.animatePing = false});

  @override
  State<AppBadge> createState() => _AppBadgeState();
}

class _AppBadgeState extends State<AppBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    reverseDuration: Duration.zero,
  );
  late final Animation<double> _scaleAnimation =
      Tween<double>(begin: 0.6, end: 1.2).animate(_controller);
  late final Animation<double> _fadeAnimation =
      Tween<double>(begin: 1, end: 0.0).animate(_controller);
  late final _key = GlobalObjectKey(widget.hashCode.toString());
  double _pingWidth = 0.0;
  double _pingHeight = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 500), () {
          if (mounted) {
            _controller.forward(from: 0.0);
          }
        });
      }
    });
    _controller.forward(from: 0.0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _pingHeight = _key.currentContext?.size?.height ?? 0.0;
        _pingWidth = _key.currentContext?.size?.width ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = switch (widget.color) {
      AppBadgeColor.info => AppColor.primary.main,
      AppBadgeColor.neutral => AppColor.neutral.main,
      AppBadgeColor.success => AppColor.success.main,
      AppBadgeColor.danger => AppColor.danger.main,
      AppBadgeColor.warning => AppColor.warning.main,
    };

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        if (widget.animatePing)
          FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: _pingWidth + AppSizing.x8,
                height: _pingHeight + AppSizing.x8,
                decoration: BoxDecoration(
                  borderRadius: widget.appearance == AppBadgeAppearance.ping
                      ? null
                      : BorderRadius.circular(AppRadius.x24),
                  shape: widget.appearance == AppBadgeAppearance.ping
                      ? BoxShape.circle
                      : BoxShape.rectangle,
                  color: mainColor,
                ),
              ),
            ),
          ),
        widget.appearance == AppBadgeAppearance.ping
            ? _pingBadge(mainColor)
            : GestureDetector(
                key: _key,
                onTap: () {},
                child: switch (widget.appearance) {
                  AppBadgeAppearance.solid => _solidBadge(mainColor),
                  AppBadgeAppearance.soft => _softBadge(),
                  AppBadgeAppearance.outline => _outlineBadge(mainColor),
                  AppBadgeAppearance.surface => _surfaceBadge(mainColor),
                  AppBadgeAppearance.ping => SizedBox.shrink(),
                }),
      ],
    );
  }

  Widget _pingBadge(color) {
    final size =
        widget.size == AppBadgeSize.medium ? AppSizing.x14 : AppSizing.x8;
    return Container(
      key: _key,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  Widget _body({required Color textColor, required Color backgroundClose}) {
    return Theme(
      data: ThemeData(
          iconTheme: IconThemeData(
        color: textColor,
        size:
            widget.size == AppBadgeSize.medium ? AppSizing.x16 : AppSizing.x14,
      )),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: AppSpacing.x4,
            horizontal: AppSpacing.x4 + AppSpacing.x1 + AppSpacing.x1),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) widget.icon!,
            if (widget.title != null)
              Padding(
                padding: EdgeInsets.only(
                  left: widget.icon != null ? AppSpacing.x4 : 0,
                  right: AppSpacing.x4,
                ),
                child: Text(
                  widget.title!,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: widget.size == AppBadgeSize.medium
                        ? AppFontSize.sm
                        : AppFontSize.xs,
                  ),
                ),
              ),
            Container(
              decoration: BoxDecoration(
                color: backgroundClose,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(AppSpacing.x1 + AppSpacing.x1),
              child: Icon(
                Icons.close,
                color: textColor,
                size: AppSizing.x12,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _solidBadge(color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.x24),
      ),
      child: _body(
        backgroundClose: AppColor.surface.opaque,
        textColor: AppColor.neutral.onStrong,
      ),
    );
  }

  Widget _softBadge() {
    final softestColor = switch (widget.color) {
      AppBadgeColor.info => AppColor.primary.softest,
      AppBadgeColor.neutral => AppColor.neutral.softest,
      AppBadgeColor.success => AppColor.success.softest,
      AppBadgeColor.danger => AppColor.danger.softest,
      AppBadgeColor.warning => AppColor.warning.softest,
    };
    final softerColor = switch (widget.color) {
      AppBadgeColor.info => AppColor.primary.softer,
      AppBadgeColor.neutral => AppColor.neutral.softer,
      AppBadgeColor.success => AppColor.success.softer,
      AppBadgeColor.danger => AppColor.danger.softer,
      AppBadgeColor.warning => AppColor.warning.softer,
    };
    final textColor = switch (widget.color) {
      AppBadgeColor.info => AppColor.primary.onSofter,
      AppBadgeColor.neutral => AppColor.neutral.onSofter,
      AppBadgeColor.success => AppColor.success.onSofter,
      AppBadgeColor.danger => AppColor.danger.onSofter,
      AppBadgeColor.warning => AppColor.warning.onSofter,
    };
    return Container(
      decoration: BoxDecoration(
        color: softestColor,
        borderRadius: BorderRadius.circular(AppRadius.x24),
      ),
      child: _body(
        textColor: textColor,
        backgroundClose: softerColor,
      ),
    );
  }

  Widget _outlineBadge(color) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.surface.colorless,
        borderRadius: BorderRadius.circular(AppRadius.x24),
        border: Border.all(color: color),
      ),
      child: _body(
        backgroundClose: AppColor.neutral.softest,
        textColor: color,
      ),
    );
  }

  Widget _surfaceBadge(color) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.surface.defaults,
        borderRadius: BorderRadius.circular(AppRadius.x24),
        border: Border.all(color: AppColor.neutral.softest),
      ),
      child: _body(
        backgroundClose: AppColor.neutral.softest,
        textColor: color,
      ),
    );
  }
}

enum AppBadgeAppearance {
  solid,
  soft,
  outline,
  surface,
  ping;
}

enum AppBadgeColor {
  info,
  neutral,
  success,
  danger,
  warning;
}

enum AppBadgeSize {
  medium,
  small;
}

Widget appBadgePageExample() => SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          spacing: 4.0,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('SOLID'),
            _badges(AppBadgeAppearance.solid),
            AppDivider(),
            Text('SOFT'),
            _badges(AppBadgeAppearance.soft),
            AppDivider(),
            Text('OUTLINE'),
            _badges(AppBadgeAppearance.outline),
            AppDivider(),
            Text('SURFACE'),
            _badges(AppBadgeAppearance.surface),
            AppDivider(),
            Text('PING'),
            _badges(AppBadgeAppearance.ping),
          ],
        ),
      ),
    );

Widget _badges(AppBadgeAppearance appearance) => Column(
      spacing: 4.0,
      children: [
        AppBadge(
          appearance: appearance,
          title: "Verified",
          icon: Icon(Icons.check_circle_outline),
          size: AppBadgeSize.small,
        ),
        AppBadge(
          appearance: appearance,
          title: "Verified",
          icon: Icon(Icons.check_circle_outline),
          animatePing: true,
        ),
        AppBadge(
          appearance: appearance,
          title: "Verified",
          icon: Icon(Icons.check_circle_outline),
        ),
        AppBadge(
          appearance: appearance,
          color: AppBadgeColor.neutral,
          title: "Verified",
          icon: Icon(Icons.check_circle_outline),
        ),
        AppBadge(
          appearance: appearance,
          color: AppBadgeColor.success,
          title: "Verified",
          icon: Icon(Icons.check_circle_outline),
        ),
        AppBadge(
          appearance: appearance,
          color: AppBadgeColor.warning,
          title: "Verified",
          icon: Icon(Icons.check_circle_outline),
        ),
        AppBadge(
          appearance: appearance,
          color: AppBadgeColor.danger,
          title: "Verified",
          icon: Icon(Icons.check_circle_outline),
        ),
      ],
    );
