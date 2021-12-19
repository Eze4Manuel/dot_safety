
import 'dart:convert';

import 'package:dot_safety/app/model/states.dart';
import 'package:flutter/services.dart';

class LoadJsonFile {

  //Handling "local-government.json file reading"
  static Future<String> loadFile() async {
    return await rootBundle.loadString("assets/localgovernments.json");
  }

  //Parsing the readfile to json
  static Future parseJson( List stateList ) async {
    //Loading LoadJsonFile from service folder load_json_file
    String jsonString = await LoadJsonFile.loadFile();
    final jsonResponse = jsonDecode(jsonString);
    if (jsonResponse != null) {
      jsonResponse.forEach((element) {
        States state = new States(name: element["state"]["name"], id: element["state"]["id"], locals: element["state"]["locals"]);
        stateList.add(state);
      });
    }
  }


}