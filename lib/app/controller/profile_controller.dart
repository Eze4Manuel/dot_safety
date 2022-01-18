import 'dart:convert';
import 'dart:io';
import 'package:dot_safety/app/controller/base_controller.dart';
import 'package:http/http.dart' as http;
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ProfileController extends BaseController {
  RxBool loading = false.obs;

  List contacts = [];

  Future<bool> changePassword( String oldPassword, String newPassword ) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/user/change_password');

    data = {
      "old_password": oldPassword,
      "new_password": newPassword,
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
      "Authorization": "Bearer $token"
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
    var result = jsonDecode( responseString);
    print(result);
    SharedPrefs.saveString('image_url', result['data']['image_url']);
    setMessage('Profile Image Uploaded');
    return true;
  }


  Future<bool> addFamilyContact(String name, String phone_number) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/profile/add_contact');

    var user_id = await SharedPrefs.readSingleString('_id');

    print(user_id);

    print(url);
    data = {
      "user_id": user_id,
      "name": name,
      "phone_number": phone_number
    };

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, data, 'post');
    if (result == false) {
      return result;

    } else {

      setMessage("Added Contact Successfully");
      return Future<bool>.value(true);
    }
    return false;
  }

  Future<bool> getContacts() async {
    var user_id = await SharedPrefs.readSingleString('_id');

    var url = Uri.parse('${Strings.domain}api/profile/get_contacts/${user_id}');

    print(url);
    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, {}, 'get');

    if (result == false) {
      return result;
    } else {
      contacts = result ?? [];
      print(contacts);
      return Future<bool>.value(true);
    }
    return false;
  }
  Future<bool> updateFamilyContact(String name, String phone_number, int indexNumber) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/profile/update_contact');

    var user_id = await SharedPrefs.readSingleString('_id');

    print(indexNumber);
    data = {
      "user_id": user_id,
      "index_number": indexNumber,
      "name": name,
      "phone_number": phone_number
    };

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, data, 'put');
    if (result == false) {
      return result;
    } else {
      setMessage("Contact Updated Successfully");
      return Future<bool>.value(true);
    }
    return false;
  }


  Future<bool> deleteFamilyContact(int indexNumber) async {
    var user_id = await SharedPrefs.readSingleString('_id');
    var url = Uri.parse('${Strings.domain}api/profile/delete_contact/$indexNumber/$user_id');

    print(url);
    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, {}, 'delete');
    if (result == false) {
      return result;
    } else {
      setMessage("Contact Deleted Successfully");
      return Future<bool>.value(true);
    }
    return false;
  }

}
