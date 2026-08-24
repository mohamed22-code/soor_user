import 'package:flutter/material.dart';
import 'package:soor_user_app/core/themes/styles/app_style.dart';
import 'package:soor_user_app/features/home/tabs/service/add_details/widget/time_pcker_bottom_sheet.dart';

class DateField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const DateField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextField(
        controller: controller,
        readOnly: true,
        textAlign: TextAlign.right,
        style: AppStyle.bold12white,
        onTap: () async {
          final result = await showModalBottomSheet<String>(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) {
              return const DateTimePickerBottomSheet();
            },
          );

          if (result != null) {
            controller.text = result;
          }
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStyle.medium16darkGrey,
          suffixIcon: const Icon(
            Icons.calendar_month_outlined,
            color: Colors.white,
            size: 17,
          ),
          filled: true,
          fillColor: const Color(0xff202020),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
