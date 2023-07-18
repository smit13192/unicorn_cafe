part of 'app_color.dart';

abstract class AppMaterialColor {
  static const MaterialColor materialColor =
      MaterialColor(_materialColorPrimaryValue, <int, Color>{
    50: Color(0xFFFCF6EB),
    100: Color(0xFFF8E8CE),
    200: Color(0xFFF4D9AD),
    300: Color(0xFFEFCA8C),
    400: Color(0xFFEBBE73),
    500: Color(_materialColorPrimaryValue),
    600: Color(0xFFE5AC52),
    700: Color(0xFFE2A348),
    800: Color(0xFFDE9A3F),
    900: Color(0xFFD88B2E),
  });
  static const int _materialColorPrimaryValue = 0xFFE8B35A;

  static const MaterialColor materialColorAccent =
      MaterialColor(_materialColorAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_materialColorAccentValue),
    400: Color(0xFFFFDBB4),
    700: Color(0xFFFFCF9B),
  });
  static const int _materialColorAccentValue = 0xFFFFF4E7;
}
