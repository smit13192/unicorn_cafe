import 'package:flutter/material.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';

typedef OnPressed = void Function();

class AppButton extends StatelessWidget {
  final Color buttonColor;
  final OnPressed onPressed;
  final String text;
  final BorderRadius? borderRadius;
  final TextStyle? style;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor = AppColor.primaryColor,
    this.borderRadius,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonColor,
      borderRadius: borderRadius ?? BorderRadius.circular(30),
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius ?? BorderRadius.circular(30),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              text,
              style: style ??
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
