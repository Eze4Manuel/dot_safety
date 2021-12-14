import 'package:dot_safety/app/controller/login_controller.dart';
import 'package:dot_safety/app/ui/pages/reset_password.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:dot_safety/app/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final LoginController loginController = Get.put(LoginController());

  final _formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String email = '';

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
                // height: DeviceUtils.getScaledHeight(context, scale: 1),
                width: DeviceUtils.getScaledWidth(context, scale: 1),
                color: AppColors.whiteColor,
                child: SingleChildScrollView(
                  child: Container(
                    color: AppColors.whiteColor,
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            DeviceUtils.getScaledWidth(context, scale: 0.07)),
                    height: DeviceUtils.getScaledHeight(context, scale: 1),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.11),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/logo.png',
                              width:
                                  DeviceUtils.getScaledWidth(context, scale: 0.2),
                              height: DeviceUtils.getScaledHeight(context,
                                  scale: 0.2),
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.01),
                          ),
                          Center(
                            child: Text(
                              Strings.forgottenPasswordTitle,
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
                                scale: 0.01),
                          ),
                          Center(
                            child: Text(
                              Strings.forgotPasswordText,
                              style: TextStyle(
                                  fontFamily: 'Montserrat Regular',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.06),
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
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14)),
                            decoration: InputDecorationValues(
                              hintText: "Email",
                              prefixIcon: Icons.mail_outline),
                            validator: (value) {
                              if (!loginController.emailRegex
                                  .hasMatch(value!))
                                return 'Enter a valid email address';
                              else
                                return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02),
                          ),
                          RoundedLoadingButton(
                              controller: _btnController,
                              height: 50,
                              borderRadius: 8,
                              color: AppColors.appPrimaryColor,
                              successColor: AppColors.appPrimaryColor,
                              child: Center(
                                child: Text(
                                  Strings.send,
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
                                  if (await loginController
                                      .forgottenPassword(email)) {
                                    toast(loginController.message.value);
                                    _btnController.reset();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResetPassword(email: email)));
                                  } else {
                                    toast(loginController.message.value);
                                    _btnController.reset();
                                  }
                                }else _btnController.reset();

                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
