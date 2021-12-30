import 'package:dot_safety/app/controller/vehicle_controller.dart';
import 'package:dot_safety/app/ui/pages/vehicle/vehicle_file_uploads.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class GoodsInTransit extends StatefulWidget {
  @override
  State<GoodsInTransit> createState() => _GoodsInTransitState();
}

class _GoodsInTransitState extends State<GoodsInTransit> {
  String dropdownValue = 'Select Good';
  final _formKey = GlobalKey<FormState>();
  final VehicleController vehicleController = Get.put(VehicleController());

  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();

  late String name_of_goods;
  late String category_of_goods;
  late String goods_shortnote;

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
                  'Good In Transit',
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
                    bottom: MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom,
                  ),
                  child: Container(
                      width: DeviceUtils.getScaledWidth(context, scale: 1),
                      color: AppColors.whiteColor,
                      child: SingleChildScrollView(
                          child: Container(
                              color: AppColors.color2,
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                  DeviceUtils.getScaledWidth(
                                      context, scale: 0.04)),
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            SizedBox(
                                              height: DeviceUtils
                                                  .getScaledHeight(
                                                  context,
                                                  scale: 0.04),
                                            ),
                                            Text(
                                              'Name of Good',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                fontFamily: 'Montserrat Regular',
                                              ),
                                            ),
                                            SizedBox(
                                              height: DeviceUtils
                                                  .getScaledHeight(
                                                  context,
                                                  scale: 0.01),
                                            ),
                                            TextFormField(
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                  )),
                                              decoration: InputDecoration(
                                                  contentPadding: EdgeInsets
                                                      .fromLTRB(
                                                      20.0, 15.0, 20.0, 15.0),
                                                  hintText: "Fabric, Shoes",
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 32.0),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          6.0)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 32.0),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          6.0))),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter Your First Name';
                                                }
                                                return null;
                                              },
                                              onChanged: (val) {
                                                setState(() {
                                                  name_of_goods = val;
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              height: DeviceUtils
                                                  .getScaledHeight(
                                                  context,
                                                  scale: 0.03),
                                            ),
                                            Text(
                                              'Category of Good',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                fontFamily: 'Montserrat Regular',
                                              ),
                                            ),
                                            SizedBox(
                                              height: DeviceUtils
                                                  .getScaledHeight(
                                                  context,
                                                  scale: 0.01),
                                            ),
                                            DropdownButtonFormField<String>(
                                              value: dropdownValue,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: AppColors.color10,
                                                fontFamily: 'Montserrat Regular',
                                              ),
                                              decoration: InputDecoration(
                                                  contentPadding: EdgeInsets
                                                      .fromLTRB(
                                                      20.0, 10.0, 20.0, 10.0),
                                                  hintText: "Fabric, Shoes",
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 32.0),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          6.0)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 32.0),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          6.0))),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownValue = newValue!;
                                                  category_of_goods = newValue;
                                                });
                                              },
                                              items: <String>[
                                                'Select Good',
                                                'Computer/Gadgets',
                                                'Fashion',
                                                'Children',
                                                'Business',
                                                'Others'
                                              ].map<DropdownMenuItem<String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                            ),
                                            SizedBox(
                                              height: DeviceUtils
                                                  .getScaledHeight(
                                                  context,
                                                  scale: 0.03),
                                            ),
                                            Text(
                                              'Notes',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                fontFamily: 'Montserrat Regular',
                                              ),
                                            ),
                                            SizedBox(
                                              height: DeviceUtils
                                                  .getScaledHeight(
                                                  context,
                                                  scale: 0.01),
                                            ),
                                            TextFormField(
                                                maxLines: 6,
                                                style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                      fontWeight: FontWeight
                                                          .w400,
                                                      fontSize: 14,
                                                    )),

                                                onChanged: (val) {
                                                  setState(() {
                                                    goods_shortnote = val;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                    contentPadding: EdgeInsets
                                                        .fromLTRB(
                                                        20.0, 15.0, 20.0, 15.0),
                                                    hintText: "A short description of good",
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 32.0),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            6.0)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.white,
                                                            width: 32.0),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            6.0)))),
                                            SizedBox(
                                              height: DeviceUtils
                                                  .getScaledHeight(
                                                  context,
                                                  scale: 0.03),
                                            ),
                                            SizedBox(
                                              height: DeviceUtils
                                                  .getScaledHeight(
                                                  context,
                                                  scale: 0.03),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: DeviceUtils
                                                  .getScaledHeight(
                                                  context,
                                                  scale: 0.04),
                                            ),

                                            SizedBox(
                                              height: DeviceUtils
                                                  .getScaledHeight(
                                                  context,
                                                  scale: 0.03),
                                            ),
                                          ],
                                        ),

                                        RoundedLoadingButton(
                                          controller: _btnController,
                                          height: 50,
                                          borderRadius: 8,
                                          color: AppColors.appPrimaryColor,
                                          successColor: AppColors.appPrimaryColor,
                                          child: Center(
                                            child: Text(
                                              'Proceed',
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
                                              if (await vehicleController
                                                  .goodsCreate(name_of_goods,category_of_goods, goods_shortnote)) {
                                                toast(vehicleController.message.value);
                                                _btnController.reset();
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) => Login()));
                                              } else {
                                                toast(vehicleController.message.value);
                                                _btnController.reset();
                                              }
                                            } else
                                              _btnController.reset();
                                          },
                                        ),
                                      ]
                                  )
                              )
                          )
                      )
                  )
              );
            })
    );
  }
}
