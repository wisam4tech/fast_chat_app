import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  CustomButtom({super.key, required this.text, this.onTap});
  final String text;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 214, 7, 237),
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          height: 70,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
