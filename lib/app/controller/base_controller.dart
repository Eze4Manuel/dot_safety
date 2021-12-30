

import 'dart:convert';

import 'package:dot_safety/app/model/states.dart';
import 'package:dot_safety/app/utils/load_json_file.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class BaseController extends GetxController {

  List listValue = [].obs;

  RxString message = ''.obs;
  final RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  setMessage(msg){
    message.value = msg;
  }

  //------------ Stores data locally using Shared prefs ------------//
  Future<bool> storeUserDetails(body, listKeys) async {
    await listKeys.map((key) async =>
    await SharedPrefs.saveString(key, body[key])
    );
    return true;
  }

  sendHttpRequest( url, data, httpMethod) async {
    // unsetting messages
    setMessage('');
    try {
      print("processing");
      var response;

      switch(httpMethod){
        case 'get':
          response =
          await http.get(
              url,
              headers: {"Accept": "*/*", "Content-Type": "application/json"});
          break;

        case 'put':
          response =
          await http.put(
              url,
              headers: {"Accept": "*/*", "Content-Type": "application/json"},
              body: jsonEncode(data));
          break;

        default:
          response =
          await http.post(
              url,
              headers: {"Accept": "*/*", "Content-Type": "application/json"},
              body: jsonEncode(data));
      }
      print('Response status: ${response.statusCode}');
      print('Response body: ${jsonDecode(response.body)}');

      if(jsonDecode(response.body)['status'] == 'success') return jsonDecode(response.body)['data'];
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




  sendAuthorizedHttpRequest( url, data, httpMethod) async {
    // unsetting messages
    setMessage('');
    try {
      print("processing");

      var token = await SharedPrefs.readSingleString('token');
      var response;
      switch(httpMethod){

        case 'get':
          response =
          await http.get(
              url,
              headers: {
                "Accept": "*/*",
                "Content-Type": "application/json",
                "Authorization": "Bearer ${token}"
              });
          print(response);

          break;
        case 'put':
          response =
          await http.put(
              url,
              headers: {
                "Accept": "*/*",
                "Content-Type": "application/json",
                "Authorization": "Bearer ${token}"
              },
              body: jsonEncode(data));
          break;
        case 'delete':
          response =
          await http.delete(
              url,
              headers: {
                "Accept": "*/*",
                "Content-Type": "application/json",
                "Authorization": "Bearer ${token}"
              },
             );
          break;

        default:
           response =
          await http.post(
              url,
              headers: {
                "Accept": "*/*",
                "Content-Type": "application/json",
                "Authorization": "Bearer ${token}"
              },
              body: jsonEncode(data));
          break;
      }

      print('Response status: ${response.statusCode}');
      print('Response body: ${jsonDecode(response.body)}');

      if(jsonDecode(response.body)['status'] == 'success') return jsonDecode(response.body)['data'];
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


  // Parsing the readfile to json
  Future parseJson() async {
    //Loading LoadJsonFile from service folder load_json_file
    String jsonString = await LoadJsonFile.loadFile();
    final jsonResponse = jsonDecode(jsonString);
    if (jsonResponse != null) {
      jsonResponse.forEach((element) {
        States state = new States(
            name: element["state"]["name"],
            id: element["state"]["id"],
            locals: element["state"]["locals"]);
        listValue.add(state);
      });
    }
  }

}