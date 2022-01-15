import 'package:dot_safety/app/components/card_description.dart';
import 'package:dot_safety/app/components/image-card.dart';
import 'package:dot_safety/app/controller/dashboard_controller.dart';
import 'package:dot_safety/app/controller/vehicle_controller.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int? selectedIndex;
  List<String> litems = ["Traffic Offence", "Accident", "Kidnap"];
  final DashboardController dashboardController =
      Get.put(DashboardController());


  updateState(index) {
    setState(() {
      selectedIndex = index;
    });
  }

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
                color: AppColors.color2,
                padding: EdgeInsets.symmetric(
                    horizontal:
                        DeviceUtils.getScaledWidth(context, scale: 0.05)),
                height: DeviceUtils.getScaledHeight(context, scale: 1),
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.06),
                        ),
                        TextField(
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              fillColor: AppColors.whiteColor,
                              focusColor: AppColors.whiteColor,
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.color12,
                              ),
                              hintText: "Search For Offences",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat Regular',
                                 ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 32.0,
                                      color: AppColors.appPrimaryColor),
                                  borderRadius: BorderRadius.circular(6.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 32.0),
                                  borderRadius: BorderRadius.circular(6.0)),
                            )),
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.01),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: DeviceUtils.getScaledHeight(context,
                                  scale: 0.02),
                            ),
                            CarouselWidget(context, dashboardController),
                          ],
                        ),

                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          height: DeviceUtils.getScaledHeight(context, scale: 0.64),
                          child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return CardDescription(
                                  context,
                                  "Lexus",
                                  "venxs3345df venxs3345df venxs3345df  venxs3345df venxs3345df",
                                  'assets/images/img4.png',
                                  true);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
        key: null,
      ),
    );
  }
}

StatelessWidget CarouselWidget(context, dashboardController) {
  print(dashboardController.lawEnforcementAgencies);
  return Container(
    height: 100,
    child: Row(
      children: [
        Flexible(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            // new
            itemCount: dashboardController.lawEnforcementAgencies.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return ClipRRect(
                child: ImageCardAdd(
                    context,
                    dashboardController.lawEnforcementAgencies,
                    'assets/images/img2.png',
                    true),
              );
            },
          ),
        ),

      ],
    ),

  );
}
