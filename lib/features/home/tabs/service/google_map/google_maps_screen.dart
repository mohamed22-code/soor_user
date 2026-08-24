// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class GoogleMapsScreen extends StatefulWidget {
//   const GoogleMapsScreen({super.key});
//
//   @override
//   State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
// }
//
// class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
//   String? _style;
//   Future<void> _loadMapStyle() async {
//     final String style = await rootBundle.loadString('assets/map_style/map_style.json');
//     setState(() {
//       _style = style;
//     });
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _loadMapStyle();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return GoogleMap(
//       initialCameraPosition: CameraPosition(
//         target: LatLng(24.713341045983846, 46.67668940689257),
//         zoom: 10
//       ),
//       // style: styleMap,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:soor_user_app/core/themes/styles/app_style.dart';
import 'package:soor_user_app/core/widgets/custom_elevated_button.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import 'confirm_location_screen.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({super.key});

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  String? _style;

  Future<void> _loadMapStyle() async {
    final String style = await rootBundle.loadString(
      'assets/map_style/map_style.json',
    );
    setState(() {
      _style = style;
    });
  }

  GoogleMapController? _mapController;

  static const LatLng _initialPosition = LatLng(
    24.713341045983846,
    46.67668940689257,
  );

  String _addressLine1 = 'الرياض, المملكة العربية السعوديه';
  String _addressLine2 = 'احداثيات العوان على الخريطة';
  bool _isMoving = false;

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _buildSearchBar(),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _buildMap(),
                    _buildTooltipAndPin(),
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: _buildLocateMeButton(),
                    ),
                  ],
                ),
              ),
              _buildBottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMap() {
    if (_style == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryText),
      );
    }

    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: _initialPosition,
        zoom: 10,
      ),
      style: _style,
      onMapCreated: (controller) => _mapController = controller,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onCameraMoveStarted: () => setState(() => _isMoving = true),
      onCameraIdle: () => setState(() => _isMoving = false),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              padding: EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.grayDark100Color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.right,
                      style: AppStyle.medium14darkGrey,
                      decoration: InputDecoration(
                        hintText: 'البحث عن موقع',
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.search,
                    color: AppColors.describtionColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          _circleIconButton(
            icon: Icons.arrow_forward,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTooltipAndPin() {
    return IgnorePointer(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'حرك المؤشر لاختيار المكان',
                style: AppStyle.medium14darkGrey,
              ),
            ),
            const SizedBox(height: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              transform: Matrix4.translationValues(0, _isMoving ? -8 : 0, 0),
              child: const Icon(
                Icons.location_on,
                color: AppColors.primary600,
                size: 42,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocateMeButton() {
    return _circleIconButton(
      icon: Icons.my_location,
      backgroundColor: Colors.white,
      iconColor: Color(0xff1D1C1B),
      onTap: () {
        // TODO: current location
        _mapController?.animateCamera(CameraUpdate.newLatLng(_initialPosition));
      },
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        color: AppColors.appBarColor,
        border: Border(top: BorderSide(color: AppColors.borderSideColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(_addressLine1, style: AppStyle.medium16white),
          const SizedBox(height: 4),
          Text(
            _addressLine2,
            textAlign: TextAlign.right,
            style: AppStyle.medium14darkGrey,
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: CustomElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ConfirmLocationScreen(address: _addressLine1),
                  ),
                );
              },
              text: 'حفظ',
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleIconButton({
    required IconData icon,
    required VoidCallback onTap,
    Color backgroundColor = AppColors.grayDark100Color,
    Color iconColor = Colors.white,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}
