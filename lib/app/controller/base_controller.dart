

import 'dart:convert';

import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class BaseController extends GetxController {

  RxString message = ''.obs;
  final RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  setMessage(msg){
    message.value = msg;
    print(message.value);
  }

  //------------ Stores data locally using Shared prefs ------------//
  Future<bool> storeUserDetails(body, listKeys) async {
    await listKeys.map((key) async =>
    await SharedPrefs.saveString(key, jsonEncode(body[key]))
    );
    return true;
  }

  sendHttpRequest( url, data) async {
    // unsetting messages
    setMessage('');

    try {
      print("processing");
      var response =
      await http.post(
          url,
          headers: {"Accept": "*/*", "Content-Type": "application/json"},
          body: jsonEncode(data));
      print('Response status: ${response.statusCode}');
      print('Response body: ${jsonDecode(response.body)}');

      if(jsonDecode(response.body)['status'] == 'success') return data;
      else{
        setMessage(jsonDecode(response.body)['msg']);
        return Future<bool>.value(false);
      }

    }catch(e){
      print(e);
      setMessage("Something went wrong");
      return Future<bool>.value(false);
    }
  }
}