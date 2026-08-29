import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soor_user_app/features/home/tabs/more/widget/custom_profile_text_field.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/styles/app_style.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../profile/presentation/cubit/profile_cubit.dart';
import '../../../profile/presentation/cubit/profile_state.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool _initialized = false;

  bool _isSaudiPhone(String t) =>
      RegExp(r'^(\+966|966|0)?5\d{8}$').hasMatch(t.trim());

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) =>
      ProfileCubit()
        ..fetchProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)));
          } else if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)));
          } else if (state is ProfileLoaded && !_initialized) {
            nameController.text = state.user.userName ?? '';
            emailController.text = state.user.userEmail ?? '';
            phoneController.text = state.user.userPhone ?? '';
            _initialized = true;
          } else if (state is ProfileDeleted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                'login_screen', (r) => false);
          }
        },
        builder: (context, state) {
          final isLoading = state is ProfileLoading || state is ProfileUpdating;
          if (state is ProfileLoading && !_initialized) {
            return Scaffold(
              appBar: AppBar(
                  title: const Text('الحساب', style: AppStyle.medium16white),
                  centerTitle: true),
              body: const Center(child: CircularProgressIndicator(
                  color: AppColors.primaryText)),
            );
          }
          return Scaffold(
            appBar: AppBar(
                title: const Text('الحساب', style: AppStyle.medium16white),
                centerTitle: true),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04, vertical: height * 0.02),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomProfileTextField(
                        label: 'رقم الجوال',
                        hintText: '+966 500 000 000',
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                      ),
                      SizedBox(height: height * 0.02),
                      CustomProfileTextField(
                        label: 'البريد الإلكتروني',
                        hintText: 'info@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                      ),
                      SizedBox(height: height * 0.02),
                      CustomProfileTextField(
                        label: 'الاسم كامل',
                        hintText: 'أحمد محمد',
                        controller: nameController,
                      ),
                      SizedBox(height: height * 0.02),
                      CustomProfileTextField(
                        label: 'كلمة المرور (اتركه فارغ دون تغيير)',
                        hintText: '*********',
                        obscureText: true,
                        controller: passwordController,
                      ),
                      SizedBox(height: height * 0.02),
                      CustomProfileTextField(
                        label: 'تأكيد كلمة المرور',
                        hintText: '*********',
                        obscureText: true,
                        controller: confirmController,
                      ),
                      SizedBox(height: height * 0.03),
                      if (isLoading)
                        const Center(child: CircularProgressIndicator(
                            color: AppColors.primaryText))
                      else
                        SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            onPressed: () => _save(context),
                            text: 'حفظ التغييرات',
                            backgroundColor: AppColors.primaryText,
                          ),
                        ),
                      SizedBox(height: height * 0.02),
                      TextButton(
                        onPressed: () => _confirmDelete(context),
                        child: const Text('حذف الحساب', style: TextStyle(
                            color: Colors.red)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _save(BuildContext context) {
    if (!_validate()) return;
    context.read<ProfileCubit>().updateProfile(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.isEmpty ? null : passwordController
          .text,
      confirmPassword: confirmController.text.isEmpty ? null : confirmController
          .text,
    );
  }

  bool _validate() {
    if (nameController.text
        .trim()
        .isEmpty) {
      _snack('يرجى إدخال الاسم');
      return false;
    }
    if (!_isSaudiPhone(phoneController.text)) {
      _snack('رقم جوال غير صحيح');
      return false;
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(
        emailController.text.trim())) {
      _snack('بريد إلكتروني غير صحيح');
      return false;
    }
    if (passwordController.text.isNotEmpty &&
        passwordController.text.length < 6) {
      _snack('كلمة المرور 6 أحرف على الأقل');
      return false;
    }
    if (passwordController.text != confirmController.text) {
      _snack('كلمة المرور غير متطابقة');
      return false;
    }
    return true;
  }

  void _snack(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            backgroundColor: AppColors.appBarColor,
            title: const Text('حذف الحساب', style: AppStyle.bold16white),
            content: const Text(
                'هل أنت متأكد من حذف الحساب؟', style: AppStyle.medium16white),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context),
                  child: const Text('إلغاء')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<ProfileCubit>().deleteAccount();
                },
                child: const Text('حذف', style: TextStyle(color: Colors.red)),
              ),
            ],
      ),
    );
  }
}
