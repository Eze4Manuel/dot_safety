import 'package:dot_safety/app/ui/pages/dashboard/dashboard.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dot_safety/app/ui/pages/onboarding.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


 void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(
      new GetMaterialApp(
    title: Strings.appName,
    debugShowCheckedModeBanner: false,
    // routes: Routes.routes,
    home: email == null  ? Onboarding() : Dashboard()
  )));
}

