part of 'app_color.dart';

abstract class AppMaterialColor {
  static const MaterialColor materialColor =
      MaterialColor(_primarycolorPrimaryValue, <int, Color>{
    50: Color(0xFFEAE5E0),
    100: Color(0xFFCCBDB3),
    200: Color(0xFFAA9180),
    300: Color(0xFF87654D),
    400: Color(0xFF6E4426),
    500: Color(_primarycolorPrimaryValue),
    600: Color(0xFF4D1F00),
    700: Color(0xFF431A00),
    800: Color(0xFF3A1500),
    900: Color(0xFF290C00),
  });
  static const int _primarycolorPrimaryValue = 0xFF542300;

  static const MaterialColor primaryColorAccent =
      MaterialColor(_primarycolorAccentValue, <int, Color>{
    100: Color(0xFFFF7A63),
    200: Color(_primarycolorAccentValue),
    400: Color(0xFFFC2500),
    700: Color(0xFFE32200),
  });
  static const int _primarycolorAccentValue = 0xFFFF4F30;
}
