// import 'package:flutter/material.dart';
//
// class TimeLineWidget extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final bool isCompleted;
//   final bool isCurrent;
//   bool isLast ;
//    TimeLineWidget({super.key, required this.title, required this.subtitle,
//     required this.isCompleted, required this.isCurrent, this.isLast = false});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 65,
//       child: Row(
//         children: [
//           SizedBox(
//             width: 30,
//             child: Column(
//               children: [
//                 Container(
//                   width: 20,
//                   height: 20,
//                   decoration: BoxDecoration(
//                     borderRadius: .circular(12),
//                     color: isCompleted || isCurrent
//                         ? Color(0xff2D9EC4)
//                         : Color(0xff00394C),
//                   ),
//                   child: isCompleted
//                       ? Icon(Icons.check, color: Colors.white, size: 14)
//                       : isCurrent
//                       ? Container(
//                     margin: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Colors.white,
//                     ),
//                   )
//                       : null,
//                 ),
//
//                 if (!isLast)
//                   Expanded(
//                     child: Container(width: 2, color: const Color(0xff007AA2)),
//                   ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 8),
//
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     color: isCompleted || isCurrent
//                         ? const Color(0xff0085AD)
//                         : Colors.grey,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//
//                 const SizedBox(height: 3),
//
//                 Text(
//                   subtitle,
//                   style: const TextStyle(color: Colors.grey, fontSize: 11),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
