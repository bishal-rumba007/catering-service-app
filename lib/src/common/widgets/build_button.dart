import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {

  final VoidCallback? onPressed;
  final Widget buttonWidget;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final ElevatedButtonTheme? buttonTheme;

  const BuildButton({super.key, required this.onPressed,
    required this.buttonWidget,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.buttonTheme,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor
      ),
      child: buttonWidget,
    );
  }
}
