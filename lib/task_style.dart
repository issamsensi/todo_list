import 'package:flutter/material.dart';

class TaskStyle extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const TaskStyle(this.text, {this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? const TextStyle(fontSize: 18),
    );
  }
}
