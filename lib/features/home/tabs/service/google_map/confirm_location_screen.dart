import 'package:flutter/material.dart';
import 'package:soor_user_app/core/themes/styles/app_style.dart';
import 'package:soor_user_app/core/widgets/custom_elevated_button.dart';
import 'package:soor_user_app/features/home/tabs/service/add_details/add_details_screen.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/widgets/location_text_field.dart';
import 'google_maps_screen.dart';

class ConfirmLocationScreen extends StatefulWidget {
  final String address;

  const ConfirmLocationScreen({super.key, required this.address});

  @override
  State<ConfirmLocationScreen> createState() => _ConfirmLocationScreenState();
}

class _ConfirmLocationScreenState extends State<ConfirmLocationScreen> {
  final landmarkController = TextEditingController();
  final buildingController = TextEditingController();
  final floorController = TextEditingController();
  final extraDetailsController = TextEditingController();

  @override
  void dispose() {
    landmarkController.dispose();
    buildingController.dispose();
    floorController.dispose();
    extraDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.appBarColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text('تاكيد الموقع', style: AppStyle.bold16white),
          leading: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: _circleIconButton(
              icon: Icons.arrow_back,
              onTap: () => Navigator.pop(context),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      _buildLocationPreviewCard(),
                      const SizedBox(height: 24),
                      const Text(
                        'بيانات إضافية للموقع',
                        style: AppStyle.bold16white,
                      ),
                      const SizedBox(height: 14),
                      LocationTextField(
                        hint: 'اسم النقطة',
                        controller: landmarkController,
                      ),
                      LocationTextField(
                        hint: 'رقم المنزل',
                        controller: buildingController,
                      ),
                      LocationTextField(
                        hint: 'رقم الدور',
                        controller: floorController,
                      ),
                      LocationTextField(
                        hint: 'تفاصيل اضافية للعنوان',
                        controller: extraDetailsController,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    onPressed: _onConfirm,
                    text: 'تاكيد',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationPreviewCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grayDark100Color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 130,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(color: AppColors.borderSideColor),
                ),
                const Icon(
                  Icons.location_on,
                  color: AppColors.primary600,
                  size: 34,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const GoogleMapsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                    color: AppColors.describtionColor,
                  ),
                  label: Text('تعديل', style: AppStyle.bold14white),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: Text(
                    widget.address,
                    textAlign: TextAlign.right,
                    style: AppStyle.bold14white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: AppColors.grayDark100Color,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  void _onConfirm() {
    final data = {
      'address': widget.address,
      'landmark': landmarkController.text,
      'building': buildingController.text,
      'floor': floorController.text,
      'extraDetails': extraDetailsController.text,
    };
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDetailsScreen()),
    );
  }
}
