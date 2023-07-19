import 'package:flutter/material.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';

class GapH extends StatelessWidget {
  final num height;
  const GapH(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height.h);
  }
}

class GapW extends StatelessWidget {
  final num width;
  const GapW(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width.w);
  }
}
