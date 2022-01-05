import 'package:dot_safety/app/controller/profile_controller.dart';
import 'package:dot_safety/app/ui/pages/profile/settings.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:dot_safety/app/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditContact extends StatefulWidget {
  var contact;
  var indexNumber;
  EditContact({this.contact, this.indexNumber});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {


  String name = '';
  String phone_number = '';

  final ProfileController profileController = Get.put(ProfileController());

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG';
  bool valid = false;

  final _formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();

  late PhoneNumber number;

  @override
  void initState() {
    super.initState();
    profileController.parseJson();

    setState(() {
      name = widget.contact['name'];
      phone_number = widget.contact['phone_number'];
    });

    number = PhoneNumber(isoCode: 'NG', phoneNumber: phone_number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
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
                      color: AppColors.whiteColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.07)),
                      height: DeviceUtils.getScaledHeight(context, scale: 1),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Center(
                                  child: Text(
                                    'Update Family Contact',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        fontFamily: 'Montserrat Bold',
                                        color: AppColors.appPrimaryColor),
                                  ),
                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Full Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        fontFamily: 'Montserrat Regular',
                                        color: AppColors.color10),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                TextFormField(
                                  initialValue: name,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: 'Montserrat Regular'
                                  ),
                                  decoration: InputDecorationNoPrefixValues(
                                      hintText: name),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Contact's Name";
                                    }
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      name = val;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Phone Number',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        fontFamily: 'Montserrat Regular',
                                        color: AppColors.color10),
                                  ),
                                ),
                                InternationalPhoneNumberInput(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.color10),
                                  inputDecoration: InputDecorationNoPrefixValues(
                                      hintText: phone_number.substring(4, phone_number.length)),
                                  onInputChanged: (PhoneNumber number) {
                                    phone_number = number.phoneNumber!;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter Your Phone Number';
                                    }
                                    if (!valid)
                                      return 'Incorrect Phone Number';
                                  },
                                  onInputValidated: (bool value) {
                                    print(value);
                                    setState(() {
                                      valid = value;
                                    });
                                  },
                                  selectorConfig: SelectorConfig(
                                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                                  ),
                                  ignoreBlank: false,
                                  autoValidateMode: AutovalidateMode.disabled,
                                  selectorTextStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.color10),
                                  initialValue: number,
                                  textFieldController: controller,
                                  formatInput: false,
                                  keyboardType:
                                  TextInputType.numberWithOptions(signed: true, decimal: true),
                                  inputBorder: OutlineInputBorder(),
                                  onSaved: (PhoneNumber number) {
                                    print('On Saved: $number');
                                  },
                                ),

                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context, scale: 0.05),
                                ),

                                RoundedLoadingButton(
                                    controller: _btnController,
                                    height: 50,
                                    borderRadius: 8,
                                    color: AppColors.appPrimaryColor,
                                    successColor: AppColors.appPrimaryColor,
                                    child: Center(
                                      child: Text(
                                        'Update Contact',
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
                                        if ( await profileController.updateFamilyContact( name, phone_number, widget.indexNumber )) {
                                          toast(profileController.message.value);
                                          _btnController.reset();
                                          Navigator.pushAndRemoveUntil(context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) => SettingsView(),
                                            ),
                                                (route) => false,
                                          );
                                        } else {
                                          toast(profileController.message.value);
                                          _btnController.reset();
                                        }

                                      }else _btnController.reset();
                                    }),
                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context, scale: 0.06),
                                ),

                                SizedBox(
                                  height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                                ),

                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  )
              )
          );
        },
        key: null,
      ),
    );
  }
}
