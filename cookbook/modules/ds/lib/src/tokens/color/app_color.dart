import 'package:ds/src/tokens/color/color_dark_scheme.dart';
import 'package:ds/src/tokens/color/color_light_scheme.dart';
import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static Brightness brightness = Brightness.light;

  static AppColorScheme get primary => brightness == Brightness.dark
      ? primaryDarkColorScheme()
      : primaryLightColorScheme();

  static AppColorScheme get secondary => brightness == Brightness.dark
      ? secondaryDarkColorScheme()
      : secondaryLightColorScheme();

  static NeutralColorScheme get neutral => brightness == Brightness.dark
      ? neutralDarkColorScheme()
      : neutralLightColorScheme();

  static AppColorScheme get success => brightness == Brightness.dark
      ? successDarkColorScheme()
      : successLightColorScheme();

  static AppColorScheme get warning => brightness == Brightness.dark
      ? warningDarkColorScheme()
      : warningLightColorScheme();

  static AppColorScheme get danger => brightness == Brightness.dark
      ? dangerDarkColorScheme()
      : dangerLightColorScheme();

  static AppColorScheme get info => brightness == Brightness.dark
      ? infoDarkColorScheme()
      : infoLightColorScheme();

  static SurfaceColorScheme get surface => brightness == Brightness.dark
      ? surfaceDarkColorScheme()
      : surfaceLightColorScheme();
}

class AppColorScheme {
  final Color overlayMain;
  final Color overlaySoft;
  final Color overlayStrong;
  final Color softer;
  final Color soft;
  final Color main;
  final Color strong;
  final Color onSofter;
  final Color onSoft;
  final Color onMain;
  final Color onStrong;
  final Color onSoftest;
  final Color softest;

  AppColorScheme(
      {
      required this.overlayMain,
      required this.overlaySoft,
      required this.overlayStrong,
      required this.softer,
      required this.soft,
      required this.main,
      required this.strong,
      required this.softest,
      required this.onSofter,
      required this.onSoft,
      required this.onMain,
      required this.onStrong,
      required this.onSoftest});
}

class SurfaceColorScheme {
  final Color colorless;
  final Color defaults;
  final Color lowest;
  final Color low;
  final Color high;
  final Color highest;
  final Color opaque;
  final Color opaqueInverse;

  SurfaceColorScheme(
      {required this.colorless,
      required this.defaults,
      required this.lowest,
      required this.low,
      required this.high,
      required this.highest,
      required this.opaque,
      required this.opaqueInverse});
}

class NeutralColorScheme {
  final Color alwaysBlack;
  final Color alwaysWhite;
  final Color overlayMain;
  final Color overlaySoft;
  final Color overlayStrong;
  final Color softer;
  final Color soft;
  final Color main;
  final Color strong;
  final Color softest;
  final Color onSofter;
  final Color onSoft;
  final Color onMain;
  final Color onStrong;
  final Color onSoftest;

  NeutralColorScheme(
      {required this.alwaysBlack,
      required this.alwaysWhite,
      required this.overlayMain,
      required this.overlaySoft,
      required this.overlayStrong,
      required this.softer,
      required this.soft,
      required this.main,
      required this.strong,
      required this.softest,
      required this.onSofter,
      required this.onSoft,
      required this.onMain,
      required this.onStrong,
      required this.onSoftest});
}
