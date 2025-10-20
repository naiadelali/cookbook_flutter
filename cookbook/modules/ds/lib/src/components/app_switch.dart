import 'package:ds/ds.dart';
import 'package:flutter/material.dart';

enum AppSwitchAppearance { solid, soft }

enum AppSwitchSize { medium, small }

/// Component: Switch
/// Custom switch component with modern design
/// Supports pressed, drag/tap, disabled state, focus, and smooth animations
class AppSwitch extends StatefulWidget {
  /// Appearance of the switch track: solid or soft
  final AppSwitchAppearance appearance;

  /// If true, disables all interactions
  final bool disabled;

  /// Initial checked state
  final bool checked;

  /// Success state (green)
  final bool success;

  /// Danger state (red)
  final bool danger;

  /// Size: medium or small
  final AppSwitchSize size;

  /// Optional label text
  final String? label;

  /// If true, label is rendered to the right
  final bool onRight;

  /// Callback when value changes
  final ValueChanged<bool>? onChanged;

  /// Optional focus node
  final FocusNode? focusNode;

  /// Whether to autofocus when first shown
  final bool autofocus;

  const AppSwitch({
    super.key,
    this.appearance = AppSwitchAppearance.solid,
    this.disabled = false,
    required this.checked,
    this.success = false,
    this.danger = false,
    this.size = AppSwitchSize.medium,
    this.onRight = true,
    this.label,
    this.onChanged,
    this.focusNode,
    this.autofocus = false,
  }) : assert(!(success && danger), 'Cannot have both success and danger');

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  FocusNode? _internalFocusNode;
  late bool _checked;
  bool _pressed = false;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) {
      _internalFocusNode = FocusNode();
    }
    _checked = widget.checked;
    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        (widget.focusNode ?? _internalFocusNode)?.requestFocus();
      });
    }
  }

  @override
  void didUpdateWidget(covariant AppSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.checked != oldWidget.checked) {
      _checked = widget.checked;
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

  //========== Auxiliary getters ==========
  bool get _hasLabel => widget.label?.isNotEmpty == true;
  double get _trackWidth =>
      widget.size == AppSwitchSize.medium ? AppSizing.x44 : AppSizing.x36;
  double get _trackHeight =>
      widget.size == AppSwitchSize.medium ? AppSizing.x28 : AppSizing.x24;
  double get _thumbSize =>
      widget.size == AppSwitchSize.medium ? AppSizing.x24 : AppSizing.x20;

  TextStyle get _labelStyle => (widget.size == AppSwitchSize.small
              ? Theme.of(context).textTheme.labelMedium!
              : Theme.of(context).textTheme.labelLarge!)
          .copyWith(
        color:
            widget.disabled ? AppColor.neutral.softer : AppColor.neutral.strong,
      );

  Color get _thumbColor =>
      widget.disabled ? AppColor.neutral.softer : AppColor.surface.defaults;

  @override
  Widget build(BuildContext context) {
    final Color trackColor = _resolveTrackColor();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_hasLabel && !widget.onRight) _buildLabel(),
        _buildSwitchControl(trackColor),
        if (_hasLabel && widget.onRight) _buildLabel(),
      ],
    );
  }

  //========== Helper methods ==========
  Widget _buildLabel() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.medium),
      child: Text(widget.label!, style: _labelStyle),
    );
  }

  Widget _buildSwitchControl(Color trackColor) {
    return FocusableActionDetector(
      focusNode: widget.focusNode ?? _internalFocusNode,
      autofocus: widget.autofocus,
      onShowFocusHighlight: (focused) => setState(() => _focused = focused),
      onFocusChange: (focused) => setState(() => _focused = focused),
      child: GestureDetector(
        onHorizontalDragStart: (_) => _startPress(),
        onHorizontalDragUpdate: widget.disabled
            ? null
            : (details) => _handleDrag(details.localPosition.dx),
        onHorizontalDragEnd: (_) => _endPress(),
        child: Listener(
          onPointerDown: (_) => _startPress(),
          onPointerUp: (_) => _endPress(),
          child: InkWell(
            borderRadius: BorderRadius.circular(_trackHeight / AppSizing.x2),
            onTap: _toggle,
            splashColor: AppColor.primary.overlayMain,
            highlightColor: AppColor.primary.overlayMain,
            onHighlightChanged: (pressed) => setState(() => _pressed = pressed),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: _trackWidth,
              height: _trackHeight,
              padding: EdgeInsets.symmetric(
                horizontal: (_trackHeight - _thumbSize) / AppSpacing.xsmall3,
              ),
              decoration: BoxDecoration(
                color: trackColor,
                borderRadius: BorderRadius.circular(AppRadius.full),
                boxShadow: _focused
                    ? [
                        BoxShadow(
                          color: AppColor.primary.soft,
                          blurRadius: 0,
                          offset: Offset.zero,
                          spreadRadius: AppRadius.x4,
                        )
                      ]
                    : [],
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment:
                    _checked ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: _thumbSize,
                  height: _thumbSize,
                  decoration: BoxDecoration(
                    color: _thumbColor,
                    shape: BoxShape.circle,
                    boxShadow: _pressed
                        ? [
                            BoxShadow(
                              color: AppColor.primary.overlayMain,
                              blurRadius: 0,
                              offset: Offset.zero,
                              spreadRadius: AppRadius.x6,
                            )
                          ]
                        : [],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Toggles the switch state and requests focus
  void _toggle() {
    if (widget.disabled) return;
    (widget.focusNode ?? _internalFocusNode)?.requestFocus();
    setState(() => _checked = !_checked);
    widget.onChanged?.call(_checked);
  }

  /// Starts the press state
  void _startPress() {
    if (!widget.disabled) setState(() => _pressed = true);
  }

  /// Ends the press state
  void _endPress() {
    if (!widget.disabled) setState(() => _pressed = false);
  }

  /// Processes horizontal drag updates
  void _handleDrag(double dx) {
    final clamped = dx.clamp(0.0, _trackWidth);
    final next = clamped / _trackWidth > 0.5;
    setState(() => _checked = next);
    widget.onChanged?.call(_checked);
  }

  /// Resolves the track color based on state
  Color _resolveTrackColor() {
    if (widget.disabled) return AppColor.neutral.softest;
    if (_pressed || _focused) return _pressedColor();
    if (_checked) return _selectedColor();
    return widget.appearance == AppSwitchAppearance.solid
        ? AppColor.neutral.soft
        : AppColor.neutral.softer;
  }

  /// Determines the color when selected
  Color _selectedColor() {
    if (widget.success) {
      return widget.appearance == AppSwitchAppearance.solid
          ? AppColor.success.main
          : AppColor.success.soft;
    }
    if (widget.danger) {
      return widget.appearance == AppSwitchAppearance.solid
          ? AppColor.danger.main
          : AppColor.danger.soft;
    }
    return widget.appearance == AppSwitchAppearance.solid
        ? AppColor.primary.main
        : AppColor.primary.soft;
  }

  /// Determines the color when pressed
  Color _pressedColor() {
    if (!_checked) {
      return widget.appearance == AppSwitchAppearance.solid || _focused
          ? AppColor.neutral.main
          : AppColor.neutral.soft;
    }
    if (widget.success) {
      return widget.appearance == AppSwitchAppearance.solid || _focused
          ? AppColor.success.strong
          : AppColor.success.main;
    }
    if (widget.danger) {
      return widget.appearance == AppSwitchAppearance.solid || _focused
          ? AppColor.danger.strong
          : AppColor.danger.main;
    }
    return widget.appearance == AppSwitchAppearance.solid || _focused
        ? AppColor.primary.strong
        : AppColor.primary.main;
  }
}

class SwitchesDemoPage extends StatefulWidget {
  const SwitchesDemoPage({super.key});

  @override
  SwitchesDemoPageState createState() => SwitchesDemoPageState();
}

class SwitchesDemoPageState extends State<SwitchesDemoPage> {
  bool off = false;
  bool on = true;
  bool success = true;
  bool danger = true;
  bool softOff = false;
  bool softOn = true;

  late FocusNode _focusNode;
  late FocusNode _manualFocusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _manualFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.x16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildExample(
            'Solid / Medium / Off/ Auto Focus',
            softOff,
            (v) => setState(() => softOff = v),
            labelSwitch: 'Off',
            onRight: false,
            focusNode: _focusNode,
            autofocus: true,
          ),
          _buildExample(
            'Solid / Medium / Off/ Manual Focus',
            softOff,
            (v) => setState(() {
              softOff = v;
              if (_manualFocusNode.hasFocus) {
                _manualFocusNode.unfocus();
              } else {
                _manualFocusNode.requestFocus();
              }
            }),
            labelSwitch: 'Off',
            onRight: false,
          ),
          _buildExample(
            'Solid / Medium / On',
            on,
            (v) => setState(() => on = v),
            labelSwitch: 'On',
            focusNode: _manualFocusNode,
          ),
          _buildExample(
            'Soft / Medium / Off',
            softOff,
            (v) => setState(() => softOff = v),
            appearance: AppSwitchAppearance.soft,
            labelSwitch: 'Off',
            onRight: false,
          ),
          _buildExample(
            'Soft / Medium / On',
            softOn,
            (v) => setState(() => softOn = v),
            appearance: AppSwitchAppearance.soft,
            labelSwitch: 'On',
          ),
          _buildExample(
            'Solid / Medium / Success',
            success,
            (v) => setState(() => success = v),
            success: true,
          ),
          _buildExample(
            'Soft / Medium / Success',
            success,
            (v) => setState(() => success = v),
            success: true,
            appearance: AppSwitchAppearance.soft,
          ),
          _buildExample(
            'Solid / Medium / Danger',
            danger,
            (v) => setState(() => danger = v),
            danger: true,
          ),
          _buildExample(
            'Soft / Medium / Danger',
            danger,
            (v) => setState(() => danger = v),
            danger: true,
            appearance: AppSwitchAppearance.soft,
          ),
          _buildExample(
            'Soft / Small / Off',
            softOff,
            (v) => setState(() => softOff = v),
            appearance: AppSwitchAppearance.soft,
            size: AppSwitchSize.small,
            labelSwitch: 'Off',
          ),
          _buildExample(
            'Soft / Small / On',
            softOn,
            (v) => setState(() => softOn = v),
            appearance: AppSwitchAppearance.soft,
            size: AppSwitchSize.small,
            labelSwitch: 'On',
          ),
          _buildExample(
            'Solid / Disabled',
            softOff,
            (v) => setState(() => softOff = v),
            appearance: AppSwitchAppearance.solid,
            size: AppSwitchSize.small,
            labelSwitch: 'Off',
            disabled: true,
          ),
        ],
      ),
    );
  }

  Widget _buildExample(
    String label,
    bool value,
    ValueChanged<bool> onChanged, {
    AppSwitchAppearance appearance = AppSwitchAppearance.solid,
    AppSwitchSize size = AppSwitchSize.medium,
    bool success = false,
    bool danger = false,
    String? labelSwitch,
    bool disabled = false,
    bool onRight = true,
    FocusNode? focusNode,
    bool autofocus = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.x8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          AppSwitch(
            label: labelSwitch,
            appearance: appearance,
            checked: value,
            success: success,
            danger: danger,
            size: size,
            onChanged: onChanged,
            disabled: disabled,
            onRight: onRight,
            focusNode: focusNode,
            autofocus: autofocus,
          ),
        ],
      ),
    );
  }
}
