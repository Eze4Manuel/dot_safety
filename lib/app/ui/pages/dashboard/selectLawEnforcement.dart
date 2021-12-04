import 'package:dot_safety/app/ui/pages/dashboard/event_selection.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectLawEnforcement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: ResponsiveSafeArea(
        builder: (context, size) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
                // height: DeviceUtils.getScaledHeight(context, scale: 1),
                width: DeviceUtils.getScaledWidth(context, scale: 1),
                color: AppColors.whiteColor,
                child: SelectLawEnforcementList()),
          );
        },
        key: null,
      ),
    );
  }
}

class SelectLawEnforcementList extends StatefulWidget {
  const SelectLawEnforcementList({Key? key}) : super(key: key);

  @override
  _SelectLawEnforcementListState createState() =>
      _SelectLawEnforcementListState();
}

class _SelectLawEnforcementListState extends State<SelectLawEnforcementList> {
  int? selectedIndex;

  List<String> litems = [
    "Federal Road Satefy Corps",
    "Nigeria Police Force",
    "Lagos State Management Authority",
    "Vehicle Inspector Officer",
    "State Security",
    "Nigeria Security & Civil Defence",
    "Economic & Financial Crime comission",
    "Other"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.07)),
      // height: DeviceUtils.getScaledHeight(context, scale: 1),
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.07),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        // radius of 10
                        color: AppColors.color2,
                      ),
                      child: Icon(Icons.close))),
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.05),
            ),
            Center(
              child: Text(
                Strings.selectLaw,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    fontFamily: 'Montserrat Regular',
                    color: AppColors.appPrimaryColor),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.01),
            ),
            Center(
              child: Text(
                Strings.setNewPassword,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: 'Montserrat Regular',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.05),
            ),
            ListView.builder(
                itemCount: litems.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(
                      (selectedIndex == index)
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: AppColors.appPrimaryColor,
                    ),
                    title: Text(
                      litems[index],
                      style: TextStyle(
                        fontFamily: 'Montserrat Regular',
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventSelection()));
                    },
                  );
                }),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.08),
            ),
          ],
        ),
      ),
    );
  }
}
