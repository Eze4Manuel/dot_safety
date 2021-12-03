import 'package:dot_safety/app/ui/pages/dashboard/dashboard.dart';
import 'package:dot_safety/app/ui/pages/forgot_password.dart';
import 'package:dot_safety/app/ui/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
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
                child: LoginViews(context, 'assets/images/logo.png',
                    Strings.loginToDotSafety)),
          );
        },
        key: null,
      ),
    );
  }
}

StatelessWidget LoginViews(context, String assetLink, String title) {
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
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: 'Montserrat Bold',
                      color: AppColors.appPrimaryColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            children: [
              TextField(
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: AppColors.color12,
                    ),
                    hintText: "hchinwe789@design.com",
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
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      color: AppColors.color12,
                    ),
                    hintText: "Password",
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
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.keepMe,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        fontFamily: 'Montserrat Regular'),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    child: Text(
                      Strings.forgottenPassword,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          fontFamily: 'Montserrat Regular'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.03),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.appPrimaryColor),
                  child: Center(
                    child: Text(
                      Strings.login,
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
                height: DeviceUtils.getScaledHeight(context, scale: 0.06),
              ),
              Text(
                Strings.orLoginWith,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    fontFamily: 'Montserrat Regular'),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/facebook.png',
                    width: DeviceUtils.getScaledWidth(context, scale: 0.06),
                    height: DeviceUtils.getScaledHeight(context, scale: 0.06),
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: DeviceUtils.getScaledWidth(context, scale: 0.09),
                  ),
                  Image.asset(
                    'assets/images/google.png',
                    width: DeviceUtils.getScaledWidth(context, scale: 0.06),
                    height: DeviceUtils.getScaledHeight(context, scale: 0.06),
                    fit: BoxFit.contain,
                  ),
                ],
              )
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
                      MaterialPageRoute(builder: (context) => Signup()));
                },
                child: Text.rich(TextSpan(
                    text: Strings.donthaveAccount,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        fontFamily: 'Montserrat Regular'),
                    children: <InlineSpan>[
                      TextSpan(
                        text: Strings.signupText,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            fontFamily: 'Montserrat Regular',
                            color: AppColors.appPrimaryColor),
                      )
                    ])),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
