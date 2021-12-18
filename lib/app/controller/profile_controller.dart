import 'dart:convert';
import 'dart:io';
import 'package:dot_safety/app/controller/base_controller.dart';
import 'package:http/http.dart' as http;
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ProfileController extends BaseController {
  RxBool loading = false.obs;

  Future<bool> changePassword( String old_password, String new_password ) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/user/change_password');

    data = {
      "old_password": old_password,
      "new_password": new_password,
      "_id": await SharedPrefs.readSingleString('_id')
    };
    print(data);

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, data, 'post');
    if (result == false) {
      return result;
    } else {
      setMessage("Password Change Success");
      return Future<bool>.value(true);
    }
    return false;
  }

  Future<bool> asyncFileUpload (String text, File file) async {

    var url = Uri.parse('${Strings.domain}api/profile/upload_image_profile');

    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", url);

    var token = await SharedPrefs.readSingleString('token');
    var _id = await SharedPrefs.readSingleString('_id');

    // Adding headers
    Map<String, String> headers = {
      "Accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token}"
    };
    request.headers.addAll(headers);

    //add text fields
    request.fields["_id"] = _id;
       //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("image", file.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    setMessage('Profile Image Uploaded');
    return true;
  }
}
