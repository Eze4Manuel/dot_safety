import 'package:dot_safety/app/controller/vehicle_controller.dart';
import 'package:dot_safety/app/ui/pages/vehicle/document_list.dart';
import 'package:dot_safety/app/ui/pages/vehicle/vehicle_file_uploads.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:dot_safety/app/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class VehicleDocument extends StatefulWidget {

  @override
  State<VehicleDocument> createState() => _VehicleDocumentState();
}

class _VehicleDocumentState extends State<VehicleDocument> {
  final _formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  final VehicleController vehicleController = Get.put(VehicleController());
  TextEditingController dateCtl = TextEditingController();

  String dropdownValue = 'Select Type';

  late String vehicle_type = '';
  late String vehicle_name = '';
  late String vehicle_year = '';
  late String vehicle_plate_number = '';
  late String vehicle_color = '';

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
                'Add New Vehicle',
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
                                  value: dropdownValue,
                                  style: TextStyle(
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
                                      vehicle_type = newValue;
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                        fontFamily: 'Montserrat Regular'
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Vehicle name';
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        vehicle_name = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "Camary, CRV, Acer Macer",
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
                                      hintText: "Vehicle Make Year"),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Select a DOB';
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
                                    vehicle_year =
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat Regular'
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter vehicle plate number';
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        vehicle_plate_number = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "ABJ29IL",
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat Regular'
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        vehicle_color = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "Blue, Black, Silver",
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
                                RoundedLoadingButton(
                                  controller: _btnController,
                                  height: 50,
                                  borderRadius: 8,
                                  color: AppColors.appPrimaryColor,
                                  successColor: AppColors.appPrimaryColor,
                                  child: Center(
                                    child: Text(
                                      'PROCEED',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          fontFamily: 'Montserrat Regular',
                                          color: AppColors.whiteColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      if (await vehicleController.vehicleCreate(
                                          vehicle_type,
                                          vehicle_name,
                                          vehicle_year,
                                          vehicle_plate_number,
                                          vehicle_color)) {
                                        toast(vehicleController.message.value);
                                        _btnController.reset();
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DocumentList()));
                                      } else {
                                        toast(vehicleController.message.value);
                                        _btnController.reset();
                                      }
                                    } else
                                      _btnController.reset();
                                  },
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
