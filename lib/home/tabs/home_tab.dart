import 'package:flutter/material.dart';
import 'package:soor_user_app/utils/app_assets.dart';
import 'package:soor_user_app/utils/app_colors.dart';
import 'package:soor_user_app/utils/app_style.dart';
import 'package:soor_user_app/widget/custom_container_opinions.dart';
import 'package:soor_user_app/widget/custom_container_services.dart';
import 'package:soor_user_app/widget/custom_elevated_button.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
     appBar: AppBar(
      title: Row(
        children: [
          Image.asset(AppAssets.soorLogo),
          Spacer(),
          Icon(Icons.notifications_none)
        ],
      ),
     ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*0.04),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(),
              Text('خصم 50% علي اول حجز', style: AppStyle.bold24white,textAlign: .end,),
              CustomElevatedButton(onPressed: () {

              }, text: 'احجز الان', backgroundColor: AppColors.primary600,
              ),
              Icon(Icons.more_horiz, size: 30, color: Colors.white,),
              Row(
                children: [
                  Text('الخدمات', style: AppStyle.bold16white,),
                  Spacer(),
                  Text('المزيد >', style: AppStyle.medium16secondaryGrey,),
                ],
              ),
             Row(
               children: [
                 CustomContainerServices(
                   color: Colors.orange,
                   icon: Icon(Icons.person, size: 35, color: Colors.white,),
                   text: 'طلب فرد',
                 ),
                 SizedBox(width: width*0.04,),
                 CustomContainerServices(
                   color: AppColors.primary600,
                   icon: Icon(Icons.person, size: 35, color: Colors.white,),
                   text: 'مناسبات',
                 ),
               ],
             ),
              SizedBox(height: height*0.02,),
              Text('الحجز الحالي', style: AppStyle.bold24white,),
              SizedBox(height: height*0.02,),
              Container(
                width: width*0.92,
                height: height*0.16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.appBarColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width*0.02),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: .spaceAround,
                        children: [
                          Text('#12336455',style: AppStyle.bold16white,),
                          Text('1600 ريال',style: AppStyle.bold16primary,),
                          Text('اضافه تقييم >',style: AppStyle.bold16primary,),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          CustomElevatedButton(

                            onPressed: () {

                          }, text: 'منتهي', backgroundColor: AppColors.sucessColor,
                            radius: 360,

                          ),
                          Text('اليوم 8:00 م الى 11:00 م', style: AppStyle.medium16darkGrey,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Text('اراء عملائنا', style: AppStyle.bold24white,),

              // todo: customer opinion
             CustomContainerOpinions(),
             SizedBox(height: height*0.02,),
             CustomContainerOpinions(),
             SizedBox(height: height*0.02,),
             CustomContainerOpinions(),
             SizedBox(height: height*0.02,),
             CustomContainerOpinions(),
             SizedBox(height: height*0.02,),
             CustomContainerOpinions(),
             SizedBox(height: height*0.02,),
            ],
          ),
        ),
      )
    );
  }
}
