import 'package:unicorn_cafe/app/app.dart';

extension SizeExtension on num {
  double get h {
    return (size.height * this) / 100.0;
  }
  double get w {
    return (size.width * this) / 100.0;
  }
}
