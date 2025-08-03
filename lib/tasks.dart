import 'package:flutter/material.dart';
import 'task_style.dart';
import 'style_button.dart';
import 'style_text.dart';

class Tasks extends StatelessWidget {
  const Tasks({
    required this.child,
    required this.isDone,
    required this.onPressed,
    required this.onPressed2,
    required this.text,
    required this.text2,
    super.key,
  });

  final String child;
  final bool isDone;
  final VoidCallback onPressed;
  final VoidCallback onPressed2;
  final String text;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDone ? const Color(0xffE0E0E0) : Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: TaskStyle(
                child,
                style: TextStyle(
                  fontSize: 18,
                  color: isDone ? Colors.grey : Colors.black,
                  decoration: isDone ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            StyleButton(onPressed: onPressed2, child: StyleText(text2)),
            const SizedBox(width: 8),
            StyleButton(onPressed: onPressed, child: StyleText(text)),
          ],
        ),
      ),
    );
  }
}
