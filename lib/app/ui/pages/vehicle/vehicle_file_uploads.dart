import 'dart:io';

import 'package:dot_safety/app/components/image-card.dart';
import 'package:dot_safety/app/controller/vehicle_controller.dart';
import 'package:dot_safety/app/ui/pages/vehicle/document_view.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:dot_safety/app/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

enum ImageSourceType { gallery, camera }

class VehicleFileUpload extends StatefulWidget {
  String documentType;

  VehicleFileUpload({required this.documentType});

  @override
  State<VehicleFileUpload> createState() => _VehicleFileUploadState();
}

class _VehicleFileUploadState extends State<VehicleFileUpload> {
  bool loading = false;
  var _image;
  var imagePicker;
  var type;

  final VehicleController vehicleController = Get.put(VehicleController());
  late String expiryDate = '';

  TextEditingController dateCtl = TextEditingController();

  // getting image stored
  getImage(type) async {
    Navigator.pop(context);
    var source = type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    XFile image = await imagePicker.pickImage(
        source: source,
        imageQuality: 100,
        preferredCameraDevice: CameraDevice.front);

    // setting the loading screen
    setState(() {
      loading = true;
    });

    if (await vehicleController.asyncDocumentUpload(
        vehicleController.currentVehicle['_id'],
        expiryDate,
        widget.documentType,
        File(image.path))) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => DocumentView()),
          ModalRoute.withName(
              '/') // Replace this with your root screen's route name (usually '/')
          );
      toast(vehicleController.message.value);
      setState(() {
        _image = File(image.path);
        loading = false;
      });
    } else {
      toast(vehicleController.message.value);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  initState() {
    imagePicker = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveSafeArea(
        builder: (context, size) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              height: DeviceUtils.getScaledHeight(context, scale: 1),
              color: AppColors.color2,
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.04)),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.05),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.05),
                    ),
                    Text(
                     "Upload Vehicle Document",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Montserrat Bold',
                        color: AppColors.appPrimaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                    ),
                    Text(
                      'Expiry date',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontFamily: 'Montserrat Regular',
                          color: AppColors.color10),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                    ),
                    TextFormField(
                      controller: dateCtl,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          fontFamily: 'Montserrat Regular',
                          color: AppColors.color10),
                      onSaved: (value) {
                        print(value);
                      },
                      decoration: InputDecorationNoPrefixValues(
                          hintText: "Document Expiry Date"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select document Expiry date';
                        }
                      },
                      onTap: () async {
                        DateTime date = DateTime(1900);
                        FocusScope.of(context).requestFocus(new FocusNode());
                        date = (await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100)))!;
                        expiryDate = DateFormat('yyyy-MM-dd').format(date);
                        dateCtl.text = DateFormat('yyyy-MM-dd').format(date);

                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            isScrollControlled: true,
                            isDismissible: true,
                            builder: (BuildContext context) {
                              return BottomImageSelect(context, getImage);
                            });
                      },
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),

                    // Container(
                    //   height: DeviceUtils.getScaledHeight(context, scale: 0.6),
                    //   child: ListView.builder(
                    //       physics: AlwaysScrollableScrollPhysics(),
                    //       primary: false,
                    //       itemCount:
                    //           vehicleController.documents.length,
                    //       scrollDirection: Axis.vertical,
                    //       itemBuilder: (context, index) {
                    //         return UploadBlock(context,
                    //             vehicleController.documents[index]);
                    //       }),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
        key: null,
      ),
    );
  }

  Wrap BottomImageSelect(context, getImage) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Container(
          width: DeviceUtils.getScaledWidth(context, scale: 1),
          decoration: new BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(15.0),
                  topRight: const Radius.circular(15.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              Text(
                'Select Image Source',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Montserrat Bold',
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.04),
              ),
              GestureDetector(
                onTap: () {
                  getImage(ImageSourceType.camera);
                },
                child: Container(
                  width: DeviceUtils.getScaledWidth(context, scale: 1),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      'Camera',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat Bold',
                          fontSize: 14,
                          color: AppColors.color8),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              GestureDetector(
                onTap: () {
                  getImage(ImageSourceType.gallery);
                },
                child: Container(
                  width: DeviceUtils.getScaledWidth(context, scale: 1),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      'Gallery',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat Bold',
                          fontSize: 14,
                          color: AppColors.color8),
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
      ],
    );
  }
}

StatelessWidget UploadBlock(context, element) {
  return Container(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.04),
        ),
        Text(
          element['document_type'],
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              fontFamily: 'Montserrat Regular',
              color: AppColors.appPrimaryColor),
        ),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.01),
        ),
        Container(
          height: DeviceUtils.getScaledHeight(context, scale: 0.23),
          width: DeviceUtils.getScaledWidth(context, scale: 1),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: element['images'].length,
              itemBuilder: (context, index) {
                return ImageCard(context, element['expiry_date'], "venxs3345df",
                    element['images'][index], true);
              }),
        ),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.01),
        ),
      ],
    ),
  );
}
