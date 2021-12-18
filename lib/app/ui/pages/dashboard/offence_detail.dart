import 'package:dot_safety/app/components/card_description_detail.dart';
import 'package:dot_safety/app/ui/pages/dashboard/personal_info.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';

class OffenceDetail extends StatelessWidget {
  var offense;
  var offenseId;

  OffenceDetail({this.offense, this.offenseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // radius of 10
              color: AppColors.whiteColor,
            ),
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back,
              color: AppColors.appPrimaryColor,
            ),
          ),
        ),
      ),
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
                child: Container(
              color: AppColors.color2,
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.05)),
              height: DeviceUtils.getScaledHeight(context, scale: 1),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.0),
                    ),
                    CardDescriptionDetailReviews(
                        context, offense),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.2),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => PersonalInfo(offense: offense, offenseId: offenseId)));
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.appPrimaryColor),
                        child: Center(
                          child: Text(
                            Strings.proceed,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.whiteColor,
                              fontFamily: 'Montserrat Regular',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                    ),
                  ],
                ),
              ),
            )),
          );
        },
        key: null,
      ),
    );
  }
}
