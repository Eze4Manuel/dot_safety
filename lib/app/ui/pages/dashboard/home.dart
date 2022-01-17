import 'dart:convert';
import 'package:dot_safety/app/controller/dashboard_controller.dart';
import 'package:dot_safety/app/controller/vehicle_controller.dart';
import 'package:dot_safety/app/ui/pages/dashboard/broadcast_page.dart';
import 'package:dot_safety/app/ui/pages/dashboard/selectLawEnforcement.dart';
import 'package:dot_safety/app/ui/pages/dashboard/speech_recognition.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedIndex;
  String? firstName = '';
  String profileImage = '';

  final _channelName = TextEditingController();
  String check = '';

  List<String> litems = ["Traffic Offence", "Accident", "Kidnap"];
  List<String> imageList = [
    "assets/images/img1.png", "assets/images/img2.png", "assets/images/img3.png",
  "assets/images/img4.png", "assets/images/img5.png", "assets/images/img6.png",
  "assets/images/img7.png", "assets/images/img8.png","assets/images/img1.png", "assets/images/img2.png", "assets/images/img3.png",
    "assets/images/img4.png", "assets/images/img5.png", "assets/images/img6.png",
    "assets/images/img7.png", "assets/images/img8.png"];


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



  @override
  void initState(){
    super.initState();
    getShared();
    getVehicleData();
    dashboardController.getAgencyList();
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
                                      if(dashboardController.lawEnforcementAgencies.length > 0){
                                        Scaffold.of(context).openDrawer();
                                      }else{
                                        toast(dashboardController.message.value);
                                      }
                                    },
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: CircleAvatar(
                                        radius: 20.0,
                                        backgroundColor: AppColors.color11,
                                        child: Image.asset('assets/images/logo.png')
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
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => SpeechScreen()));
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
                                      scale: 0.06)),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Text(
                                      'Live',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: 'Montserrat Bold',
                                          color: AppColors.color8),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
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
                        itemCount: imageList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Container(
                                color: AppColors.color3,
                                margin: const EdgeInsets.all(3),
                                child:Image.asset(imageList[index],
                                fit: BoxFit.cover,
                                width: DeviceUtils.getScaledWidth(context, scale: 1),
                                height: DeviceUtils.getScaledHeight(context, scale: 1),)
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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.color3),
                  borderRadius: BorderRadius.circular(4), // radius of 10
                ),
                child: Text(
                  'State',
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



