import 'package:dot_safety/app/components/card_description.dart';
import 'package:dot_safety/app/components/image-card.dart';
import 'package:dot_safety/app/controller/dashboard_controller.dart';
import 'package:dot_safety/app/controller/vehicle_controller.dart';
import 'package:dot_safety/app/ui/pages/notification/alert_screen.dart';
import 'package:dot_safety/app/ui/pages/dashboard/selectLawEnforcement.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
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

  final VehicleController vehicleController = Get.put(VehicleController());

  updateState(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      drawer: Container(
        width: DeviceUtils.getScaledWidth(context, scale: 1),
        child: Drawer(
            child: SelectLawEnforcement(
                lawEnforcementAgencies:
                    dashboardController.lawEnforcementAgencies)),
      ),
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
                              DeviceUtils.getScaledHeight(context, scale: 0.08),
                        ),
                        TextField(
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                              DeviceUtils.getScaledHeight(context, scale: 0.03),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                Strings.vehicle,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: 'Montserrat Bold',
                                    color: AppColors.appPrimaryColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.02),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: DeviceUtils.getScaledHeight(context,
                                  scale: 0.02),
                            ),
                            CarouselWidget(context, vehicleController),
                          ],
                        ),

                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          height: DeviceUtils.getScaledHeight(context, scale: 0.49),
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

StatelessWidget EventBlock(context, text, screen, isSet) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    },
    child: Container(
      height: 160,
      width: 160,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.color13,
              blurRadius: 0.5, // soften the shadow
              spreadRadius: 1.5, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                0.0, // Move to bottom 10 Vertically
              ),
            )
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: (isSet)
                      ? Transform.rotate(
                          angle: 40,
                          child: Icon(
                            Icons.arrow_back_ios_sharp,
                            size: 20,
                            color: AppColors.appPrimaryColor,
                          ))
                      : null)),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Montserrat Regular',
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ),
  );
}

StatelessWidget CarouselWidget(context, vehicleController) {
  return Container(
    height: 156,
    child: Row(
      children: [
        Flexible(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            // new
            itemCount: vehicleController.vehicles.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: ImageCardAdd(
                      context,
                      vehicleController.vehicles[i]['vehicle_name'],
                      'assets/images/img2.png',
                      true));
            },
          ),
        ),
        // GestureDetector(
        //     onTap: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => VehicleDocument()));
        //     },
        //     child: ImageCardAdd(
        //       context, "Add Vehicle",
        //       'assets/images/addicon.png', false),
        //     )
      ],
    ),

    // ListView(
    //   scrollDirection: Axis.horizontal,
    //   children: [
    //     ImageCardAdd(context, "Lexus",
    //         'assets/images/img2.png', true),
    //     ImageCardAdd(context, "Mercedes",
    //         'assets/images/img3.png', true),
    //     GestureDetector(
    //       onTap: () {
    //         Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => VehicleDocument()));
    //       },
    //       child: ImageCardAdd(context, "Add Vehicle",
    //           // 'assets/images/addicon.png', false),
    //     )
    //   ],
    // )
  );
}

showAlertDialog(BuildContext context, litems, selectedIndex, updateState) {
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.all(5),
    content: Container(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.07)),
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Icons.check_box_outline_blank,
                  color: AppColors.appPrimaryColor,
                ),
                title: Text(
                  litems[0],
                  style: TextStyle(
                    fontFamily: 'Montserrat Regular',
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AlertScreen(
                                alert: "Traffic Offence",
                                time: '',
                                description: '',
                              )));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.check_box_outline_blank,
                  color: AppColors.appPrimaryColor,
                ),
                title: Text(
                  litems[1],
                  style: TextStyle(
                    fontFamily: 'Montserrat Regular',
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AlertScreen(
                              alert: "Accident", time: '', description: '')));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.check_box_outline_blank,
                  color: AppColors.appPrimaryColor,
                ),
                title: Text(
                  litems[2],
                  style: TextStyle(
                    fontFamily: 'Montserrat Regular',
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AlertScreen(
                              alert: "Kidnap", time: '', description: '')));
                },
              )
            ],
          ),
        ),
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
