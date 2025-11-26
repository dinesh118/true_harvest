// import 'package:flutter/material.dart';
// import 'package:task_new/utils/app_colors.dart';

// class QuantitySelector extends StatelessWidget {
//   final int quantity;
//   final VoidCallback onAdd;
//   final VoidCallback onRemove;

//   const QuantitySelector({
//     super.key,
//     required this.quantity,
//     required this.onAdd,
//     required this.onRemove,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         _circleButton(Icons.remove, onRemove, AppColors.lightBackground),
//         const SizedBox(width: 12), // reduced
//         Text(
//           quantity.toString(),
//           style: const TextStyle(
//             fontSize: 18, // slightly smaller
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(width: 12), // reduced
//         _circleButton(Icons.add, onAdd, AppColors.darkGreen),
//       ],
//     );
//   }

//   Widget _circleButton(IconData icon, VoidCallback onTap, Color color) {
//     return InkWell(
//       onTap: onTap,
//       child: CircleAvatar(
//         radius: 12, // smaller button
//         backgroundColor: color,
//         child: Icon(
//           icon,
//           color: Colors.white,
//           size: 13, // smaller icon
//         ),
//       ),
//     );
//   }
// }
