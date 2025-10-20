import 'package:ds/ds.dart';
import 'package:flutter/material.dart';

class AppRadioButton extends StatefulWidget {
  final AppRadioButtonAppearance appearance;
  final bool disabled;
  final bool success;
  final bool error;
  final AppRadioButtonSize size;
  final bool checked;
  final String label;
  final String description;
  final Function(String?) onChanged;
  final bool onRight;

  /// Optional focus node
  final FocusNode? focusNode;

  /// Whether to autofocus when first shown
  final bool autofocus;

  const AppRadioButton({
    super.key,
    this.appearance = AppRadioButtonAppearance.solid,
    this.disabled = false,
    this.success = false,
    this.error = false,
    this.size = AppRadioButtonSize.medium,
    this.checked = false,
    this.onRight = false,
    this.autofocus = false,
    required this.label,
    required this.description,
    required this.onChanged,
    this.focusNode,
  });

  @override
  State<AppRadioButton> createState() => _AppRadioButtonState();
}

class _AppRadioButtonState extends State<AppRadioButton> {
  FocusNode? _internalFocusNode;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) {
      _internalFocusNode = FocusNode();
    }
    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        (widget.focusNode ?? _internalFocusNode)?.requestFocus();
      });
    }
  }

  @override
  void didUpdateWidget(covariant AppRadioButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      _internalFocusNode?.dispose();
      _internalFocusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  void dispose() {
    _internalFocusNode?.dispose();
    super.dispose();
  }

  Color get _mainColor {
    var activeColor = AppColor.primary.main;
    if (widget.success) {
      activeColor = AppColor.success.main;
    }
    if (widget.error) {
      activeColor = AppColor.danger.main;
    }
    if (widget.disabled) {
      activeColor = AppColor.neutral.softer;
    }
    return activeColor;
  }

  Color get _softestColor {
    var activeColor = AppColor.primary.softest;
    if (widget.success) {
      activeColor = AppColor.success.softest;
    }
    if (widget.error) {
      activeColor = AppColor.danger.softest;
    }
    if (widget.disabled) {
      activeColor = AppColor.neutral.softest;
    }
    return activeColor;
  }

  Color get _onSofterColor {
    var activeColor = AppColor.primary.onSofter;
    if (widget.success) {
      activeColor = AppColor.success.onSofter;
    }
    if (widget.error) {
      activeColor = AppColor.danger.onSofter;
    }
    if (widget.disabled) {
      activeColor = AppColor.neutral.softer;
    }
    return activeColor;
  }

  Color get _overlayColor {
    var activeColor = AppColor.primary.overlaySoft;
    if (widget.success) {
      activeColor = AppColor.success.overlaySoft;
    }
    if (widget.error) {
      activeColor = AppColor.danger.overlaySoft;
    }
    return activeColor;
  }

  (Color, Color, Color, Color) get _solidColor {
    var borderColor = _mainColor;
    var centerColor = AppColor.primary.onMain;
    var innerColor = widget.checked ? _mainColor : centerColor;
    var textColor = _mainColor;
    return (borderColor, innerColor, centerColor, textColor);
  }

  (Color, Color, Color, Color) get _softColor {
    var softColor = AppColor.primary.soft;
    if (widget.success) {
      softColor = AppColor.success.soft;
    }
    if (widget.error) {
      softColor = AppColor.danger.soft;
    }
    if (widget.disabled) {
      softColor = AppColor.neutral.soft;
    }

    var borderColor = widget.checked ? softColor : _mainColor;
    var innerColor = widget.checked ? _softestColor : Colors.transparent;
    var centerColor = widget.checked ? _onSofterColor : innerColor;
    var textColor = _mainColor;
    return (borderColor, innerColor, centerColor, textColor);
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.appearance == AppRadioButtonAppearance.solid
        ? _solidColor
        : _softColor;
    final borderColor = colors.$1;
    final innerColor = colors.$2;
    final centerColor = colors.$3;
    final textColor = colors.$4;
    final fontSize = widget.size == AppRadioButtonSize.medium
        ? AppFontSize.base
        : AppFontSize.sm;
    final radioSize = widget.size == AppRadioButtonSize.medium
        ? AppSizing.x20
        : AppSizing.x16;

    final radioButton = Padding(
      padding: EdgeInsets.only(top: AppSpacing.x1),
      child: FocusableActionDetector(
        focusNode: widget.focusNode ?? _internalFocusNode,
        autofocus: widget.autofocus,
        child: Material(
          shape: const CircleBorder(),
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.disabled
                ? null
                : () => widget.onChanged.call(widget.label),
            customBorder: const CircleBorder(),
            splashColor: _overlayColor,
            child: Padding(
              padding: EdgeInsets.all(widget.size == AppRadioButtonSize.medium ? AppSpacing.x8 : AppSizing.x6),
              child: Ink(
                width: radioSize,
                height: radioSize,
                decoration: BoxDecoration(
                  color: innerColor,
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: borderColor, width: AppBorder.defaults),
                ),
                padding: EdgeInsets.all(widget.size == AppRadioButtonSize.medium
                    ? AppSpacing.x4
                    : AppSpacing.x4 - AppSpacing.x1),
                child: Ink(
                  decoration: BoxDecoration(
                    color: centerColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return InkWell(
      onTap: widget.disabled ? null : () => widget.onChanged.call(widget.label),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!widget.onRight) radioButton,
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: AppSpacing.x4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox.fromSize(
                    size: Size(
                        0,
                        widget.size == AppRadioButtonSize.medium
                            ? AppSpacing.x4
                            : AppSizing.x2),
                  ),
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: fontSize,
                      color: widget.disabled || widget.success || widget.error
                          ? textColor
                          : AppColor.neutral.strong,
                    ),
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: fontSize,
                      height: AppLineHeight.x150,
                      color:
                          widget.disabled ? textColor : AppColor.neutral.main,
                    ),
                  )
                ],
              ),
            ),
          ),
          if (widget.onRight) radioButton,
        ],
      ),
    );
  }
}

enum AppRadioButtonAppearance {
  solid,
  soft;
}

enum AppRadioButtonSize {
  small,
  medium;
}

Widget radioButtonPageExample() => SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4.0,
        children: [
          //DISABLED
          Text("DISABLED"),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            onChanged: (value) {},
            disabled: true,
          ),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            onChanged: (value) {},
            checked: true,
            disabled: true,
          ),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            onChanged: (value) {},
            checked: true,
            disabled: true,
            onRight: true,
          ),

          //SMALL
          const SizedBox(height: 16.0),
          Text("SMALL"),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            onChanged: (value) {},
            size: AppRadioButtonSize.small,
          ),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            onChanged: (value) {},
            size: AppRadioButtonSize.small,
            checked: true,
          ),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            onChanged: (value) {},
            size: AppRadioButtonSize.small,
            checked: true,
            onRight: true,
          ),

          //PRIMARY
          const SizedBox(height: 16.0),
          Text("PRIMARY"),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            onChanged: (value) {},
          ),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            onChanged: (value) {},
            checked: true,
          ),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            onChanged: (value) {},
            checked: true,
            onRight: true,
          ),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            onChanged: (value) {},
            appearance: AppRadioButtonAppearance.soft,
          ),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            onChanged: (value) {},
            checked: true,
            appearance: AppRadioButtonAppearance.soft,
          ),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            onChanged: (value) {},
            checked: true,
            onRight: true,
            appearance: AppRadioButtonAppearance.soft,
          ),

          //SUCCESS
          const SizedBox(height: 16.0),
          Text("SUCCESS"),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            success: true,
            onChanged: (value) {},
          ),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            success: true,
            onChanged: (value) {},
            checked: true,
          ),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            success: true,
            onChanged: (value) {},
            appearance: AppRadioButtonAppearance.soft,
          ),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            success: true,
            onChanged: (value) {},
            checked: true,
            appearance: AppRadioButtonAppearance.soft,
          ),

          //ERROR
          const SizedBox(height: 16.0),
          Text("ERROR"),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            error: true,
            onChanged: (value) {},
            checked: true,
          ),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            error: true,
            onChanged: (value) {},
          ),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            error: true,
            onChanged: (value) {},
            checked: true,
            appearance: AppRadioButtonAppearance.soft,
          ),
          AppRadioButton(
            label: 'Endereço principal',
            description: 'Rua XV de Novembro, 123',
            error: true,
            onChanged: (value) {},
            appearance: AppRadioButtonAppearance.soft,
          ),
        ],
      ),
    );
