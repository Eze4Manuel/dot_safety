import 'package:dot_safety/app/controller/dashboard_controller.dart';
import 'package:dot_safety/app/ui/pages/dashboard/comments.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:dot_safety/app/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PersonalInfo extends StatefulWidget {
  var offense;
  var offenseId;

  PersonalInfo({this.offense, this.offenseId});


  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  String? name = '';
  String? user_id = '';
  String? dob;
  String cardTypeValue = 'Select Card Type';
  String card_type = '';
  String card_number = '';
  String card_expiry_date = '';
  String card_ccv = '';

  var data;

  void getShared() async {
    var a = await SharedPrefs.readSingleString('first_name');
    var b = await SharedPrefs.readSingleString('last_name');
    var c = await SharedPrefs.readSingleString('_id');
    setState(() {
      name = a + " " + b;
      user_id = c;
    });
  }


  final DashboardController dashboardController =
  Get.put(DashboardController());

  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();

  final _formKey = GlobalKey<FormState>();

  TextEditingController dateCtl = TextEditingController();

  @override
  void initState() {
    super.initState();
    getShared();
  }

  @override
  Widget build(BuildContext context) {

    data = {
      "offender_name": name,
      "offender_id": user_id,
      "offense": widget.offense['title'],
      "offense_id": 'OFS_' + widget.offenseId,
      "offense_code": widget.offense['code'],
      "fee": widget.offense['fine'],
      "card_type": card_type,
      "card_number": card_number,
      "card_expiry_date": card_expiry_date,
      "card_ccv": card_ccv,
      "comment": '',
      "is_successful": false
    };

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
                Strings.personalInfo,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat Bold',
                  fontSize: 18,
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
                // height: DeviceUtils.getScaledHeight(context, scale: 1),
                width: DeviceUtils.getScaledWidth(context, scale: 1),
                color: AppColors.whiteColor,
                child: SingleChildScrollView(
                  child: Container(
                      color: AppColors.whiteColor,
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              DeviceUtils.getScaledWidth(context, scale: 0.07)),
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
                                  'Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.color10),
                                  textAlign: TextAlign.center,
                                ),
                                TextFormField(
                                  initialValue: name ?? '',
                                  readOnly: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.color10),
                                  decoration: InputDecorationNoPrefixValues(
                                      hintText: name ?? '',
                                      prefixIcon: Icons.person),
                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.02),
                                ),
                                Text(
                                  'Offense',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.color10),
                                  textAlign: TextAlign.center,
                                ),
                                TextFormField(
                                  initialValue: widget.offense['title'] ?? '',
                                  readOnly: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.color10),
                                  decoration: InputDecorationNoPrefixValues(
                                      hintText: widget.offense['title'] ?? '',
                                      prefixIcon: Icons.sanitizer_sharp),

                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.02),
                                ),
                                Text(
                                  'Offense ID',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.color10),
                                  textAlign: TextAlign.center,
                                ),
                                TextFormField(
                                  readOnly: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.color10),
                                  decoration: InputDecorationNoPrefixValues(
                                      hintText: 'OFS_' + widget.offenseId,
                                      prefixIcon: Icons.qr_code_scanner),

                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.02),
                                ),
                                Text(
                                  'Offense Code',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.color10),
                                  textAlign: TextAlign.center,
                                ),
                                TextFormField(
                                  readOnly: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.color10),
                                  decoration: InputDecorationNoPrefixValues(
                                      hintText: widget.offense['code'] ?? '',
                                      prefixIcon: Icons.qr_code_scanner),

                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.02),
                                ),

                                Text(
                                  'Fee',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.color10),
                                  textAlign: TextAlign.center,
                                ),
                                TextFormField(
                                  initialValue: widget.offense['fine'].toString(),
                                  readOnly: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.color10),
                                  decoration: InputDecorationNoPrefixValues(
                                      hintText: widget.offense['fine'].toString(),
                                      prefixIcon: Icons.money),
                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.02),
                                ),
                                Text(
                                  'Card Type',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.color10),
                                  textAlign: TextAlign.center,
                                ),
                                DropdownButtonFormField<String>(
                                  value: cardTypeValue,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.color10),
                                  decoration: InputDecorationNoPrefixValues(
                                      hintText: 'visa, master card',
                                      prefixIcon: Icons.payment_outlined),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      cardTypeValue = newValue!;
                                      card_type = newValue;
                                    });
                                  },
                                  items: <String>['Select Card Type', 'visa', 'master card', 'verve']
                                      .map<DropdownMenuItem<String>>((String value) {
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
                                Text(
                                  'Card Number',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.color10),
                                  textAlign: TextAlign.center,
                                ),
                                TextFormField(
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.color10),
                                  decoration: InputDecorationNoPrefixValues(
                                      hintText: 'Card Number',
                                      prefixIcon: Icons.payment_outlined),
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Enter your Card number';
                                    else
                                      return null;
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      card_number = val;
                                    });
                                  },
                                ),


                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.02),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Expiry Date',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                fontFamily: 'Montserrat Regular',
                                                color: AppColors.color10),
                                            textAlign: TextAlign.center,
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
                                                hintText: "Expiry date",
                                                prefixIcon: Icons.date_range_outlined),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Enter card expiry date';
                                              }
                                            },
                                            onTap: () async{
                                              DateTime date = DateTime(1900);
                                              FocusScope.of(context).requestFocus(new FocusNode());
                                              date = (await showDatePicker(
                                                  context: context,
                                                  initialDate:DateTime.now(),
                                                  firstDate:DateTime(1900),
                                                  lastDate: DateTime(2100)))!;
                                              card_expiry_date = DateFormat('yyyy-MM-dd').format(date);
                                              dateCtl.text = DateFormat('yyyy-MM-dd').format(date);},
                                          ),

                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: DeviceUtils.getScaledWidth(context,
                                          scale: 0.02),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'CCV',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                fontFamily: 'Montserrat Regular',
                                                color: AppColors.color10),
                                            textAlign: TextAlign.center,
                                          ),
                                          TextFormField(
                                            maxLengthEnforcement: MaxLengthEnforcement.enforced, maxLength: 3,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                fontFamily: 'Montserrat Regular',
                                                color: AppColors.color10),
                                            decoration: InputDecorationNoPrefixValues(
                                                hintText: 'CCV',
                                                prefixIcon: Icons.payment_outlined),
                                            validator: (value) {
                                              if (value == null || value.isEmpty)
                                                return 'Enter card CCV number';
                                              else
                                                return null;
                                            },
                                            onChanged: (val) {
                                              setState(() {
                                                card_ccv = val;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.04),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    Strings.scanOfficerQR,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        fontFamily: 'Montserrat Regular',
                                        color: AppColors.appPrimaryColor),
                                  ),
                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.01),
                                ),

                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: DeviceUtils.getScaledWidth(context,
                                        scale: 0.7),
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.42),
                                    child: Image.asset('assets/images/qr.png'),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {

                                  },
                                  child:
                                  RoundedLoadingButton(
                                      controller: _btnController,
                                      height: 50,
                                      borderRadius: 8,
                                      color: AppColors.appPrimaryColor,
                                      successColor: AppColors.appPrimaryColor,
                                      child: Center(
                                        child: Text(
                                          Strings.makePayment,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Montserrat Regular',
                                              color: AppColors.whiteColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      onPressed: () async {
                                        if(_formKey.currentState!.validate()){
                                          if ( await dashboardController
                                              .makePayment(data)) {
                                            toast(dashboardController.message.value);
                                            _btnController.reset();
                                            showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder: (_) => AlertDialog(
                                                  title: Text(
                                                    Strings.success,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                        fontFamily: 'Montserrat Bold',
                                                        color: AppColors
                                                            .appPrimaryColor),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  content: Text(
                                                    dashboardController.message.value,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 13,
                                                        fontFamily:
                                                        'Montserrat Regular',
                                                        color: AppColors.color10),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  actions: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    Comments(user_id: user_id)));
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                8),
                                                            color: AppColors
                                                                .appPrimaryColor),
                                                        child: Center(
                                                          child: Text(
                                                            Strings.ok,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                'Montserrat Regular',
                                                                color: AppColors
                                                                    .whiteColor),
                                                            textAlign:
                                                            TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                          } else {
                                            toast(dashboardController.message.value);
                                            _btnController.reset();
                                          }
                                        }else _btnController.reset();
                                      }),

                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.04),
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
