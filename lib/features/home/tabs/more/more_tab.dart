import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soor_user_app/features/home/tabs/more/policy_screen.dart';

import '../../../../core/helpers/secure_storage_helper.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/styles/app_style.dart';
import '../../../../core/widgets/custom_account_container.dart';
import '../../../../core/widgets/setting_item_container.dart';
import '../../../profile/presentation/cubit/profile_cubit.dart';
import '../../../profile/presentation/cubit/profile_state.dart';
import 'account_screen.dart';
import 'all_chat_screen.dart';

class MoreTab extends StatelessWidget {
  const MoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) =>
      ProfileCubit()
        ..fetchProfile(),
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileDeleted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                'login_screen', (r) => false);
          } else if (state is ProfileError) {
            // لا نعرض SnackBar عند الخطأ الأولي للحفاظ على الـ fallback رقم
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          appBar: AppBar(
              title: const Text('المزيد', style: AppStyle.medium16white),
              centerTitle: true),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.02),
            child: Column(
              children: [
                InkWell(
                  onTap: () =>
                      Navigator.push(context, MaterialPageRoute(
                          builder: (_) => const AccountScreen())),
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      String? name;
                      String? phone;
                      if (state is ProfileLoaded) {
                        name = state.user.userName;
                        phone = state.user.userPhone;
                      }
                      if (state is ProfileUpdated) {
                        name = state.user.userName;
                        phone = state.user.userPhone;
                      }
                      return CustomAccountContainer(name: name, phone: phone);
                    },
                  ),
                ),
                SizedBox(height: height * 0.04),
                SettingItemContainer(
                  title: 'تغيير اللغه',
                  icon: Icons.language_outlined,
                  trailing: Row(
                    children: [
                      const Text('English', style: AppStyle.medium16primary),
                      SizedBox(width: width * 0.04),
                      const Icon(Icons.arrow_forward_ios_outlined,
                          color: AppColors.primaryText, size: 24),
                    ],
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('سيتم إضافة تغيير اللغة قريباً')));
                  },
                ),
                SizedBox(height: height * 0.02),
                SettingItemContainer(
                  title: 'المحادثات',
                  icon: Icons.message,
                  onTap: () =>
                      Navigator.push(context, MaterialPageRoute(
                          builder: (_) => const AllChatScreen())),
                ),
                SizedBox(height: height * 0.02),
                SettingItemContainer(
                  title: 'الشروط والاحكام',
                  icon: Icons.info,
                  onTap: () =>
                      Navigator.push(context, MaterialPageRoute(
                          builder: (_) => const PolicyScreen())),
                ),
                SizedBox(height: height * 0.02),
                SettingItemContainer(
                  title: 'تسجيل الخروج',
                  icon: Icons.logout,
                  onTap: () => _confirmLogout(context),
                ),
                SizedBox(height: height * 0.01),
                TextButton(
                  onPressed: () => _confirmDelete(context),
                  child: const Text(
                      'حذف الحساب', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            backgroundColor: AppColors.appBarColor,
            title: const Text('تسجيل الخروج', style: AppStyle.bold16white),
            content: const Text(
                'هل أنت متأكد من تسجيل الخروج؟', style: AppStyle.medium16white),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context),
                  child: const Text('إلغاء')),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await SecureStorageHelper.deleteToken();
                  if (context.mounted) Navigator
                      .of(context)
                      .pushNamedAndRemoveUntil('login_screen', (r) => false);
                },
                child: const Text('خروج', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) =>
          AlertDialog(
            backgroundColor: AppColors.appBarColor,
            title: const Text('حذف الحساب', style: AppStyle.bold16white),
            content: const Text('هل أنت متأكد من حذف الحساب نهائياً؟',
                style: AppStyle.medium16white),
            actions: [
              TextButton(onPressed: () => Navigator.pop(dialogCtx),
                  child: const Text('إلغاء')),
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogCtx);
                  context.read<ProfileCubit>().deleteAccount();
                },
                child: const Text('حذف', style: TextStyle(color: Colors.red)),
              ),
            ],
      ),
    );
  }
}
