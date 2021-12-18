// import 'package:dot_safety/app/ui/pages/dashboard/offence_list.dart';
// import 'package:flutter/material.dart';
// import 'package:dot_safety/app/utils/responsive_safe_area.dart';
// import 'package:dot_safety/app/utils/device_utils.dart';
// import 'package:dot_safety/app/ui/theme/app_colors.dart';
// import 'package:dot_safety/app/ui/theme/app_strings.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class EventSelection extends StatefulWidget {
//   @override
//   _EventSelectionState createState() => _EventSelectionState();
// }
//
// class _EventSelectionState extends State<EventSelection> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//           preferredSize: Size.fromHeight(100.0),
//           child: AppBar(
//             automaticallyImplyLeading: false,
//             leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Padding(
//                 padding: const EdgeInsets.only(top: 18.0),
//                 child: Icon(Icons.arrow_back),
//               ),
//             ),
//             backgroundColor: AppColors.secondaryColor,
//             flexibleSpace: Align(
//               alignment: Alignment.center,
//               child: Text(
//                 Strings.selectEvent,
//                 style:
//                 TextStyle(
//                   fontFamily: 'Montserrat Bold',
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.whiteColor,
//                   fontSize: 18,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           )),
//       body: ResponsiveSafeArea(
//         builder: (context, size) {
//           return Padding(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery
//                   .of(context)
//                   .viewInsets
//                   .bottom,
//             ),
//             child: Container(
//               // height: DeviceUtils.getScaledHeight(context, scale: 1),
//                 width: DeviceUtils.getScaledWidth(context, scale: 1),
//                 color: AppColors.whiteColor,
//                 child: HomeViews(context, "title")),
//           );
//         },
//         key: null,
//       ),
//     );
//   }
// }
//
// StatelessWidget HomeViews(context, String title) {
//   return SingleChildScrollView(
//     child: Container(
//       padding: EdgeInsets.symmetric(
//           horizontal: DeviceUtils.getScaledWidth(context, scale: 0.07)),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: DeviceUtils.getScaledHeight(context, scale: 0.04),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     EventBlock(context, Strings.crimeOffence,
//                         Offense(offenceTitle: "Crime Offence"), false),
//                     EventBlock(context, Strings.stopAndSearch,
//                         Offense(offenceTitle: "Stop And Search"), false),
//                   ],
//                 ),
//                 SizedBox(
//                   height: DeviceUtils.getScaledHeight(context, scale: 0.04),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     EventBlock(context, Strings.trafficOffence,
//                         Offense(offenceTitle: "Traffic Offence"), false),
//                     EventBlock(context, Strings.drugTrafficking,
//                         Offense(offenceTitle: "Drug Trafficking"), false),
//                   ],
//                 ),
//                 SizedBox(
//                   height: DeviceUtils.getScaledHeight(context, scale: 0.04),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     EventBlock(context, Strings.illegalBunkering,
//                         Offense(offenceTitle: "Illegal Bunkering"), false),
//                     EventBlock(context, Strings.others,
//                         Offense(offenceTitle: "Others"), false),
//                   ],
//                 ),
//                 SizedBox(
//                   height: DeviceUtils.getScaledHeight(context, scale: 0.04),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
//
// StatelessWidget EventBlock(context, text, screen, isSet) {
//   return GestureDetector(
//     onTap: () {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
//     },
//     child: Container(
//       height: 160,
//       width: 160,
//       decoration: BoxDecoration(
//           color: AppColors.whiteColor,
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.color13,
//               blurRadius: 0.5, // soften the shadow
//               spreadRadius: 1.5, //extend the shadow
//               offset: Offset(
//                 0.0, // Move to right 10  horizontally
//                 0.0, // Move to bottom 10 Vertically
//               ),
//             )
//           ],
//           borderRadius: BorderRadius.circular(8)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Align(
//               alignment: Alignment.topRight,
//               child: Padding(
//                   padding: const EdgeInsets.only(right: 4.0),
//                   child: (isSet)
//                       ? Transform.rotate(
//                       angle: 40,
//                       child: Icon(
//                         Icons.arrow_back_ios_sharp,
//                         size: 20,
//                         color: AppColors.appPrimaryColor,
//                       ))
//                       : null)),
//           SizedBox(
//             height: DeviceUtils.getScaledHeight(context, scale: 0.01),
//           ),
//           Center(
//             child: Text(
//               text,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//                 fontFamily: 'Montserrat Bold',
//               ),
//               textAlign: TextAlign.center,
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }
