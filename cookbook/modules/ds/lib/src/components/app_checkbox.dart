import 'package:ds/ds.dart';
import 'package:flutter/material.dart';

enum AppCheckboxAppearance { solid, soft }

enum AppCheckboxSize { medium, small }

/// Component: Checkbox
/// Custom checkbox component with modern design
/// Supports checked, indeterminate, success, error, disabled, focus,
/// ripple effect (InkWell) around the box, and smooth animations
class AppCheckbox extends StatefulWidget {
  /// Appearance of the box: solid or soft.
  final AppCheckboxAppearance appearance;

  /// Disable all interactions when true.
  final bool disabled;

  /// Current checked state.
  final bool checked;

  /// Indeterminate state draws a dash instead of a check.
  final bool indeterminate;

  /// Success state (green).
  final bool success;

  /// Error state (red).
  final bool error;

  /// Size of the checkbox.
  final AppCheckboxSize size;

  /// Label text displayed next to the box.
  final String? label;

  /// Description text displayed under the label.
  final String? description;

  /// Position label/description on the right when true.
  final bool onRight;

  /// External focus node.
  final FocusNode? focusNode;

  /// Autofocus when first shown.
  final bool autofocus;

  /// Callback when state toggles.
  final ValueChanged<bool>? onChanged;

  const AppCheckbox({
    super.key,
    this.appearance = AppCheckboxAppearance.solid,
    this.disabled = false,
    required this.checked,
    this.indeterminate = false,
    this.success = false,
    this.error = false,
    this.size = AppCheckboxSize.medium,
    this.label,
    this.description,
    this.onRight = true,
    this.focusNode,
    this.autofocus = false,
    this.onChanged,
  }) : assert(!(success && error), 'Cannot have both success and error');

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  late bool _checked;
  late bool _indeterminate;
  bool _focused = false;
  FocusNode? _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _checked = widget.checked;
    _indeterminate = widget.indeterminate;
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
  void didUpdateWidget(covariant AppCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.checked != oldWidget.checked) {
      _checked = widget.checked;
    }
    if (widget.indeterminate != oldWidget.indeterminate) {
      _indeterminate = widget.indeterminate;
    }
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

  @override
  Widget build(BuildContext context) {
    final box = _buildBox();
    final hasDesc = _hasDescription;

    final double offset =
        hasDesc ? (_rippleDiameter - _boxSize) / 2 : AppSizing.none;

    final textSection = GestureDetector(
      onTap: _toggle,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: EdgeInsets.only(top: offset),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_hasLabel) Text(widget.label!, style: _labelStyle),
            if (hasDesc)
              Padding(
                padding: EdgeInsets.only(top: AppSpacing.xsmall3),
                child: Text(widget.description!, style: _descriptionStyle),
              ),
          ],
        ),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment:
          hasDesc ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: widget.onRight
          ? [
              box,
              SizedBox(width: AppSpacing.xsmall3),
              Expanded(child: textSection)
            ]
          : [
              Expanded(child: textSection),
              SizedBox(width: AppSpacing.xsmall3),
              box
            ],
    );
  }

  //========== Auxiliary getters ==========
  bool get _hasLabel => widget.label?.isNotEmpty == true;
  bool get _hasDescription => widget.description?.isNotEmpty == true;

  double get _boxSize =>
      widget.size == AppCheckboxSize.medium ? AppSizing.x20 : AppSpacing.x16;
  double get _iconSize =>
      widget.size == AppCheckboxSize.medium ? AppSizing.x16 : AppSpacing.x12;
  double get _rippleDiameter =>
      widget.size == AppCheckboxSize.medium ? AppSizing.x36 : AppSizing.x28;

  TextStyle get _labelStyle {
    final color = widget.disabled
        ? AppColor.neutral.softer
        : widget.success
            ? AppColor.success.main
            : widget.error
                ? AppColor.danger.main
                : AppColor.neutral.strong;
    final base = widget.size == AppCheckboxSize.small
        ? Theme.of(context).textTheme.labelMedium!
        : Theme.of(context).textTheme.labelLarge!;
    return base.copyWith(color: color);
  }

  TextStyle get _descriptionStyle {
    final color =
        widget.disabled ? AppColor.neutral.softer : AppColor.neutral.main;
    final base = widget.size == AppCheckboxSize.small
        ? Theme.of(context).textTheme.bodySmall!
        : Theme.of(context).textTheme.bodyMedium!;
    return base.copyWith(color: color);
  }

  Color get _mainColor {
    var active = widget.checked || _focused
        ? AppColor.primary.main
        : AppColor.neutral.softer;
    if (widget.success) active = AppColor.success.main;
    if (widget.error) active = AppColor.danger.main;
    if (widget.disabled) active = AppColor.neutral.softest;
    return active;
  }

  Color get _softestColor => widget.success
      ? AppColor.success.softest
      : widget.error
          ? AppColor.danger.softest
          : widget.disabled
              ? AppColor.neutral.softest
              : AppColor.primary.softest;

  Color get _onSofterColor => widget.success
      ? AppColor.success.onSofter
      : widget.error
          ? AppColor.danger.onSofter
          : widget.disabled
              ? AppColor.neutral.softer
              : AppColor.primary.onSofter;

  Color get _onMainColor => widget.success
      ? AppColor.success.onMain
      : widget.error
          ? AppColor.danger.onMain
          : widget.disabled
              ? AppColor.neutral.onMain
              : AppColor.primary.onMain;

  Color get _overlayColor {
    if (widget.success) return AppColor.success.overlaySoft;
    if (widget.error) return AppColor.danger.overlaySoft;
    return AppColor.primary.overlayMain;
  }

  (Color border, Color fill, Color icon) get _solidColor {
    final border = _mainColor;
    final fill = _checked ? _mainColor : Colors.transparent;
    return (border, fill, _onMainColor);
  }

  (Color border, Color fill, Color icon) get _softColor {
    final soft = widget.success
        ? AppColor.success.soft
        : widget.error
            ? AppColor.danger.soft
            : widget.disabled
                ? AppColor.neutral.soft
                : AppColor.primary.soft;
    final border = soft;
    final fill = _checked ? _softestColor : Colors.transparent;
    final icon = _checked ? _onSofterColor : fill;
    return (border, fill, icon);
  }

  //========== Helper methods ==========
  Widget _buildBox() {
    final (border, fill, iconColor) =
        widget.appearance == AppCheckboxAppearance.solid
            ? _solidColor
            : _softColor;

    return Container(
      width: _rippleDiameter,
      height: _rippleDiameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _focused ? _overlayColor : Colors.transparent,
      ),
      child: InkWell(
        onTap: widget.disabled ? null : _toggle,
        customBorder: const CircleBorder(),
        splashColor: _overlayColor,
        highlightColor: _overlayColor,
        focusColor: _overlayColor,
        focusNode: widget.focusNode ?? _internalFocusNode,
        autofocus: widget.autofocus,
        onFocusChange: (focused) => setState(() => _focused = focused),
        child: SizedBox(
          width: _rippleDiameter,
          height: _rippleDiameter,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: _boxSize,
              height: _boxSize,
              decoration: BoxDecoration(
                color: fill,
                border: Border.all(color: border, width: AppBorder.defaults),
                borderRadius: BorderRadius.circular(AppRadius.x4),
              ),
              child: Center(
                child: _indeterminate
                    ? Icon(Icons.remove, size: _iconSize, color: iconColor)
                    : (_checked
                        ? Icon(Icons.check, size: _iconSize, color: iconColor)
                        : null),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _toggle() {
    if (widget.disabled) return;
    if (_indeterminate) {
      setState(() {
        _indeterminate = false;
        _checked = true;
      });
      widget.onChanged?.call(true);
    } else {
      setState(() => _checked = !_checked);
      widget.onChanged?.call(_checked);
    }
  }
}

/// Demo page for AppCheckbox
class CheckboxesDemoPage extends StatefulWidget {
  const CheckboxesDemoPage({super.key});
  @override
  CheckboxesDemoPageState createState() => CheckboxesDemoPageState();
}

class CheckboxesDemoPageState extends State<CheckboxesDemoPage> {
  bool basic = false;
  bool checked = true;
  bool success = false;
  bool error = false;
  bool indeterminate = true;
  bool soft = false;
  bool softChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.x16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.x12),
            _buildExample(
              'Solid / Medium',
              basic,
              (v) => setState(() => basic = v),
              label: 'Auto Focus',
              autoFocus: true,
            ),
            _buildExample(
              'Solid / Medium',
              basic,
              (v) => setState(() => basic = v),
              onRight: false,
              label: 'Receber notificações',
              description:
                  'Mantenha-se atualizado com as últimas novidades e alertas importantes no seu e-mail.',
            ),
            _buildExample(
              'Solid / Medium',
              checked,
              (v) => setState(() => basic = v),
              label: 'Receber notificações',
              description:
                  'Mantenha-se atualizado com as últimas novidades e alertas importantes no seu e-mail.',
            ),
            _buildExample(
              'Solid / Medium / Disabled',
              checked,
              (v) => setState(() => basic = v),
              disabled: true,
              label: 'Receber notificações',
              description:
                  'Mantenha-se atualizado com as últimas novidades e alertas importantes no seu e-mail.',
            ),
            _buildExample(
              'Solid / Medium / Indeterminate',
              indeterminate,
              (v) => setState(() => basic = v),
              label: 'Receber notificações',
              indeterminate: true,
            ),
            _buildExample(
              'Soft / Medium',
              soft,
              (v) => setState(() => soft = v),
              appearance: AppCheckboxAppearance.soft,
              label: 'Receber notificações',
              description:
                  'Mantenha-se atualizado com as últimas novidades e alertas importantes no seu e-mail.',
            ),
            _buildExample(
              'Soft / Medium',
              softChecked,
              (v) => setState(() => softChecked = v),
              appearance: AppCheckboxAppearance.soft,
              label: 'Receber notificações',
              description:
                  'Mantenha-se atualizado com as últimas novidades e alertas importantes no seu e-mail.',
            ),
            _buildExample(
              'Soft / Medium / Indeterminate',
              indeterminate,
              (v) => setState(() => indeterminate = v),
              appearance: AppCheckboxAppearance.soft,
              label: 'Receber notificações',
              indeterminate: true,
            ),
            _buildExample(
              'Success / Medium',
              soft,
              (v) => setState(() => success = v),
              appearance: AppCheckboxAppearance.soft,
              success: true,
              label: 'Completed',
            ),
            _buildExample(
              'Error / Medium',
              error,
              (v) => setState(() => error = v),
              error: true,
              label: 'Failed',
            ),
            _buildExample(
              'Error / Medium',
              error,
              (v) => setState(() => error = v),
              appearance: AppCheckboxAppearance.soft,
              error: true,
              label: 'Failed',
              description: 'Something went wrong, please try again later.',
            ),
            _buildExample(
              'Indeterminate / Medium',
              indeterminate,
              (v) => setState(() => indeterminate = v),
              indeterminate: true,
              label: 'Mixed',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExample(
    String title,
    bool value,
    ValueChanged<bool> onChanged, {
    AppCheckboxAppearance appearance = AppCheckboxAppearance.solid,
    AppCheckboxSize size = AppCheckboxSize.medium,
    bool disabled = false,
    bool indeterminate = false,
    bool success = false,
    bool error = false,
    String? label,
    String? description,
    bool onRight = true,
    bool autoFocus = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.x8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          SizedBox(width: AppSpacing.x8),
          Expanded(
            child: AppCheckbox(
              appearance: appearance,
              size: size,
              disabled: disabled,
              checked: value,
              indeterminate: indeterminate,
              success: success,
              error: error,
              label: label,
              description: description,
              onRight: onRight,
              focusNode: FocusNode(),
              autofocus: autoFocus,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
