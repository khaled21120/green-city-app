import 'package:flutter/material.dart';

class IntroButton extends StatelessWidget {
  const IntroButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
    required this.textColor,
    required this.borderColor,
  });
  final String text;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width * 0.8, 50),
        side: BorderSide(color: borderColor),
        backgroundColor: color,
      ),
      onPressed: onTap,
      child: Text(text, style: TextStyle(color: textColor)),
    );
  }
}
