import 'package:dot_safety/app/ui/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerify extends StatelessWidget {
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
              child: EmailVerifyViews(context, 'assets/images/email_sent.png'));
        },
        key: null,
      ),
    );
  }
}

StatelessWidget EmailVerifyViews(
    context, String assetLink, ) {
  return Container(
      color: AppColors.whiteColor,
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.07)),
      height: DeviceUtils.getScaledHeight(context, scale: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                height: DeviceUtils.getScaledHeight(context, scale: 0.04),
              ),
              Text(
                'Hi Helen, ${Strings.verifyMailText}',
                style:
                    TextStyle(
                        fontFamily: 'Montserrat Regular',
                        fontWeight: FontWeight.w400, fontSize: 14),
                textAlign: TextAlign.center,
              ),
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
                  child: Center(
                    child: Text(
                      Strings.verifyEmail,
                      style:
                          TextStyle(fontFamily: 'Montserrat Regular',
                              fontWeight: FontWeight.w400, fontSize: 16,
                              color: AppColors.whiteColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              Text(
                Strings.resendMail,
                style:
                    TextStyle(fontFamily: 'Montserrat Regular',
                      fontWeight: FontWeight.w400, fontSize: 14,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ));
}
