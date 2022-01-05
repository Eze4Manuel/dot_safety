import 'dart:convert';

import 'package:alan_voice/alan_voice.dart';
import 'package:dot_safety/app/controller/dashboard_controller.dart';
import 'package:dot_safety/app/controller/vehicle_controller.dart';
import 'package:dot_safety/app/ui/pages/dashboard/selectLawEnforcement.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedIndex;
  String? firstName = '';
  String profileImage = '';

  List<String> litems = ["Traffic Offence", "Accident", "Kidnap"];


  final DashboardController dashboardController = Get.put(DashboardController());
  final VehicleController vehicleController = Get.put(VehicleController());

  updateState(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void getShared() async {
    var a = await SharedPrefs.readSingleString('first_name');
    var c = await SharedPrefs.readSingleString('image_url');

    setState(() {
      firstName = a;
      if(c != null && c.length > 0){
        profileImage = '${Strings.domain}'+ c;
      }
    });
  }
  void getVehicleData() async {
    vehicleController.getUploadedVehicled();
  }

  void _handleCommand(Map<String, dynamic> command) {
    switch(command["command"]) {
      case "kidnap":
        showAlertDialog(context, litems, selectedIndex,
            updateState);
        break;
      case "accident":
        showAlertDialog(context, litems, selectedIndex,
            updateState);
        break;
      case "traffic offence":
        showAlertDialog(context, litems, selectedIndex,
            updateState);
        break;
      default:
        debugPrint("Unknown command");
    }
  }


  _MyHomePageState() {
    AlanVoice.addButton("a1c46dbcf4253128a38065b8253b53da2e956eca572e1d8b807a3e2338fdd0dc/stage",
      buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT
    );

    AlanVoice.onCommand.add((command) => _handleCommand(command.data));
  }


  @override
  void initState(){
    super.initState();
    getShared();
    getVehicleData();
    _MyHomePageState();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      drawer: Container(
        width: DeviceUtils.getScaledWidth(context, scale: 1),
        child: Drawer(child: SelectLawEnforcement( lawEnforcementAgencies: dashboardController.lawEnforcementAgencies)),
      ),
      body: ResponsiveSafeArea(
        builder: (context, size) {
          return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                color: AppColors.color2,
                height: DeviceUtils.getScaledHeight(context, scale: 1),
                width: DeviceUtils.getScaledWidth(context, scale: 1),
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.04),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: DeviceUtils.getScaledWidth(context,
                                  scale: 0.05)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if(await dashboardController.getAgencyList()){
                                        Scaffold.of(context).openDrawer();
                                      }else{
                                        toast(dashboardController.message.value);
                                      }
                                    },
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: CircleAvatar(
                                        radius: 25.0,
                                        backgroundColor: AppColors.color11,
                                        child: (profileImage.length > 0) ?
                                         CachedNetworkImage(
                                          imageUrl: profileImage,
                                          fit: BoxFit.cover,
                                          imageBuilder: (context, imageProvider) => Container(
                                            width: 80.0,
                                            height: 80.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageProvider, fit: BoxFit.cover),
                                            ),),
                                          placeholder: (context, url) => CircleAvatar(
                                            radius: 25,
                                            backgroundColor: AppColors.color11,
                                            child: Container(),
                                          ),
                                          errorWidget: (context, url, error) => Container(),
                                        )
                                            : Container()
                                      ),

                                    ),
                                  ),
                                  SizedBox(
                                    width: DeviceUtils.getScaledWidth(context,
                                        scale: 0.05),
                                  ),
                                  Text(
                                    'Hi, $firstName!'.substring(0, firstName!.length + 5),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'Montserrat Regular',
                                        color: AppColors.appPrimaryColor),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  showAlertDialog(context, litems, selectedIndex,
                                      updateState);
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    'assets/images/alert.png',
                                    width: DeviceUtils.getScaledWidth(context,
                                        scale: 0.11),
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.11),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.01),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: DeviceUtils.getScaledWidth(context,
                                      scale: 0.03)),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Issues:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.appPrimaryColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: DeviceUtils.getScaledWidth(context, scale: 0.02),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CarouselWidget(context),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.03),
                        ),
                      ],
                    ),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemCount: 22,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Container(
                                color: AppColors.color3,
                                margin: const EdgeInsets.all(3),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.image,
                                      color: AppColors.color2,
                                      size: 25,
                                    )),
                              ),
                            ],
                          );
                        },
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

StatelessWidget CarouselWidget(context) {
  return Container(
      height: 40,
      width: DeviceUtils.getScaledWidth(context, scale: 0.77),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.color3),
                  borderRadius: BorderRadius.circular(4), // radius of 10
                ),
                child: Text(
                  'Nearby',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'Montserrat Regular',
                  ),
                ),
              )),
          SizedBox(
            width: DeviceUtils.getScaledWidth(context, scale: 0.01),
          ),
          GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.color3),
                  borderRadius: BorderRadius.circular(4), // radius of 10
                ),
                child: Text(
                  'Nationwide',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'Montserrat Regular',
                  ),
                ),
              )),
          SizedBox(
            width: DeviceUtils.getScaledWidth(context, scale: 0.01),
          ),
          GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.color3),
                  borderRadius: BorderRadius.circular(4), // radius of 10
                ),
                child: Text(
                  'My Community',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'Montserrat Regular',
                  ),
                ),
              )),
          SizedBox(
            width: DeviceUtils.getScaledWidth(context, scale: 0.02),
          ),
        ],
      ));
}

// Pops up Dialog box
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
                  Navigator.pop(context);
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
                  Navigator.pop(context);
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
                  Navigator.pop(context);
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
