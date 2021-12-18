import 'package:dot_safety/app/controller/dashboard_controller.dart';
import 'package:dot_safety/app/ui/pages/dashboard/event_selection.dart';
import 'package:dot_safety/app/ui/pages/dashboard/offence_list.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:get/get.dart';

class SelectLawEnforcement extends StatefulWidget {

  List lawEnforcementAgencies = [];

  SelectLawEnforcement({ required this.lawEnforcementAgencies});

  @override
  State<SelectLawEnforcement> createState() => _SelectLawEnforcementState();
}

class _SelectLawEnforcementState extends State<SelectLawEnforcement> {

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    List litems = widget.lawEnforcementAgencies;

    final DashboardController dashboardController =
    Get.put(DashboardController());

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
                child: Container(
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
                            itemCount: dashboardController.lawEnforcementAgencies.length,
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
                                  dashboardController.lawEnforcementAgencies[index]['law_enforcement'],
                                  style: TextStyle(
                                    fontFamily: 'Montserrat Regular',
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Offense( offenseId:litems[index])));
                                },
                              );
                            }),
                        SizedBox(
                          height: DeviceUtils.getScaledHeight(context, scale: 0.08),
                        ),
                      ],
                    ),
                  ),
                )),
          );
        },
        key: null,
      ),
    );
  }
}