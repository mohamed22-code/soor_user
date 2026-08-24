import 'package:flutter/material.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/themes/colors/app_colors.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Icon(Icons.close)),
      body: Column(
        mainAxisAlignment: .center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'جاري الاتصال',
                  style: TextStyle(fontSize: 16, color: Color(0xff2D9EC4)),
                ),
                SizedBox(height: height * 0.06),
                Text(
                  'Soor',
                  style: TextStyle(
                    fontSize: 53,
                    color: AppColors.darkGray,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: height * 0.06),
                Image.asset(AppAssets.soorCallImage),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              builtContainerCalling(
                color: Colors.red,
                icon: Icon(Icons.call_end, color: Colors.white, size: 30),
              ),
              SizedBox(width: width * 0.06),
              builtContainerCalling(
                color: AppColors.grayDark100Color,
                icon: Icon(Icons.mic, color: Colors.white, size: 30),
              ),
              SizedBox(width: width * 0.06),
              builtContainerCalling(
                color: AppColors.grayDark100Color,
                icon: Icon(Icons.volume_up, color: Colors.white, size: 30),
              ),
            ],
          ),
          SizedBox(height: height * 0.02),
        ],
      ),
    );
  }

  builtContainerCalling({required Color color, required Widget icon}) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(360),
        color: color,
      ),
      child: icon,
    );
  }
}
