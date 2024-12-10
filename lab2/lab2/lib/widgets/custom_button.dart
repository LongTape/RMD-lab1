import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Дозволяємо null
  final Color? color;

  CustomButton({
    required this.text,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          textStyle: TextStyle(fontSize: 16),
        ),
        onPressed: onPressed, // Не викликає помилку
        child: Text(text),
      ),
    );
  }
}
