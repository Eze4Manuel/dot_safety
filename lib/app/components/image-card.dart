import 'package:cached_network_image/cached_network_image.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

StatelessWidget ImageCard(context, cardTitle, cardSubTitle, asset, isNew) {
  return  Container(
    width: DeviceUtils.getScaledWidth(context, scale: 0.29),
    height: DeviceUtils.getScaledHeight(context, scale: 0.11),
    margin: EdgeInsets.only(
        right: DeviceUtils.getScaledWidth(context, scale: 0.03)),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: AppColors.whiteColor),

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
          height: 134,
            width: DeviceUtils.getScaledWidth(context, scale: 1),

            child: CachedNetworkImage(
              imageUrl: '${Strings.domain}$asset',
              imageBuilder:
                  (context, imageProvider) =>
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover),
                    ),
                  ),
              placeholder: (context, url) =>
                  Center(
                    child: Container(
                      child: CircularProgressIndicator(
                        backgroundColor: AppColors.appPrimaryColor,
                        color: AppColors.secondaryColor,
                        strokeWidth: 3,
                      ),
                    ),
                  ),
              errorWidget:
                  (context, url, error) =>
                  Container(),
            )
        ),
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
                cardTitle.length == 0 ? 'No date' : cardTitle ,
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                )),
              ),

            ],
          ),
        ),
      ],
    ),
  );
}



StatelessWidget ImageCardAdd(context, cardTitle, asset, isNew) {
  return  Container(
    width: DeviceUtils.getScaledWidth(context, scale: 0.29),
    margin: EdgeInsets.only(
        right: DeviceUtils.getScaledWidth(context, scale: 0.03)),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: AppColors.whiteColor),
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
            height: 134,
            width: DeviceUtils.getScaledWidth(context, scale: 1),
            child: Image.asset(asset, fit:BoxFit.cover)
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          width: DeviceUtils.getScaledWidth(context, scale: 1),
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

            ],
          ),
        ),
      ],
    ),
  );
}
