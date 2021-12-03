
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

StatelessWidget CardDescriptionDetail(context, cardTitle, cardSubTitle, asset, isNew) {
  return Container(
    width: DeviceUtils.getScaledWidth(context, scale: 1),
    margin: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledWidth(context, scale: 0.03)),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: AppColors.color2,
          spreadRadius: 3,
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          width: DeviceUtils.getScaledWidth(context, scale: 1),
          decoration: new BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardTitle,
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: AppColors.appPrimaryColor
                    )),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
            ],
          ),
        ),
        Container(
            child: Image.asset(
              asset,
              width: DeviceUtils.getScaledWidth(context, scale: 1),
              height: DeviceUtils.getScaledHeight(context, scale: 0.34),
              fit: BoxFit.cover,
            )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          width: DeviceUtils.getScaledWidth(context, scale: 1),
          decoration: new BoxDecoration(
            color: AppColors.whiteColor,
            border: Border(
              top: BorderSide(
                color: AppColors.color10,
                width: 0.1,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              Text(
                Strings.descriptionOffOffence,
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.appPrimaryColor
                    )),
              ),
              Text(
                cardSubTitle,
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    )),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.expectedFine,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: AppColors.appPrimaryColor
                        )),
                  ),
                  Text(
                    'N2000',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.yourPoints,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: AppColors.appPrimaryColor
                        )),
                  ),
                  Text(
                    '5',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
