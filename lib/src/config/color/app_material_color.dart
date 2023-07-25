part of 'app_color.dart';

abstract class AppMaterialColor {
  static const MaterialColor materialColor =
      MaterialColor(_materialColorPrimaryValue, <int, Color>{
    50: Color(0xFFECE8E4),
    100: Color(0xFFD1C6BC),
    200: Color(0xFFB2A090),
    300: Color(0xFF937963),
    400: Color(0xFF7B5D41),
    500: Color(_materialColorPrimaryValue),
    600: Color(0xFF5C3A1C),
    700: Color(0xFF523218),
    800: Color(0xFF482A13),
    900: Color(0xFF361C0B),
  });
  static const int _materialColorPrimaryValue = 0xFF644020;

  static const MaterialColor materialColorAccent =
      MaterialColor(_materialColorAccentValue, <int, Color>{
    100: Color(0xFFFFA271),
    200: Color(_materialColorAccentValue),
    400: Color(0xFFFF5F0B),
    700: Color(0xFFF15200),
  });
  static const int _materialColorAccentValue = 0xFFFF803E;
}
