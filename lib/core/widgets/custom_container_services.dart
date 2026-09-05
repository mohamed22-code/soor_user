import 'package:flutter/material.dart';

import '../themes/styles/app_style.dart';

class CustomContainerServices extends StatelessWidget {
  final Color color;
  final Widget icon;
  final String text;
  final double radius;
  final VoidCallback? onTap;

  const CustomContainerServices({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
    this.radius = 360,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final container = Container(
      width: width * 0.3,
      height: height * 0.14,
      decoration: BoxDecoration(color: color, borderRadius: .circular(radius)),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          icon,
          SizedBox(height: height * 0.01),
          Text(text, style: AppStyle.bold24white),
        ],
      ),
    );
    if (onTap == null) return container;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: container,
    );
  }
}
