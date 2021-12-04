import 'package:dot_safety/app/ui/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatelessWidget {
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
                child: ResetPasswordViews(context, 'assets/images/logo.png')),
          );
        },
        key: null,
      ),
    );
  }
}

StatelessWidget ResetPasswordViews(context, String assetLink) {
  return SingleChildScrollView(
    child: Container(
      color: AppColors.whiteColor,
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.07)),
      height: DeviceUtils.getScaledHeight(context, scale: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Image.asset(
                assetLink,
                width: DeviceUtils.getScaledWidth(context, scale: 0.2),
                height: DeviceUtils.getScaledHeight(context, scale: 0.2),
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.01),
              ),
              Center(
                child: Text(
                  Strings.resetPassword,
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
                      fontFamily: 'Montserrat Regular',
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.06),
              ),
              TextField(
                  style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      color: AppColors.color12,
                    ),
                    hintText: "Create new password",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 32.0, color: AppColors.appPrimaryColor),
                        borderRadius: BorderRadius.circular(6.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 32.0),
                        borderRadius: BorderRadius.circular(6.0)),
                  )),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.04),
              ),
              TextField(
                  style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      color: AppColors.color12,
                    ),
                    hintText: "Confirm new password",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 32.0, color: AppColors.appPrimaryColor),
                        borderRadius: BorderRadius.circular(6.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 32.0),
                        borderRadius: BorderRadius.circular(6.0)),
                  )),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.appPrimaryColor),
                  child: Center(
                    child: Text(
                      Strings.resetPassword,
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
          ),
        ],
      ),
    ),
  );
}
