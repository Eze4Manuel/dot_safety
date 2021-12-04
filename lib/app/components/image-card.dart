import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

StatelessWidget ImageCard(context, cardTitle, cardSubTitle, asset, isNew) {
  return Container(
    width: DeviceUtils.getScaledWidth(context, scale: 0.29),
    height: DeviceUtils.getScaledHeight(context, scale: 0.11),
    margin: EdgeInsets.only(
        right: DeviceUtils.getScaledWidth(context, scale: 0.03)),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: AppColors.color2,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Image.asset(
              asset,
              width: DeviceUtils.getScaledWidth(context, scale: 0.29),
              height: DeviceUtils.getScaledHeight(context, scale: 0.14),
              fit: BoxFit.cover,
            )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: new BoxDecoration(
            color: AppColors.whiteColor,
            border: Border(
              top: BorderSide(
                //
                color: AppColors.color10,
                width: 0.1,
              ),
            ),
          ),
          child: Column(
            children: [
              Text(
                cardTitle,
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    )),
              ),
              Text(
                cardSubTitle,
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    )),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
