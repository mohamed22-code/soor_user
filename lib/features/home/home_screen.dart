import 'package:flutter/material.dart';
import 'package:soor_user_app/features/home/tabs/booking_tab.dart';
import 'package:soor_user_app/features/home/tabs/home_tab.dart';
import 'package:soor_user_app/features/home/tabs/more/more_tab.dart';
import 'package:soor_user_app/features/home/tabs/service/services_tab.dart';

import '../../core/utils/app_assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final List<Widget> tabsList = const [
    HomeTab(),
    ServicesTab(),
    BookingTab(),
    MoreTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(index: selectedIndex, children: tabsList),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
          onTap: (index) {
selectedIndex=index;
setState(() {

});
          },
          items: [
            builtBottomNavBarItem(
                selectedIconName: AppAssets.selectedHomeImage,
                unSelectedIconName: AppAssets.homeImage,
                index: 0,
                label: 'الرئيسية'),
            builtBottomNavBarItem(
                selectedIconName: AppAssets.selectedServicesImage,
                unSelectedIconName: AppAssets.servicesImage,
                index: 1,
                label: 'الخدمات'),
            builtBottomNavBarItem(
                selectedIconName: AppAssets.selectedCalendarImage,
                unSelectedIconName: AppAssets.calendarImage,
                index: 2,
                label: 'الحجوزات'),
            builtBottomNavBarItem(
                selectedIconName: AppAssets.selectedMoreImage,
                unSelectedIconName: AppAssets.moreImage,
                index: 3,
                label: 'المزيد'),
          ]),
    );
  }

  BottomNavigationBarItem builtBottomNavBarItem({
    required String selectedIconName,
    required String unSelectedIconName,
    required int index,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(
          selectedIndex == index ? selectedIconName : unSelectedIconName,
        ),
      ),
      label: label,
    );
  }
}
