import 'package:flutter/material.dart';

class DayName extends StatelessWidget {
  final String text;

  const DayName(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 14),
    );
  }
}
