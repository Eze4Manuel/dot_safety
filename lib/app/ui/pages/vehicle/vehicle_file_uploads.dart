import 'package:dot_safety/app/components/image-card.dart';
import 'package:dot_safety/app/ui/pages/vehicle/vehicle_document.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicleFileUpload extends StatelessWidget {
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
                Strings.fileUpload,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Montserrat Bold',
                  color: AppColors.whiteColor,
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
                width: DeviceUtils.getScaledWidth(context, scale: 1),
                color: AppColors.whiteColor,
                child: VehicleDocumentViews(context)),
          );
        },
        key: null,
      ),
    );
  }
}

StatelessWidget VehicleDocumentViews(context) {
  return SingleChildScrollView(
    child: Container(
        color: AppColors.color2,
        padding: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledWidth(context, scale: 0.07)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.04),
            ),
            Container(
              width: DeviceUtils.getScaledWidth(context, scale: 1),
              height: DeviceUtils.getScaledWidth(context, scale: 0.25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // radius of 10
                color: AppColors.whiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    color: AppColors.appPrimaryColor,
                  ),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                  ),
                  Text(
                    Strings.uploadYourDocument,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: 'Montserrat Regular',
                        color: AppColors.appPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UploadBlock(context, "Driver’s License"),
                UploadBlock(context, "Vehicle License"),
                UploadBlock(context, "Certificate of road worthiness"),
                UploadBlock(context, "Certificate of car insurance"),
                UploadBlock(context, "Proof of ownership"),
                UploadBlock(context, "Change of ownership"),
                UploadBlock(context, "State certificate of road worthiness"),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VehicleDocument()));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.appPrimaryColor),
                    child: Center(
                      child: Text(
                        Strings.done,
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
                  height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                ),
              ],
            )
          ],
        )),
  );
}

StatelessWidget UploadBlock(context, title) {
  return Container(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.04),
        ),
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              fontFamily: 'Montserrat Regular',
              color: AppColors.appPrimaryColor),
        ),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.02),
        ),
        Container(
            height: DeviceUtils.getScaledHeight(context, scale: 0.23),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ImageCard(context, "Lexus", "venxs3345df",
                    'assets/images/img5.png', true),
                ImageCard(context, "Mercedes", "venxs3345df",
                    'assets/images/img6.png', true),
                GestureDetector(
                  onTap: () {

                  },
                  child: ImageCard(context, "Add Vehicle", "page or file",
                      'assets/images/addicon.png', false),
                )
              ],
            )),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.03),
        ),
      ],
    ),
  );
}
