import 'dart:io';

import 'package:dot_safety/app/components/image-card.dart';
import 'package:dot_safety/app/controller/vehicle_controller.dart';
import 'package:dot_safety/app/ui/pages/vehicle/vehicle_file_uploads.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class DocumentView extends StatefulWidget {
  @override
  State<DocumentView> createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  bool loading = false;
  var _image;
  var imagePicker;
  var type;

  final VehicleController vehicleController = Get.put(VehicleController());
  var val = false;

  void getDocuments() async {
    var temp = await vehicleController
        .getUploadedDocument(vehicleController.currentVehicle['_id']);
    setState(() {
      val = temp;
    });
  }

  @override
  initState() {
    getDocuments();
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
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    ListTile(
                      dense: true,
                       title: Text(
                         'Vehicle Name',
                         style: TextStyle(
                             fontWeight: FontWeight.w400,
                             fontSize: 16,
                             fontFamily: 'Montserrat Regular',
                             color: AppColors.color10),
                       ),
                       subtitle: Text(
                         vehicleController.currentVehicle['vehicle_name'],
                         style: TextStyle(
                             fontWeight: FontWeight.w400,
                             fontSize: 16,
                             fontFamily: 'Montserrat Bold',
                             color: AppColors.color10),
                       ),
                     ),
                    ListTile(
                      dense: true,
                      title: Text(
                        'Vehicle Type',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat Regular',
                            color: AppColors.color10),
                      ),
                      subtitle: Text(
                        vehicleController.currentVehicle['vehicle_type'],
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.color10),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                        'Year',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat Regular',
                            color: AppColors.color10),
                      ),
                      subtitle: Text(
                        vehicleController.currentVehicle['vehicle_year'],
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.color10),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                        'Plate Number',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat Regular',
                            color: AppColors.color10),
                      ),
                      subtitle: Text(
                        vehicleController.currentVehicle['vehicle_plate_number'],
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.color10),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                        'Color',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat Regular',
                            color: AppColors.color10),
                      ),
                      subtitle: Text(
                        vehicleController.currentVehicle['vehicle_color'],
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.color10),
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                    ),
                    Text(
                      'Documents',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          fontFamily: 'Montserrat Bold',
                          color: AppColors.appPrimaryColor),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              var temp = vehicleController.edittedDocuments
                                  .firstWhere(
                                      (element) =>
                                          element['_id'] == 'Vehicle licence',
                                      orElse: () => null);
                              showBottom(context, "Vehicle licence", temp);
                            },
                            child: ImageCardAsset(
                              context,
                              "Vehicle licence",
                              'assets/images/img2.png',
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              var temp = vehicleController.edittedDocuments
                                  .firstWhere(
                                      (element) =>
                                          element['_id'] ==
                                          'Certificate of road worthiness',
                                      orElse: () => null);
                              showBottom(context,
                                  "Certificate of road worthiness", temp);
                            },
                            child: ImageCardAsset(
                              context,
                              "Certificate of road worthiness",
                              'assets/images/img2.png',
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              var temp = vehicleController.edittedDocuments
                                  .firstWhere(
                                      (element) =>
                                          element['_id'] ==
                                          'Proof of ownership',
                                      orElse: () => null);
                              showBottom(context, "Proof of ownership", temp);
                            },
                            child: ImageCardAsset(context, "Proof of ownership",
                                'assets/images/img2.png'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              var temp = vehicleController.edittedDocuments
                                  .firstWhere(
                                      (element) =>
                                          element['_id'] ==
                                          'Change of ownership',
                                      orElse: () => null);
                              showBottom(context, "Change of ownership", temp);
                            },
                            child: ImageCardAsset(
                              context,
                              "Change of ownership",
                              'assets/images/img2.png',
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              var temp = vehicleController.edittedDocuments
                                  .firstWhere(
                                      (element) =>
                                          element['_id'] ==
                                          'Certificate of car insurance',
                                      orElse: () => null);
                              showBottom(context,
                                  "Certificate of car insurance", temp);
                            },
                            child: ImageCardAsset(
                              context,
                              "Certificate of car insurance",
                              'assets/images/img2.png',
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              var temp = vehicleController.edittedDocuments
                                  .firstWhere(
                                      (element) =>
                                          element['_id'] ==
                                          'State certificate of road worthiness',
                                      orElse: () => null);
                              showBottom(context,
                                  "State certificate of road worthiness", temp);
                            },
                            child: ImageCardAsset(
                                context,
                                "State certificate of road worthiness",
                                'assets/images/img2.png'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              var temp = vehicleController.edittedDocuments
                                  .firstWhere(
                                      (element) =>
                                          element['_id'] == 'Driver’s License',
                                      orElse: () => null);
                              showBottom(context, "Driver’s License", temp);
                            },
                            child: ImageCardAsset(
                              context,
                              "Driver’s License",
                              'assets/images/img2.png',
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              var temp = vehicleController.edittedDocuments
                                  .firstWhere(
                                      (element) =>
                                          element['_id'] == 'Hackney Permit',
                                      orElse: () => null);
                              showBottom(context, "Hackney Permit", temp);
                            },
                            child: ImageCardAsset(
                              context,
                              "Hackney Permit",
                              'assets/images/img2.png',
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              var temp = vehicleController.edittedDocuments
                                  .firstWhere(
                                      (element) => element['_id'] == 'Others',
                                      orElse: () => null);
                              showBottom(context, "Others", temp);
                            },
                            child: ImageCardAsset(
                                context, "Others", 'assets/images/img2.png'),
                          ),
                        ),
                      ],
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

  void showBottom(context, documentType, element) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        ),
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
                padding: EdgeInsets.symmetric(
                    vertical: DeviceUtils.getScaledHeight(context, scale: 0.04),
                    horizontal:
                        DeviceUtils.getScaledWidth(context, scale: 0.03)),
                height: DeviceUtils.getScaledHeight(context, scale: 0.9),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.01),
                      ),
                      Text(
                        documentType,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appPrimaryColor),
                      ),
                      element != null
                          ? UploadBlock(context, element, vehicleController)
                          : Container(),
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.02),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: VehicleFileUpload(
                                      documentType: documentType)));
                        },
                        leading: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.secondaryColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: Icon(
                            Icons.add_to_photos,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        title: Text(
                          "Add Document",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Montserrat Bold',
                              color: AppColors.color10),
                        ),
                      )
                    ],
                  ),
                ));
          });
        });
  }
}

Future<void> _showMyDialog(context, document, vehicleController) async {
  print(document['document_id']);
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Confirm Document Delete',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'Montserrat Bold',
                    color: AppColors.color10),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: <Widget>[
          TextButton(
            child: Text(
              'CANCEL',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: 'Montserrat Bold',
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'DELETE',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: 'Montserrat Bold',
                  color: AppColors.color5),
            ),
            onPressed: () async {
              if (await vehicleController
                  .deleteDocument(document['document_id'])) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => DocumentView()),
                    ModalRoute.withName('/'));
                toast(vehicleController.message.value);
              } else {
                toast(vehicleController.message.value);

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}

StatelessWidget UploadBlock(context, document, vehicleController) {
  return Container(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.02),
        ),
        Container(
            height: DeviceUtils.getScaledHeight(context, scale: 0.23),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: document['images'].length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showMyDialog(
                        context, document['images'][index], vehicleController);
                  },
                  child: ImageCard(context, document['images'][index]['expire'],
                      "", document['images'][index]['image_path'], true),
                );
              },
            )),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.01),
        ),
      ],
    ),
  );
}
