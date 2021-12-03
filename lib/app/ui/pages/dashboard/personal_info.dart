import 'package:dot_safety/app/ui/pages/dashboard/comments.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Icon(Icons.arrow_back),
              ),
            ),
            backgroundColor: AppColors.secondaryColor,
            flexibleSpace: Align(
              alignment: Alignment.center,
              child: Text(
                Strings.personalInfo,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat Bold',
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )),
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
                child: PersonalInfoViews(context)),
          );
        },
        key: null,
      ),
    );
  }
}

StatelessWidget PersonalInfoViews(context) {
  return SingleChildScrollView(
    child: Container(
        color: AppColors.whiteColor,
        padding: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledWidth(context, scale: 0.07)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                ),
                TextField(
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Helen Chinkwieke",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)))),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                ),
                TextField(
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Male",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)))),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                ),
                TextField(
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Port Harcourt Nigeria",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)))),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                ),
                TextField(
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Offence",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)))),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                ),
                TextField(
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Fee",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)))),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                ),
                TextField(
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Card Type",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)))),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                ),
                TextField(
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Card Number",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)))),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "Expiry Date",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(6.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 32.0),
                                  borderRadius: BorderRadius.circular(6.0)))),
                    ),
                    SizedBox(
                      width: DeviceUtils.getScaledWidth(context, scale: 0.02),
                    ),
                    Expanded(
                      child: TextField(
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "CCV",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(6.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 32.0),
                                  borderRadius: BorderRadius.circular(6.0)))),
                    )
                  ],
                ),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Strings.scanOfficerQR,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: 'Montserrat Regular',
                        color: AppColors.appPrimaryColor),
                  ),
                ),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: DeviceUtils.getScaledWidth(context, scale: 0.7),
                    height: DeviceUtils.getScaledHeight(context, scale: 0.42),
                    child: Image.asset('assets/images/qr.png'),
                  ),
                )
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) => AlertDialog(
                              title: Text(
                                Strings.success,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: 'Montserrat Bold',
                                    color: AppColors.appPrimaryColor),
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                'Nisi qui enim laborum esse proident commodo isi qui enim laborum esse proident',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat Regular',
                                    color: AppColors.color10),
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Comments()));
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.appPrimaryColor),
                                    child: Center(
                                      child: Text(
                                        Strings.ok,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            fontFamily: 'Montserrat Regular',
                                            color: AppColors.whiteColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.appPrimaryColor),
                    child: Center(
                      child: Text(
                        Strings.makePayment,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat Regular',
                            color: AppColors.whiteColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                ),
              ],
            )
          ],
        )),
  );
}
