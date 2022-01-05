import 'package:dot_safety/app/controller/login_controller.dart';
import 'package:dot_safety/app/controller/signup_controller.dart';
import 'package:dot_safety/app/ui/pages/login.dart';
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

class EmailVerify extends StatefulWidget {

  String? receivedEmail;

  EmailVerify({this.receivedEmail});

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
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
          return Container(
              height: DeviceUtils.getScaledHeight(context, scale: 1),
              width: DeviceUtils.getScaledWidth(context, scale: 1),
              color: AppColors.whiteColor,
              child: Container(
                  color: AppColors.whiteColor,
                  padding: EdgeInsets.symmetric(
                      horizontal:
                      DeviceUtils.getScaledWidth(context, scale: 0.07)),
                  height: DeviceUtils.getScaledHeight(context, scale: 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/email_sent.png',
                            width:
                            DeviceUtils.getScaledWidth(context, scale: 0.2),
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.2),
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.04),
                          ),
                          Text(
                            '${Strings.verifyMailText}',
                            style: TextStyle(
                                fontFamily: 'Montserrat Regular',
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02),
                          ),
                          Text(
                            'Or',
                            style: TextStyle(
                                fontFamily: 'Montserrat Regular',
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02),
                          ),
                          Form(
                              key: _formKey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                    fontSize: 14.0,
                                  ),
                                  initialValue: widget.receivedEmail ?? email,
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
                                        Strings.resendMail,
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
                                            .emailVerification(email)) {
                                          toast(loginController.message.value);
                                          _btnController.reset();
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Login()));
                                        } else {
                                          toast(loginController.message.value);
                                          _btnController.reset();
                                        }
                                      }else{
                                        _btnController.reset();
                                      }
                                    }),
                              ])),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02),
                          ),
                        ],
                      ),
                    ],
                  )));
        },
        key: null,
      ),
    );
  }
}
