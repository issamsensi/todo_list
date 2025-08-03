import 'package:flutter/material.dart';

class StyleText extends StatelessWidget {
  final String data;

  const StyleText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
