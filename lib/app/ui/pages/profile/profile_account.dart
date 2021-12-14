import 'dart:ui';

import 'package:dot_safety/app/controller/login_controller.dart';
import 'package:dot_safety/app/ui/pages/login.dart';
import 'package:dot_safety/app/ui/pages/profile/settings.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  String? first_name;
  String? last_name;

  final LoginController loginController = Get.put(LoginController());


  void getShared() async {
    var a = await SharedPrefs.readSingleString('first_name');
    var b = await SharedPrefs.readSingleString('last_name');
    setState(() {
      first_name = a;
      last_name = b;
    });
  }

  @override
  void initState(){
    super.initState();
    getShared();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
              width: DeviceUtils.getScaledWidth(context, scale: 1),
              color: AppColors.whiteColor,
              height: DeviceUtils.getScaledHeight(context, scale: 0.71),
              child: Container(
                  color: AppColors.color2,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ImageFiltered(
                              imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/human-back.png"),
                                          fit: BoxFit.cover))),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                decoration:
                                    BoxDecoration(color: AppColors.color2)),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.2),
                          ),
                          Expanded(
                            child: Container(
                              width: DeviceUtils.getScaledWidth(context,
                                  scale: 0.8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50),
                                  ), // radius of 10
                                  color:
                                      AppColors.whiteColor // green as background color
                                  ),
                              child: Stack(
                                overflow: Overflow.visible,
                                children: [
                                  Positioned(
                                    top: DeviceUtils.getScaledHeight(context,scale: -0.05),
                                    left: DeviceUtils.getScaledWidth(context,scale: 0.31),
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100.0),
                                        child: Image.asset(
                                          'assets/images/human.png',
                                          width: 80.0,
                                          height: 80.0,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: DeviceUtils.getScaledHeight(context,
                                            scale: 0.092),
                                      ),
                                      Text(
                                        "${first_name} ${last_name}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Montserrat Bold',
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: DeviceUtils.getScaledHeight(context,
                                            scale: 0.01),
                                      ),
                                      // Text(
                                      //   "Lagos state, Nigeria",
                                      //   style: TextStyle(
                                      //     fontWeight: FontWeight.w400,
                                      //     fontFamily: 'Montserrat Regular',
                                      //     fontSize: 14,
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: DeviceUtils.getScaledHeight(context,
                                            scale: 0.01),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          RaisedButton(
                                            onPressed: () {},
                                            color: AppColors.whiteColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Text("Inbox",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Montserrat Regular',
                                                fontSize: 14,
                                              ),),
                                          ),
                                          RaisedButton(
                                            onPressed: () {},
                                            color: AppColors.appPrimaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Text("Points",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Montserrat Regular',
                                                fontSize: 14,
                                                color: AppColors.whiteColor
                                              ),),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: DeviceUtils.getScaledHeight(context,
                                            scale: 0.02),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: DeviceUtils.getScaledWidth(
                                                context,
                                                scale: 0.05),
                                          ),
                                          Icon(
                                            Icons.cloud_upload_rounded,
                                            color: AppColors.appPrimaryColor,
                                          ),
                                          SizedBox(
                                            width: DeviceUtils.getScaledWidth(
                                                context,
                                                scale: 0.04),
                                          ),
                                          Text('Upload an Image',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Montserrat Regular',
                                              fontSize: 14,
                                            ),),
                                        ],
                                      ),
                                      SizedBox(
                                        height: DeviceUtils.getScaledHeight(context,
                                            scale: 0.02),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: DeviceUtils.getScaledWidth(
                                                context,
                                                scale: 0.05),
                                          ),
                                          Icon(
                                            Icons.payment,
                                            color: AppColors.appPrimaryColor,
                                          ),
                                          SizedBox(
                                            width: DeviceUtils.getScaledWidth(
                                                context,
                                                scale: 0.04),
                                          ),
                                          Text('Payment',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Montserrat Regular',
                                              fontSize: 14,
                                            ),),
                                        ],
                                      ),
                                      SizedBox(
                                        height: DeviceUtils.getScaledHeight(context,
                                            scale: 0.02),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsView()));
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: DeviceUtils.getScaledWidth(
                                                  context,
                                                  scale: 0.05),
                                            ),
                                            Icon(
                                              Icons.settings,
                                              color: AppColors.appPrimaryColor,
                                            ),
                                            SizedBox(
                                              width: DeviceUtils.getScaledWidth(
                                                  context,
                                                  scale: 0.04),
                                            ),
                                            Text('Setting',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Montserrat Regular',
                                                fontSize: 14,
                                              ),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: DeviceUtils.getScaledHeight(context,
                                            scale: 0.02),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          if(await loginController.logout())
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: DeviceUtils.getScaledWidth(
                                                  context,
                                                  scale: 0.05),
                                            ),
                                            Icon(
                                              Icons.logout,
                                              color: AppColors.appPrimaryColor,
                                            ),
                                            SizedBox(
                                              width: DeviceUtils.getScaledWidth(
                                                  context,
                                                  scale: 0.04),
                                            ),
                                            Text('Logout',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Montserrat Regular',
                                                fontSize: 14,
                                                color: AppColors.color5
                                              ),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: DeviceUtils.getScaledHeight(context,
                                            scale: 0.01),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ))),
        ),
      ],
    );
  }
}
