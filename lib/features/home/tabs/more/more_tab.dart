import 'package:flutter/material.dart';
import 'package:soor_user_app/features/home/tabs/more/policy_screen.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/styles/app_style.dart';

import '../../../../core/widgets/custom_account_container.dart';
import '../../../../core/widgets/setting_item_container.dart';
import 'account_screen.dart';
import 'all_chat_screen.dart';

class MoreTab extends StatelessWidget {
  const MoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('المزيد', style: AppStyle.medium16white),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                // todo: navigate to account screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountScreen()),
                );
              },
              child: CustomAccountContainer(),
            ),
            SizedBox(height: height * 0.04),
            SettingItemContainer(
              title: 'تغيير اللغه',
              icon: Icons.language_outlined,
              trailing: Row(
                children: [
                  Text('English', style: AppStyle.medium16primary),
                  SizedBox(width: width * 0.04),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColors.primaryText,
                    size: 24,
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            SettingItemContainer(
              title: 'المحادثات',
              icon: Icons.message,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllChatScreen()),
                );
              },
            ),
            SizedBox(height: height * 0.02),
            SettingItemContainer(
              title: 'الشروط والاحكام',
              icon: Icons.info,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PolicyScreen()),
                );
              },
            ),
            SizedBox(height: height * 0.02),
            SettingItemContainer(title: 'تسجيل الخروج', icon: Icons.logout),
          ],
        ),
      ),
    );
  }
}
