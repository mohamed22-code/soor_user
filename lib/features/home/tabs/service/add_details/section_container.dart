import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;

  const SectionContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xff252525), width: 1),
      ),
      child: child,
    );
  }
}
