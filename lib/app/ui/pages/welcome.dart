import 'package:dot_safety/app/ui/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: ResponsiveSafeArea(
        builder: (context, size) {
          return Container(
              height: DeviceUtils.getScaledHeight(context, scale: 1),
              width: DeviceUtils.getScaledWidth(context, scale: 1),
              color: AppColors.whiteColor,
              child: WelcomeViews(context, 'assets/images/logo.png',
                  Strings.welcomeToDotSafety, Strings.welcomeToDotSafetyText));
        },
        key: null,
      ),
    );
  }
}

StatelessWidget WelcomeViews(
    context, String assetLink, String title, String subText) {
  return Container(
      color: AppColors.whiteColor,
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.03)),
      height: DeviceUtils.getScaledHeight(context, scale: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Image.asset(
                assetLink,
                width: DeviceUtils.getScaledWidth(context, scale: 0.4),
                height: DeviceUtils.getScaledHeight(context, scale: 0.4),
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.01),
              ),
              Center(
                child: Text(
                  title,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: AppColors.appPrimaryColor)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              Text(
                subText,
                style: GoogleFonts.montserrat(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login())
                  );
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.appPrimaryColor),
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  child: Center(
                    child: Text(
                      Strings.getStarted,
                      style: GoogleFonts.montserrat(
                          textStyle:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16,
                              color: AppColors.whiteColor)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              Text(
                Strings.learnMore,
                style: GoogleFonts.montserrat(
                    textStyle:
                    TextStyle(fontWeight: FontWeight.w400, fontSize: 13,
                    )),
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ));
}
