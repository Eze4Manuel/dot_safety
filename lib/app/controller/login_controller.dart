import 'dart:convert';

import 'package:dot_safety/app/controller/base_controller.dart';
import 'package:dot_safety/app/model/account.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends BaseController {
  RxBool loading = false.obs;

  Future<bool> loginUserAccount(String? email, String? password) async {
    dynamic data;
    final prefs = await SharedPreferences.getInstance();

    var url = Uri.parse('${Strings.domain}api/user/login_user');

    data = {"email": email, "password": password};

    print(url);

    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, data, 'post');
    if (result == false) {
      return result;
    } else {
      prefs.setString('_id', result['_id']);
      prefs.setString('token', result['token']);
      prefs.setString('email', result['email']);
      prefs.setString('first_name', result['first_name']);
      prefs.setString('last_name', result['last_name']);
      prefs.setString('image_url', result['image_url']);

      setMessage("Login Success");
      return Future<bool>.value(true);
    }
    return false;
  }

  Future<bool> forgottenPassword(String? email) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/user/forgot_password');

    data = {'email': email};

    print(data);
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
      String? email, String? passcode, String? newPassword) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/user/reset_password');

    data = {'newPassword': newPassword, 'email': email, 'passcode': passcode};

    print(data);

    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, data, 'post');
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

    data = {'email': email};

    print(url);
    print(data);

    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, data, 'post');
    if (result == false) {
      return result;
    } else {
      setMessage("Email Sent to Mail");

      return Future<bool>.value(true);
    }
    return false;
  }

  Future<bool> logout() async {
    await SharedPrefs.remove('_id');
    await SharedPrefs.remove('token');
    await SharedPrefs.remove('email');
    await SharedPrefs.remove('first_name');
    await SharedPrefs.remove('last_name');

    return true;
  }
}
