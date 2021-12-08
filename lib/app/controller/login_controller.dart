import 'dart:convert';

import 'package:dot_safety/app/controller/base_controller.dart';
import 'package:dot_safety/app/model/account.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class LoginController extends BaseController {
  RxBool loading = false.obs;

  Future<bool> loginUserAccount(String? email, String? password) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/user/login_user');
    List user_keys = ['_id', 'token', 'email'];

    data = {
      "email": email,
      "password": password
    };

    print(url);

    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, data);
    if (result == false) {
      return result;
    } else {
      if (await storeUserDetails(result, user_keys)) {
        setMessage("Login Success");
        return Future<bool>.value(true);
      }
    }
    return false;
  }

  Future<bool> forgottenPassword(String? email) async {

    dynamic data;
    var url = Uri.parse('${Strings.domain}api/user/forgot_password');

    data = {'email': email};

    print(data);
    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, data);
    if (result == false) {
      return result;
    } else {
      setMessage("Passcode Sent to your Mail ");
      return Future<bool>.value(true);
    }
  }

  Future<bool> resetPassword(
      String? email, String? passcode, String? newPassword) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/user/reset_password');

    data = {
      'newPassword': newPassword,
      'email': email,
      'passcode': passcode
    };

    print(data);

    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, data);
    if (result == false) {
      return result;
    } else {
      setMessage("Password Reset Success");
      return Future<bool>.value(true);
    }
    return false;
  }

  Future<bool> emailVerification(String email) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/user/resend_verification');

    data = {
      'email': email
    };

    print(url);
    print(data);

    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, data);
    if (result == false) {
      return result;
    } else {
        setMessage("Email Sent to Mail");

        return Future<bool>.value(true);

    }
    return false;
  }
}
