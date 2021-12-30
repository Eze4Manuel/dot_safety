import 'package:dot_safety/app/controller/vehicle_controller.dart';
import 'package:dot_safety/app/ui/pages/vehicle/document_list.dart';
import 'package:dot_safety/app/ui/pages/vehicle/vehicle_file_uploads.dart';
import 'package:dot_safety/app/ui/pages/vehicle/vehicle_file_uploads_update.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditVehicle extends StatefulWidget {
  var vehicle;

  EditVehicle({this.vehicle});

  @override
  State<EditVehicle> createState() => _EditVehicleState();
}

class _EditVehicleState extends State<EditVehicle> {
  final _formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  final RoundedLoadingButtonController _btnControllerUpdate =
  RoundedLoadingButtonController();

  final VehicleController vehicleController = Get.put(VehicleController());

  String dropdownValue = 'Select Type';

  late String vehicle_type = 'Select Type';
  late String vehicle_name;
  late String vehicle_year;
  late String vehicle_plate_number;
  late String vehicle_color;

  bool editted = false;

  @override
  void initState() {
    setState(() {
      vehicle_type = widget.vehicle['vehicle_type'];
      vehicle_name = widget.vehicle['vehicle_name'];
      vehicle_year = widget.vehicle['vehicle_year'];
      vehicle_plate_number = widget.vehicle['vehicle_plate_number'];
      vehicle_color = widget.vehicle['vehicle_color'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: AppColors.secondaryColor,
            flexibleSpace: Align(
              alignment: Alignment.center,
              child: Text(
                'Edit Vehicle',
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
                child: SingleChildScrollView(
                  child: Container(
                      color: AppColors.color2,
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              DeviceUtils.getScaledWidth(context, scale: 0.04)),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.04),
                                ),
                                Text(
                                  'Vehicle Type',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Montserrat Regular',
                                  ),
                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.01),
                                ),
                                DropdownButtonFormField<String>(
                                  value: vehicle_type,
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: AppColors.color10)),
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
                                      editted = true;
                                      vehicle_type = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Select Type',
                                    'Car',
                                    'Bus',
                                    'Bike',
                                    'Tricycle',
                                    'Other'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.03),
                                ),
                                Text(
                                  'Vehicle Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Montserrat Regular',
                                  ),
                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.01),
                                ),
                                TextFormField(
                                    initialValue: vehicle_name,
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    )),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Vehicle name';
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        editted = true;
                                        vehicle_name = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: vehicle_name,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 32.0),
                                            borderRadius:
                                                BorderRadius.circular(6.0)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 32.0),
                                            borderRadius:
                                                BorderRadius.circular(6.0)))),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.03),
                                ),
                                Text(
                                  'Vehicle Year',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Montserrat Regular',
                                  ),
                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.01),
                                ),
                                TextFormField(
                                    initialValue: vehicle_year,
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    )),
                                    onChanged: (val) {
                                      setState(() {
                                        editted = true;
                                        vehicle_year = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: vehicle_year,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 32.0),
                                            borderRadius:
                                                BorderRadius.circular(6.0)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 32.0),
                                            borderRadius:
                                                BorderRadius.circular(6.0)))),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.03),
                                ),
                                Text(
                                  'Plate Number',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Montserrat Regular',
                                  ),
                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.01),
                                ),
                                TextFormField(
                                    initialValue: vehicle_plate_number,
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    )),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter vehicle plate number';
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        editted = true;
                                        vehicle_plate_number = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: vehicle_plate_number,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 32.0),
                                            borderRadius:
                                                BorderRadius.circular(6.0)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 32.0),
                                            borderRadius:
                                                BorderRadius.circular(6.0)))),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.03),
                                ),
                                Text(
                                  'Vehicle Color',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Montserrat Regular',
                                  ),
                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.01),
                                ),
                                TextFormField(
                                    initialValue: vehicle_color,
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    )),
                                    onChanged: (val) {
                                      setState(() {
                                        editted = true;
                                        vehicle_color = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: vehicle_color,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 32.0),
                                            borderRadius:
                                                BorderRadius.circular(6.0)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 32.0),
                                            borderRadius:
                                                BorderRadius.circular(6.0)))),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.03),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.04),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RoundedLoadingButton(
                                        controller: _btnControllerUpdate,
                                        height: 50,
                                        width: 100,
                                        elevation: 10,
                                        borderRadius: 8,
                                        color: AppColors.appPrimaryColor,
                                        successColor: AppColors.appPrimaryColor,
                                        child: Center(
                                          child: Text(
                                            editted ? 'Update' : 'Proceed',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily:
                                                    'Montserrat Regular',
                                                color: AppColors.whiteColor),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        onPressed: editted ?
                                            () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (await vehicleController
                                                .vehicleUpdate(
                                                vehicle_type,
                                                vehicle_name,
                                                vehicle_year,
                                                vehicle_plate_number,
                                                vehicle_color,
                                                widget.vehicle['_id']
                                            )) {
                                              toast(vehicleController
                                                  .message.value);
                                              _btnControllerUpdate.reset();
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          VehicleFileUploadUpdate(vehicle_id: widget.vehicle['_id'])));
                                            } else {
                                              toast(vehicleController
                                                  .message.value);
                                              _btnControllerUpdate.reset();
                                            }
                                          } else
                                            _btnControllerUpdate.reset();
                                        }
                                        :
                                        () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VehicleFileUpload()));
                                        }
                                      ),
                                    ),
                                    SizedBox(
                                      width: DeviceUtils.getScaledWidth(context,
                                          scale: 0.03),
                                    ),
                                    Expanded(
                                      child: RoundedLoadingButton(
                                        controller: _btnController,
                                        height: 50,
                                        width: 100,
                                        borderRadius: 8,
                                        elevation: 10,
                                        color: AppColors.whiteColor,
                                        successColor: AppColors.appPrimaryColor,
                                        child: Center(
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily:
                                                    'Montserrat Regular',
                                                color: AppColors.color5),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        onPressed: () async {
                                          _btnController.reset();
                                          _showMyDialog(
                                              context,
                                              widget.vehicle['_id'],
                                              vehicleController);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.03),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                )),
          );
        },
        key: null,
      ),
    );
  }
}

Future<void> _showMyDialog(context, vehicle_id, vehicleController) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
            child: Text('Are you Sure',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: 'Montserrat Bold',
                    color: AppColors.color5))),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text('This Action is irreversibly.',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: 'Montserrat regular',
                        color: AppColors.color10)),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: <Widget>[
          TextButton(
            child: Text('Cancel',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: 'Montserrat Bold',
                )),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Delete',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Montserrat Bold',
                    color: AppColors.color5)),
            onPressed: () async {
              if (await vehicleController.deleteVehicle(vehicle_id)) {
                toast(vehicleController.message.value);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DocumentList()));
              } else {
                toast(vehicleController.message.value);
              }
            },
          ),
        ],
      );
    },
  );
}
