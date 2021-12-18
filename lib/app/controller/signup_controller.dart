import 'dart:convert';

import 'package:dot_safety/app/controller/base_controller.dart';
import 'package:dot_safety/app/model/account.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SignUpController extends BaseController {
  RxBool loading = false.obs;

  Future<bool> signUpUsers(Account account) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/user/register_user');

    data = account.toJson();

    print(data);

    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, data, 'post');
    if (result == false) {
      return result;
    } else {
      setMessage("Account Created, Verify Email");
      return Future<bool>.value(true);
    }
    return false;
  }

  Future<bool> forgottenPassword(String? license) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/user/verify_license');

    data = {'license': license};

    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, data, 'post');
    if (result == false) {
      return result;
    } else {
      setMessage("Passcode Sent to your Mail ");
      return Future<bool>.value(true);
    }
  }

  Future<bool> resetPassword(
      String? license, String? passcode, String? newPassword) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/user/reset_password');

    data = {
      'passcode': passcode,
      'newPassword': newPassword,
      'license': license
    };

    print(data);

    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, data, 'post');
    if (result == false) {
      return result;
    } else {
      setMessage("Passcode Sent to your Mail ");
      return Future<bool>.value(true);
    }
    return false;
  }
}
