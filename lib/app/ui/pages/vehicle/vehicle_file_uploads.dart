import 'package:dot_safety/app/components/image-card.dart';
import 'package:dot_safety/app/controller/vehicle_controller.dart';
import 'package:dot_safety/app/ui/pages/vehicle/vehicle_document.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:get/get.dart';

class VehicleFileUpload extends StatefulWidget {
  @override
  State<VehicleFileUpload> createState() => _VehicleFileUploadState();
}

class _VehicleFileUploadState extends State<VehicleFileUpload> {
  final VehicleController vehicleController = Get.put(VehicleController());
  String dropdownValue = 'Select Document Type';

  @override
  Widget build(BuildContext context) {
    print(vehicleController.currentVehicle);

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
                child: SingleChildScrollView(
                  child: Container(
                      color: AppColors.color2,
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              DeviceUtils.getScaledWidth(context, scale: 0.07)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.04),
                          ),
                          Container(
                            width:
                                DeviceUtils.getScaledWidth(context, scale: 1),
                            height: DeviceUtils.getScaledWidth(context,
                                scale: 0.25),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // radius of 10
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
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.01),
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
                          DropdownButtonFormField<String>(
                            value: dropdownValue,
                            style:  TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.color10,
                                    fontFamily: 'Montserrat Regular'
                                ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                hintText: "Car, Bike, Bus",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 32.0),
                                    borderRadius:
                                    BorderRadius.circular(6.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 32.0),
                                    borderRadius:
                                    BorderRadius.circular(6.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select Vehicle Type';
                              }
                              return null;
                            },
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['Select Document Type', 'Vehicle licence', 'Certificate of road worthiness', 'Proof of ownership', 'Change of ownership', 'Certificate of car insurance', 'State certificate of road worthiness', 'Driver’s License', 'Hackney Permit']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,

                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          ListView.builder(
                              itemCount: 1,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return UploadBlock(context, "Driver’s License");
                              }),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                            ],
                          ),

                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.04),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VehicleDocument()));
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
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.03),
                          )
                        ],
                      )),
                )),
          );
        },
        key: null,
      ),
    );
  }
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
                  onTap: () {},
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
