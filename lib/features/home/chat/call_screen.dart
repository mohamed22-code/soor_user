import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/themes/colors/app_colors.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool isMuted = false;
  bool isSpeaker = false;
  int seconds = 0;
  Timer? timer;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => isConnected = true);
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (t) => setState(() => seconds++),
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String get formattedTime {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close, color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isConnected ? 'متصل - $formattedTime' : 'جاري الاتصال',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff2D9EC4),
                  ),
                ),
                SizedBox(height: height * 0.04),
                const Text(
                  'Soor',
                  style: TextStyle(
                    fontSize: 53,
                    color: AppColors.darkGray,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  isConnected ? formattedTime : '',
                  style: const TextStyle(color: Colors.white54, fontSize: 14),
                ),
                SizedBox(height: height * 0.04),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.9, end: 1.1),
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  builder: (context, scale, child) =>
                      Transform.scale(scale: scale, child: child),
                  onEnd: () => setState(() {}),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                    child: Center(
                      child: Image.asset(
                        AppAssets.soorCallImage,
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                color: Colors.red,
                icon: const Icon(Icons.call_end, color: Colors.white, size: 28),
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(width: width * 0.06),
              _buildButton(
                color: isMuted
                    ? AppColors.primaryText
                    : AppColors.grayDark100Color,
                icon: Icon(
                  isMuted ? Icons.mic_off : Icons.mic,
                  color: Colors.white,
                  size: 24,
                ),
                onTap: () => setState(() => isMuted = !isMuted),
              ),
              SizedBox(width: width * 0.06),
              _buildButton(
                color: isSpeaker
                    ? AppColors.primaryText
                    : AppColors.grayDark100Color,
                icon: Icon(
                  Icons.volume_up,
                  color: isSpeaker ? Colors.white : Colors.white,
                  size: 24,
                ),
                onTap: () => setState(() => isSpeaker = !isSpeaker),
              ),
            ],
          ),
          SizedBox(height: height * 0.04),
        ],
      ),
    );
  }

  Widget _buildButton({
    required Color color,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(360),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(360),
          color: color,
        ),
        child: icon,
      ),
    );
  }
}
