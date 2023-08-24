import 'package:flutter/material.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';

class AppOutlinedButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final BorderRadius? borderRadius;
  final TextStyle? style;
  final Color buttonColor;
  final EdgeInsets? margin;

  const AppOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderRadius,
    this.style,
    this.buttonColor = AppColor.primaryColor,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(0.0),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(30),
        child: InkWell(
          splashColor: buttonColor.withOpacity(0.20),
          highlightColor: buttonColor.withOpacity(0.05),
          onTap: onPressed,
          borderRadius: borderRadius ?? BorderRadius.circular(30),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(30),
              border: Border.all(
                width: 2,
                color: buttonColor,
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: style ??
                    TextStyle(
                      fontSize: 17,
                      color: buttonColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
