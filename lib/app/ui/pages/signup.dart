import 'package:dot_safety/app/controller/signup_controller.dart';
import 'package:dot_safety/app/model/account.dart';
import 'package:dot_safety/app/ui/pages/login.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:dot_safety/app/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:intl/intl.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  final SignUpController signUpController = Get.put(SignUpController());

  Account account = Account();
  String confirm_password = '';
  String confirm_password_error = '';

  var state_selected;
  var lga_selected;

  List dropdownValue = [];

  late var lga;

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  TextEditingController dateCtl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: ResponsiveSafeArea(builder: (context, size) {
          return Container(
              color: AppColors.whiteColor,
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.07)),
              height: DeviceUtils.getScaledHeight(context, scale: 1),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.08),
                          ),
                          Center(
                            child: Text(
                              Strings.signUpToDotSafety,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: 'Montserrat Bold',
                                  color: AppColors.appPrimaryColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.03),
                          ),

                          Text(
                            'First Name',
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
                            decoration: InputDecorationValues(
                                hintText: "First Name",
                                prefixIcon: Icons.person_outline),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Your First Name';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                account.first_name = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02),
                          ),
                          Text(
                            'Last Name',
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
                            decoration: InputDecorationValues(
                                hintText: "Last Name",
                                prefixIcon: Icons.person_outline),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Your Last Name';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                account.last_name = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02),
                          ),
                          Text(
                            'Email',
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
                            decoration: InputDecorationValues(
                                hintText: "Email address",
                                prefixIcon: Icons.mail_outline),
                            validator: (value) {
                              if (!signUpController.emailRegex
                                      .hasMatch(value!) ||
                                  value == null)
                                return 'Enter a Valid Email Address';
                              else
                                return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                account.email = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02),
                          ),
                          Text(
                            'Date of Birth',
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
                            decoration: InputDecorationValues(
                                hintText: "Date Of Birth",
                                prefixIcon: Icons.date_range_outlined),
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
                              account.dob =
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
                            'Phone Number ( 11 digit number )',
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
                            decoration: InputDecorationValues(
                                hintText: "Phone Number",
                                prefixIcon: Icons.phone_outlined),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Your Phone Number';
                              }
                              if (value.length < 11 || value.length > 11)
                                return 'Incorrect Phone Number';
                            },
                            onChanged: (val) {
                              setState(() {
                                account.phone_number = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02),
                          ),
                          Text(
                            'State of Residence',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                fontFamily: 'Montserrat Regular',
                                color: AppColors.color10),
                          ),

                          DropdownButtonFormField(
                              decoration: InputDecorationValues(
                                  hintText: "Select state",
                                  prefixIcon: Icons.person_outline),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  fontFamily: 'Montserrat Regular',
                                  color: AppColors.color10),
                              items: signUpController.listValue.map((state) {
                                return new DropdownMenuItem<dynamic>(
                                    value: state.name, child: Text(state.name));
                              }).toList(),
                              onTap: () {
                                FocusScope.of(context).unfocus();
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Selecet an option ";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                // Function to select state local government areas from selected state
                                setState(() {
                                  state_selected =  val;
                                  account.state_of_residence = val.toString();
                                  dropdownValue = signUpController
                                      .listValue[signUpController.listValue
                                              .firstWhere((element) =>
                                                  (element.name == state_selected))
                                              .id -
                                          1]
                                      .locals;
                                  lga_selected = null;
                                });
                              }),

                          // Local Government Area Field
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02),
                          ),
                          Text(
                            'LGA of Residence',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                fontFamily: 'Montserrat Regular',
                                color: AppColors.color10),
                          ),

                          DropdownButtonFormField(
                              decoration: InputDecorationValues(
                                  hintText: "Select LGA of residence",
                                  prefixIcon: Icons.local_activity),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  fontFamily: 'Montserrat Regular',
                                  color: AppColors.color10),
                              value: lga_selected,
                              items: dropdownValue.map((locale) {
                                return new DropdownMenuItem<String>(
                                    value: locale['name'],
                                    child: Text(locale['name']));
                              }).toList(),
                              onTap: () {
                                FocusScope.of(context).unfocus();
                              },
                              onChanged: (val) {
                                setState(() {
                                  lga_selected = val;
                                  account.lga_of_residence = val.toString();
                                });
                              }),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02),
                          ),
                          Text(
                            'Family Contact Number',
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
                            decoration: InputDecorationValues(
                                hintText: "Family Contact ",
                                prefixIcon: Icons.perm_identity),
                            validator: (value) {
                              if (value != null) {
                                if (value.length < 11 || value.length > 11)
                                  return 'Incorrect Phone Number';
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                account.contact = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02),
                          ),
                          Text(
                            'Password ( Must be at least 6 characters )',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                fontFamily: 'Montserrat Regular',
                                color: AppColors.color10),
                            textAlign: TextAlign.center,
                          ),
                          TextFormField(
                            obscureText: true,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                fontFamily: 'Montserrat Regular',
                                color: AppColors.color10),
                            decoration: InputDecorationValues(
                                hintText: "********",
                                prefixIcon: Icons.lock_outlined),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              if (value.length < 6) {
                                return "Password Must Be At Least 6 Characters";
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                account.password = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02),
                          ),
                          Text(
                            'Confirm Password',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                fontFamily: 'Montserrat Regular',
                                color: AppColors.color10),
                            textAlign: TextAlign.center,
                          ),
                          TextFormField(
                            obscureText: true,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                fontFamily: 'Montserrat Regular',
                                color: AppColors.color10),
                            decoration: InputDecorationValues(
                                hintText: "********",
                                prefixIcon: Icons.lock_outlined),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              if (value.length < 6) {
                                return "Password Must Be At Least 6 Characters";
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                confirm_password = val;
                              });
                            },
                          ),
                          Text(
                            confirm_password_error,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                fontFamily: 'Montserrat Regular',
                                color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.06),
                          ),
                          RoundedLoadingButton(
                            controller: _btnController,
                            height: 50,
                            borderRadius: 8,
                            color: AppColors.appPrimaryColor,
                            successColor: AppColors.appPrimaryColor,
                            child: Center(
                              child: Text(
                                Strings.signup,
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
                                print(account.state_of_residence);
                                if (account.password == confirm_password) {
                                  setState(() {
                                    confirm_password_error = "";
                                  });
                                  if (await signUpController
                                      .signUpUsers(account)) {
                                    toast(signUpController.message.value);
                                    _btnController.reset();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                  } else {
                                    toast(signUpController.message.value);
                                    _btnController.reset();
                                  }
                                } else {
                                  setState(() {
                                    confirm_password_error =
                                        "Password Mismatch";
                                  });
                                  _btnController.reset();
                                }
                              } else
                                _btnController.reset();
                            },
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.04),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text.rich(TextSpan(
                              text: Strings.alreadyhaveAccount,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  fontFamily: 'Montserrat Regular'),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: Strings.loginText,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.appPrimaryColor),
                                )
                              ])),
                        ),
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.04),
                        ),
                      ],
                    )
                  ],
                ),
              ));
        }));
  }
}
