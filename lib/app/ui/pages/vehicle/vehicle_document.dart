import 'package:dot_safety/app/ui/pages/vehicle/vehicle_file_uploads.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicleDocument extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.secondaryColor,
            flexibleSpace: Align(
              alignment: Alignment.center,
              child: Text(
                Strings.vehicleDocument,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.whiteColor,
                    fontFamily: 'Montserrat Bold'),
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
                    Strings.uploadVehicleDocument,
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
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                ),
                Text(
                  'Vehicle Type',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Montserrat Regular',
                  ),
                ),
                TextField(
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    )),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Car, Bike, Bus",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)))),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                ),
                Text(
                  'Vehicle Model',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Montserrat Regular',
                  ),
                ),
                TextField(
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    )),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Camary, CRV, Acer Macer",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)))),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                ),
                Text(
                  'Vehicle Year',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Montserrat Regular',
                  ),
                ),
                TextField(
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    )),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "2021, 2010",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)))),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                ),
                Text(
                  'Plate Number',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Montserrat Regular',
                  ),
                ),
                TextField(
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    )),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "ABJ29IL",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)))),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                ),
                Text(
                  'Vehicle Color',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Montserrat Regular',
                  ),
                ),
                TextField(
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    )),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Blue, Black, Silver",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(6.0)))),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VehicleFileUpload()));
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
