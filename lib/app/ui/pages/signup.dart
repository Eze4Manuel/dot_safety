import 'package:dot_safety/app/controller/signup_controller.dart';
import 'package:dot_safety/app/model/account.dart';
import 'package:dot_safety/app/ui/pages/email_verify.dart';
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

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  final SignUpController signUpController = Get.put(SignUpController());

  Account account = Account();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: ResponsiveSafeArea(builder: (context, size) {
          return Container(
              color: AppColors.whiteColor,
              padding: EdgeInsets.symmetric(
                  horizontal:
                      DeviceUtils.getScaledWidth(context, scale: 0.07)),
              height: DeviceUtils.getScaledHeight(context, scale: 1),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
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
                      ],
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
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
                          TextFormField(
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
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
                          TextFormField(
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
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
                          TextFormField(
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                            decoration: InputDecorationValues(
                                hintText: "Date Of Birth",
                                prefixIcon: Icons.date_range_outlined),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Select a DOB';
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                account.dob = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02),
                          ),
                          TextFormField(
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                            decoration: InputDecorationValues(
                                hintText: "Phone Number",
                                prefixIcon: Icons.phone_outlined),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Your Phone Number';
                              }
                              if(value.length < 11 || value.length > 11 )
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
                          TextFormField(
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                            decoration: InputDecorationValues(
                                hintText: "Family Contact (Seperate numbers with comma(,) ",
                                prefixIcon: Icons.perm_identity),
                            validator: (value) {

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
                          TextFormField(
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                            decoration: InputDecorationValues(
                                hintText: "********",
                                prefixIcon: Icons.lock_outlined),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              if(value.length < 6 ){
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
                                if (await signUpController
                                    .signUpUsers(account)) {
                                  toast(signUpController.message.value);
                                  _btnController.reset();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EmailVerify( receivedEmail: account.email )));
                                } else {
                                  toast(signUpController.message.value);
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
                          height: DeviceUtils.getScaledHeight(context,
                              scale: 0.04),
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
                      ],
                    )
                  ],
                ),
              ));
        }));
  }
}
