import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final int value;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const Counter({
    required this.value,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: const Color(0xff383838)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onMinus,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.remove, color: Colors.white, size: 15),
          ),

          Expanded(
            child: Center(
              child: Text(
                '$value',
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
          ),

          // Plus
          IconButton(
            onPressed: onPlus,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.add, color: Colors.white, size: 17),
          ),
        ],
      ),
    );
  }
}
