


import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast (msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: AppColors.appPrimaryColor,
      textColor: AppColors.whiteColor,
      fontSize: 14.0
  );
}


