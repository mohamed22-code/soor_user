import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_style.dart';

class AddTimeBottomSheet extends StatefulWidget {
  const AddTimeBottomSheet({super.key});

  @override
  State<AddTimeBottomSheet> createState() => _AddTimeBottomSheetState();
}

class _AddTimeBottomSheetState extends State<AddTimeBottomSheet> {
  int hours = 3;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      decoration: const BoxDecoration(
        color: AppColors.appBarColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, color: Colors.white),
              ),
              Text('مد وقت إضافي', style: AppStyle.bold16white),
            ],
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text('مدة الخدمة بالساعة', style: AppStyle.medium16white),
          ),
          SizedBox(height: 10),
          Container(
            height: height * 0.06,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    if (hours > 1) {
                      setState(() {
                        hours--;
                      });
                    }
                  },
                  icon: const Icon(Icons.remove, color: Colors.white),
                ),

                Text('$hours', style: AppStyle.bold14white),

                IconButton(
                  onPressed: () {
                    setState(() {
                      hours++;
                    });
                  },
                  icon: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: height * 0.06,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'تأكيد',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
