// import 'package:flutter/material.dart';
//
// import '../../../../core/widgets/add_time_bottom_sheet.dart';
//
// class BottomButtonsWidget extends StatelessWidget {
//   const BottomButtonsWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: SizedBox(
//             height: 48,
//             child: ElevatedButton(
//               onPressed: () {
//                 //todo: navigate to rate
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff3D2D08),
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(7),
//                 ),
//                 elevation: 0,
//               ),
//               child: const Text(
//                 'تقييم',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 12),
//
//         Expanded(
//           child: SizedBox(
//             height: 48,
//             child: ElevatedButton(
//               onPressed: () {
//                 //todo: add additional time
//                 showAddTimeBottomSheet(context);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.black,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(7),
//                 ),
//                 elevation: 0,
//               ),
//               child: const Text(
//                 'مد وقت اضافي',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//   void showAddTimeBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) {
//         return const AddTimeBottomSheet();
//       },
//     );
//   }
// }
