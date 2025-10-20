import 'package:ds/src/tokens/app_font_weight.dart';
import 'package:flutter/widgets.dart';
import 'app_font_family.dart';
import 'app_font_size.dart';
import 'app_line_height.dart';
import 'app_letter_spacing.dart';

class AppTypography {
  AppTypography._();

  static TextStyle get displayNormalLarge => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.medium,
    fontSize: AppFontSize.xl7,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get displayNormalMedium => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.medium,
    fontSize: AppFontSize.xl6,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get displayNormalSmall => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.medium,
    fontSize: AppFontSize.xl5,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get displayThinLarge => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.extralight,
    fontSize: AppFontSize.xl7,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get displayThinMedium => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.extralight,
    fontSize: AppFontSize.xl6,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get displayThinSmall => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.extralight,
    fontSize: AppFontSize.xl5,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get titleNormalLarge => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.medium,
    fontSize: AppFontSize.xl4,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get titleNormalMedium => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.medium,
    fontSize: AppFontSize.xl3,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get titleNormalSmall => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.medium,
    fontSize: AppFontSize.xl2,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get titleThinLarge => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.extralight,
    fontSize: AppFontSize.xl4,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get titleThinMedium => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.extralight,
    fontSize: AppFontSize.xl3,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get titleThinSmall => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.extralight,
    fontSize: AppFontSize.xl2,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get subtitleNormalLarge => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.regular,
    fontSize: AppFontSize.xl2,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get subtitleNormalMedium => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.regular,
    fontSize: AppFontSize.xl,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get subtitleNormalSmall => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.regular,
    fontSize: AppFontSize.lg,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get subtitleThinLarge => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.extralight,
    fontSize: AppFontSize.xl2,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get subtitleThinMedium => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.extralight,
    fontSize: AppFontSize.xl,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get subtitleThinSmall => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.extralight,
    fontSize: AppFontSize.lg,
    height: AppLineHeight.x125,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get bodyNormalLarge => TextStyle(
    fontFamily: AppFontFamily.secondary,
    fontWeight: AppFontWeight.regular,
    fontSize: AppFontSize.lg,
    height: AppLineHeight.x150,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get bodyNormalMedium => TextStyle(
    fontFamily: AppFontFamily.secondary,
    fontWeight: AppFontWeight.regular,
    fontSize: AppFontSize.base,
    height: AppLineHeight.x150,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get bodyNormalSmall => TextStyle(
    fontFamily: AppFontFamily.secondary,
    fontWeight: AppFontWeight.regular,
    fontSize: AppFontSize.sm,
    height: AppLineHeight.x150,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get labelNormalLarge => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.medium,
    fontSize: AppFontSize.lg,
    height: AppLineHeight.x100,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get labelNormalMedium => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.medium,
    fontSize: AppFontSize.base,
    height: AppLineHeight.x100,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get labelNormalSmall => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.medium,
    fontSize: AppFontSize.sm,
    height: AppLineHeight.x100,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get labelNormalNano => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.medium,
    fontSize: AppFontSize.xs,
    height: AppLineHeight.x100,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get labelThinLarge => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.regular,
    fontSize: AppFontSize.lg,
    height: AppLineHeight.x100,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get labelThinMedium => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.regular,
    fontSize: AppFontSize.base,
    height: AppLineHeight.x100,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get labelThinSmall => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.regular,
    fontSize: AppFontSize.sm,
    height: AppLineHeight.x100,
    letterSpacing: AppLetterSpacing.normal,
  );

  static TextStyle get labelThinNano => TextStyle(
    fontFamily: AppFontFamily.primary,
    fontWeight: AppFontWeight.regular,
    fontSize: AppFontSize.xs,
    height: AppLineHeight.x100,
    letterSpacing: AppLetterSpacing.normal,
  );
}
