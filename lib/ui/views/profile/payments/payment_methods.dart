// import 'package:flutter/material.dart';
// import 'package:staarm_mobile/utils/staarm_page_route.dart';

// import 'add_card.dart';
// import 'widgets/payment_method_item.dart';

// class PaymentMethodsView extends StatelessWidget {
//   const PaymentMethodsView({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(
//           color: Color(0xFF717171),
//         ),
//         title: Text(
//           'Payment Method',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 14,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: 15,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 17,
//                 ),
//                 child: Text(
//                   'Payment method',
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 21,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               PaymentMethodItem(
//                 title: 'Mastercard 7932',
//               ),
//               PaymentMethodItem(
//                 title: 'Mastercard 7932',
//               ),
//               SizedBox(height: 10),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     StaarmPageRoute.routeTo(
//                       builder: (context) => AddCardView(),
//                     ),
//                   );
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 12,
//                   ),
//                   child: Text(
//                     'Add new payment method',
//                     style: TextStyle(
//                       color: Color(0xFF5A6474),
//                       fontSize: 14,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
