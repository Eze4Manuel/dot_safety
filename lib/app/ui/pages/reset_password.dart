import 'package:dot_safety/app/controller/login_controller.dart';
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

class ResetPassword extends StatefulWidget {
  String email = '';

  ResetPassword({required this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final LoginController loginController = Get.put(LoginController());

  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();

  final _formKey = GlobalKey<FormState>();

  String passcode = '';
  String newPassword = '';
  String confirmPassword = '';
  String passwordError = '';


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
                        horizontal: DeviceUtils.getScaledWidth(context, scale: 0.07)),
                    height: DeviceUtils.getScaledHeight(context, scale: 1),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                'assets/images/logo.png',
                                  width: DeviceUtils.getScaledWidth(context, scale: 0.2),
                                  height: DeviceUtils.getScaledHeight(context, scale: 0.2),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(
                                height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                              ),
                              Center(
                                child: Text(
                                  Strings.resetPassword,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.appPrimaryColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                              ),
                              Center(
                                child: Text(
                                  Strings.setNewPassword,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat Regular',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: DeviceUtils.getScaledHeight(context, scale: 0.06),
                              ),
                              Text(
                                'Passcode From Mail',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat Regular',
                                    color: AppColors.color10),
                                textAlign: TextAlign.center,
                              ),
                              TextFormField(
                                  style: GoogleFonts.montserrat(
                                      textStyle:
                                      TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                                  decoration: InputDecorationValues(
                                  hintText: "Passcode From Mail",
                                  prefixIcon: Icons.mail_outline),

                                  onChanged: (val) {
                                    setState(() {
                                      passcode = val;
                                    });
                                  },),
                              SizedBox(
                                height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                              ),
                              Text(
                                'Create New Password',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat Regular',
                                    color: AppColors.color10),
                                textAlign: TextAlign.center,
                              ),
                              TextFormField(
                                style: GoogleFonts.montserrat(
                                    textStyle:
                                    TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                                obscureText: true,
                                decoration: InputDecorationValues(
                                    hintText: "Create New Password",
                                    prefixIcon: Icons.mail_outline),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  if(value.length < 6 ){
                                    return "Password must be at least 6 characters";
                                  }
                                },
                                onChanged: (val) {
                                  setState(() {
                                    newPassword = val;
                                  });
                                },),
                              SizedBox(
                                height: DeviceUtils.getScaledHeight(context, scale: 0.025),
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
                                  style: GoogleFonts.montserrat(
                                      textStyle:
                                      TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                                  obscureText: true,
                                decoration: InputDecorationValues(
                                    hintText: "Confirm Password",
                                    prefixIcon: Icons.lock_outlined),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  if(value.length < 6 ){
                                    return "Password must be at least 6 characters";
                                  }
                                },
                                onChanged: (val) {
                                  setState(() {
                                    confirmPassword = val;
                                  });
                                },
                              ),
                              Text(
                                passwordError,
                                style: TextStyle(
                                    color: AppColors.color5,
                                    fontFamily: 'Montserrat Regular'
                                ),
                              ),
                              SizedBox(
                                height: DeviceUtils.getScaledHeight(context, scale: 0.05),
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
                                  if(newPassword != confirmPassword){
                                    setState(() {
                                      _btnController.reset();
                                      passwordError = "Passwords Don't Match";
                                    });
                                  }else if (await loginController
                                      .resetPassword(widget.email, passcode, newPassword)) {
                                    toast(loginController.message.value);
                                    _btnController.reset();

                                    setState(() {
                                      passwordError = "";
                                    });

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Login()));
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
                )
            )
          );
        },
        key: null,
      ),
    );
  }
}
