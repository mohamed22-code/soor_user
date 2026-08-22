import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_style.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInput({super.key, required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        color: AppColors.appBarColor,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                textDirection: TextDirection.rtl,
                style: AppStyle.medium14darkGrey,
                decoration: InputDecoration(
                  hintText: 'رسالتك هنا',
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: AppStyle.medium16darkGrey,
                  filled: true,
                  fillColor: const Color(0xff212121),

                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),

            InkWell(
              onTap: onSend,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.secondaryDark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
