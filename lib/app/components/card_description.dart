import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

StatelessWidget CardDescriptionReviews(context, card) {

  return Container(
    width: DeviceUtils.getScaledWidth(context, scale: 1),
    margin: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledWidth(context, scale: 0.03)),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: AppColors.color2,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
            child: Image.asset(
          'assets/images/img6.png',
          width: DeviceUtils.getScaledWidth(context, scale: 1),
          height: DeviceUtils.getScaledHeight(context, scale: 0.24),
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
              Text(
                'Description',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    fontFamily: 'Montserrat bold',
                    color: AppColors.appPrimaryColor),
              ),
              Text(
                card['title'],
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                )),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fine',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: 'Montserrat bold',
                        color: AppColors.appPrimaryColor),
                  ),
                  Text(
                    card['fine'].toString(),
                    style:  TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      fontFamily: 'Montserrat bold',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.01),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Points',
                    style:  TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                        fontFamily: 'Montserrat bold',

                        color: AppColors.appPrimaryColor),
                  ),
                  Text(
                    card['points'].toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      fontFamily: 'Montserrat bold',
                    ),
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

StatelessWidget CardDescription(
    context, cardTitle, cardSubTitle, asset, isNew) {
  return Container(
    width: DeviceUtils.getScaledWidth(context, scale: 1),
    margin: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledWidth(context, scale: 0.03)),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: AppColors.color2,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
            child: Image.asset(
          asset,
          width: DeviceUtils.getScaledWidth(context, scale: 1),
          height: DeviceUtils.getScaledHeight(context, scale: 0.25),
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
              Text(
                cardTitle,
                  style:
                  TextStyle(
                      color: AppColors.appPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Montserrat Bold'
                  ),
              ),
              Text(
                'Description',
                  style:
                  TextStyle(
                      color: AppColors.color10,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      fontFamily: 'Montserrat Bold'
                  ),
              ),
              Text(
                cardSubTitle,
                style:
                TextStyle(
                    color: AppColors.color10,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    fontFamily: 'Montserrat Regular'
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fine',
                    style:
                    TextStyle(
                        color: AppColors.color10,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'Montserrat Bold'
                    ),
                  ),
                  Text(
                    'N2000',
                    style:
                    TextStyle(
                        color: AppColors.color10,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        fontFamily: 'Montserrat Bold'
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.01),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Points',
                    style:
                    TextStyle(
                        color: AppColors.color10,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'Montserrat Bold'
                    ),
                  ),
                  Text(
                    '5',
                    style:
                    TextStyle(
                        color: AppColors.color10,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        fontFamily: 'Montserrat Bold'
                    ),
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
