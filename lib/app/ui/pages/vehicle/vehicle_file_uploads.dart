import 'dart:io';

import 'package:dot_safety/app/components/image-card.dart';
import 'package:dot_safety/app/controller/vehicle_controller.dart';
import 'package:dot_safety/app/ui/pages/vehicle/vehicle_document.dart';
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
  @override
  State<VehicleFileUpload> createState() => _VehicleFileUploadState();
}

class _VehicleFileUploadState extends State<VehicleFileUpload> {
  bool loading = false;
  var _image;
  var imagePicker;
  var type;

  final VehicleController vehicleController = Get.put(VehicleController());
  String documentType = 'Select Document Type';
  late String expiryDate = '';

  TextEditingController dateCtl = TextEditingController();

  // getting image stored
  getImage(type) async {
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
        documentType,
        File(image.path))) {
      Navigator.pop(context);
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
    print(vehicleController.documents);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 01,
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
              height: DeviceUtils.getScaledHeight(context, scale: 1),

              color: AppColors.color2,
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledWidth(context,
                      scale: 0.07)),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context,
                          scale: 0.04),
                    ),
                    Text(
                      'Expiry date',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          fontFamily: 'Montserrat Regular',
                          color: AppColors.color10),
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
                        FocusScope.of(context)
                            .requestFocus(new FocusNode());
                        date = (await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100)))!;
                        expiryDate =
                            DateFormat('yyyy-MM-dd').format(date);
                        dateCtl.text =
                            DateFormat('yyyy-MM-dd').format(date);
                      },
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context,
                          scale: 0.02),
                    ),
                    Text(
                      'Document type',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          fontFamily: 'Montserrat Regular',
                          color: AppColors.color10),
                    ),
                    DropdownButtonFormField<String>(
                      value: documentType,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.color10,
                          fontFamily: 'Montserrat Regular'),
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
                        if (value == null ||
                            value == 'Select Document Type') {
                          return 'Select valid Document Type';
                        }
                        return null;
                      },
                      onChanged: (String? newValue) {
                        if (newValue != 'Select Document Type') {
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              isScrollControlled: true,
                              isDismissible: true,
                              builder: (BuildContext context) {
                                return BottomImageSelect(
                                    context, getImage);
                              });
                          setState(() {
                            documentType = newValue!;
                          });
                        }
                      },
                      items: <String>[
                        'Select Document Type',
                        'Vehicle licence',
                        'Certificate of road worthiness',
                        'Proof of ownership',
                        'Change of ownership',
                        'Certificate of car insurance',
                        'State certificate of road worthiness',
                        'Driver’s License',
                        'Hackney Permit'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context,
                          scale: 0.02),
                    ),
                    if (vehicleController.documents.length == 0)
                      Container(
                        width: DeviceUtils.getScaledWidth(context,
                            scale: 1),
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
                              height: DeviceUtils.getScaledHeight(
                                  context,
                                  scale: 0.01),
                            ),
                            Text(
                              'No Document Uploaded',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat Regular',
                                  color: AppColors.appPrimaryColor),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        height: DeviceUtils.getScaledHeight(context, scale: 0.6),
                        child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            primary: false,
                            itemCount:
                                vehicleController.documents.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return UploadBlock(context,
                                  vehicleController.documents[index]);
                            }),
                      ),

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
                return ImageCard(context, element['expiry_date'],
                    "venxs3345df", element['images'][index], true);
              }),
        ),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.01),
        ),
      ],
    ),
  );
}
