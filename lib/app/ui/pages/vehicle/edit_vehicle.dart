import 'package:dot_safety/app/controller/vehicle_controller.dart';
import 'package:dot_safety/app/ui/pages/vehicle/document_list.dart';
import 'package:dot_safety/app/ui/pages/vehicle/vehicle_file_uploads.dart';
import 'package:dot_safety/app/ui/pages/vehicle/vehicle_file_uploads_update.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:dot_safety/app/utils/widget_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditVehicle extends StatefulWidget {

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
  TextEditingController dateCtl = TextEditingController();

  String dropdownValue = 'Select Type';

  late String vehicleType = 'Select Type';
  late String vehicleName;
  late String vehicleYear;
  late String vehiclePlateNumber;
  late String vehicleColor;

  bool editted = false;


  @override
  void initState() {

    setState(() {
      vehicleType = vehicleController.currentVehicle['vehicle_type'];
      vehicleName = vehicleController.currentVehicle['vehicle_name'];
      vehicleYear = vehicleController.currentVehicle['vehicle_year'];
      vehiclePlateNumber = vehicleController.currentVehicle['vehicle_plate_number'];
      vehicleColor = vehicleController.currentVehicle['vehicle_color'];
    });
    vehicleController.edittedDocuments =[];

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
                                  value: vehicleType,
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
                                      vehicleType = newValue!;
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
                                    initialValue: vehicleName,
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
                                        vehicleName = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: vehicleName,
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
                                      hintText: vehicleYear ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Select a DOB';
                                    }
                                  },

                                  onChanged: (val){
                                    editted = true;
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
                                    vehicleYear =
                                        DateFormat('yyyy-MM-dd').format(date);
                                    dateCtl.text =
                                        DateFormat('yyyy-MM-dd').format(date);
                                  },
                                ),

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
                                    initialValue: vehiclePlateNumber,
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
                                        vehiclePlateNumber = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: vehiclePlateNumber,
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
                                    initialValue: vehicleColor,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      fontFamily: 'Monserrat Regular'
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        editted = true;
                                        vehicleColor = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: vehicleColor,
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
                                            editted ? 'Update' : 'Done',
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
                                                vehicleType,
                                                vehicleName,
                                                vehicleYear,
                                                vehiclePlateNumber,
                                                vehicleColor,
                                                vehicleController.currentVehicle['_id']
                                            )) {
                                              toast(vehicleController
                                                  .message.value);
                                              _btnControllerUpdate.reset();
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DocumentList()));
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
                                                      DocumentList()));
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
                                              vehicleController.currentVehicle['_id'],
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
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('vehicle_name', vehicleName));
  }
}

Future<void> _showMyDialog(context, vehicleId, vehicleController) async {
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
              if (await vehicleController.deleteVehicle(vehicleId)) {
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
