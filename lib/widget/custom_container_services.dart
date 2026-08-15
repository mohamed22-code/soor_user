import 'package:flutter/material.dart';

import '../utils/app_style.dart';

class CustomContainerServices extends StatelessWidget {
  final Color color;
  final Widget icon;
  final String text;
  // final VoidCallback onTap;
  const CustomContainerServices({super.key, required this.color,
    required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width*0.3,
      height: height*0.14,
      decoration: BoxDecoration(
        color: color,
        borderRadius: .circular(360),
      ),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          icon,
          SizedBox(height: height*0.01,),
          Text(text, style: AppStyle.bold24white,)
        ],
      ),
    );
  }
}
