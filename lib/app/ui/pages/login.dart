import 'package:dot_safety/app/controller/login_controller.dart';
import 'package:dot_safety/app/controller/signup_controller.dart';
import 'package:dot_safety/app/ui/pages/dashboard/dashboard.dart';
import 'package:dot_safety/app/ui/pages/email_verify.dart';
import 'package:dot_safety/app/ui/pages/forgot_password.dart';
import 'package:dot_safety/app/ui/pages/signup.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:dot_safety/app/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:dot_safety/app/utils/responsive_safe_area.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final LoginController loginController = Get.put(LoginController());
  final SignUpController signUpController = Get.put(SignUpController());

  final _formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();

  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    signUpController.parseJson();
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                width: DeviceUtils.getScaledWidth(context, scale: 0.2),
                                height: DeviceUtils.getScaledHeight(context, scale: 0.2),
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                              ),
                              Center(
                                child: Text(
                                  Strings.loginToDotSafety,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      fontFamily: 'Montserrat Bold',
                                      color: AppColors.appPrimaryColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Column(
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
                                      fontFamily: 'Montserrat Regular'
                                  ),
                                  decoration: InputDecorationValues(
                                      hintText: "hchinwe789@design.com",
                                      prefixIcon: Icons.mail_outline),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Your Email';
                                    }
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                              ),
                              SizedBox(
                                height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                              ),
                              Text(
                                'Password',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    fontFamily: 'Montserrat Regular',
                                    color: AppColors.color10),
                                textAlign: TextAlign.center,
                              ),
                              TextFormField(
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,
                                fontFamily: 'Montserrat Regular'),
                                obscureText: true,
                                decoration: InputDecorationValues(
                                    hintText: "Password",
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
                                    password = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EmailVerify()));
                                    },
                                    child: Text(
                                      'Resend Verification',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          fontFamily: 'Montserrat Regular'),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ForgotPassword()));
                                    },
                                    child: Text(
                                      Strings.forgottenPassword,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          fontFamily: 'Montserrat Regular'),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                              ),
                              RoundedLoadingButton(
                                  controller: _btnController,
                                  height: 50,
                                  borderRadius: 8,
                                  color: AppColors.appPrimaryColor,
                                  successColor: AppColors.appPrimaryColor,
                                  child: Center(
                                    child: Text(
                                      Strings.login,
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
                                      if ( await loginController
                                          .loginUserAccount( email, password)) {
                                        toast(loginController.message.value);
                                        _btnController.reset();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Dashboard()), (Route<dynamic> route) => false);
                                      } else {
                                        toast(loginController.message.value);
                                        _btnController.reset();
                                      }
                                    }else _btnController.reset();
                                  }),
                              SizedBox(
                                height: DeviceUtils.getScaledHeight(context, scale: 0.06),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  Strings.orLoginWith,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/facebook.png',
                                    width: DeviceUtils.getScaledWidth(context, scale: 0.06),
                                    height: DeviceUtils.getScaledHeight(context, scale: 0.06),
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: DeviceUtils.getScaledWidth(context, scale: 0.09),
                                  ),
                                  Image.asset(
                                    'assets/images/google.png',
                                    width: DeviceUtils.getScaledWidth(context, scale: 0.06),
                                    height: DeviceUtils.getScaledHeight(context, scale: 0.06),
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) => Signup()));
                                },
                                child: Text.rich(TextSpan(
                                    text: Strings.donthaveAccount,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        fontFamily: 'Montserrat Regular'),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: Strings.signupText,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            fontFamily: 'Montserrat Regular',
                                            color: AppColors.appPrimaryColor),
                                      )
                                    ])),
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
