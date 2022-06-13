
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPressed;

  MyButton({required this.title, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
          elevation: 2,
          color: color,
          borderRadius: BorderRadius.circular(15),
          child: MaterialButton(
              minWidth: 150,
              height: 49,
              onPressed:  onPressed,
              child: Text(title,
                  style: const TextStyle(color: Colors.white, fontSize: 20)))),
    );
  }
}