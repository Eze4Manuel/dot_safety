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
  SharedPreferences.setMockInitialValues({});
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(prefs.getString('email'));
  var email = prefs.getString('email');

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(
      new GetMaterialApp(
    title: Strings.appName,
    debugShowCheckedModeBanner: false,
    // routes: Routes.routes,
    home: Container(
      child: email == null ? Wrapper() : Onboarding()
    )
  )));
}


class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var email;
  void getShared() async {
    var a = await SharedPrefs.readSingleString('first_name');
    print(a);
    setState(() {
      email = a;
    });
  }

  @override
  void initState(){
    super.initState();
    getShared();
  }

  @override
  Widget build(BuildContext context) {
    if(email == null){
      return Onboarding();
    }else{
      return Dashboard();
    }
  }
}
