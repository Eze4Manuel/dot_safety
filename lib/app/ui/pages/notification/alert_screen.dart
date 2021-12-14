import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';

class AlertScreen extends StatefulWidget {
  String alert;
  String time;
  String description;

  AlertScreen({required this.alert, required this.time, required this.description});

  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
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
                Strings.alertReport,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Montserrat Bold',
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
                color: AppColors.color2,
                width: DeviceUtils.getScaledWidth(context, scale: 1.0),
                height: DeviceUtils.getScaledHeight(context, scale: 1.0),
                padding: EdgeInsets.symmetric(
                    horizontal:
                        DeviceUtils.getScaledWidth(context, scale: 0.04),
                    vertical:
                        DeviceUtils.getScaledHeight(context, scale: 0.03)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: AppColors.whiteColor,
                      width: DeviceUtils.getScaledWidth(context, scale: 1.0),
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              DeviceUtils.getScaledWidth(context, scale: 0.04)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02),
                          ),
                          Text(
                            'Sender',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Montserrat Bold',
                                color: AppColors.appPrimaryColor),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.01),
                          ),
                          Text(
                            'Helen Chinweike',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.04),
                          ),
                          Text(
                            'Location',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Montserrat Bold',
                                color: AppColors.appPrimaryColor),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.01),
                          ),
                          Text(
                            'Ajah Lagos state',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.04),
                          ),
                          Text(
                            widget.time,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Montserrat Bold',
                                color: AppColors.appPrimaryColor),
                            textAlign: TextAlign.center
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.01),
                          ),
                          Text(
                            '8:20pm',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.04),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.alert,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.color5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.09),
                    ),
                  ],
                )),
          );
        },
        key: null,
      ),
    );
  }
}
