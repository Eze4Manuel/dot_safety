
import 'dart:convert';
import 'dart:io';

import 'package:dot_safety/app/controller/base_controller.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;

class VehicleController extends BaseController {
  RxBool loading = false.obs;

  List vehicles = [];
  List documents = [];
  List tempDocs = [];
  List edittedDocuments = [];

  var currentVehicle;

  Future<bool> vehicleCreate(String vehicleType, String vehicleName, String vehicleYear, String vehiclePlateNumber, String vehicleColor) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/vehicle/vehicle_register');

    data = {
      "vehicle_name": vehicleName,
      "vehicle_type": vehicleType,
      "vehicle_color": vehicleColor,
      "vehicle_plate_number": vehiclePlateNumber,
      "vehicle_year": vehicleYear,
      "user_id": await SharedPrefs.readSingleString('_id')
    };

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, data, 'post');
    if (result == false) {
      return result;
    } else {
      vehicles.addNonNull(result);
      currentVehicle = result;
      setMessage("Vehicle Created");
      return Future<bool>.value(true);
    }
    return false;
  }


  Future<bool> goodsCreate(String nameOfGoods, String categoryOfGoods, String goodsShortnote) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/vehicle/goods_register');
    data = {
      "name_of_goods": nameOfGoods,
      "category_of_goods": categoryOfGoods,
      "goods_shortnote": goodsShortnote,
      "user_id": await SharedPrefs.readSingleString('_id')
    };

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, data, 'post');
    if (result == false) {
      return result;
    } else {
      setMessage("Goods Creation Success");
      return Future<bool>.value(true);
    }
    return false;
  }

  Future<bool> getUploadedVehicled() async {
    if(vehicles.isNotEmpty){
      return true;
    }else{
      var userId = await SharedPrefs.readSingleString('_id');

      var url = Uri.parse('${Strings.domain}api/vehicle/get_vehicles?user_id=$userId');
      print(url);

      // Sending parameters to http request. Implemented in base controller
      var result = await sendAuthorizedHttpRequest(url, {}, 'get');

      if (result == false) {
        return result;
      } else {
        vehicles.addAll(result);
        setMessage("Goods Creation Success");
        return Future<bool>.value(true);
      }
    }
  }

  Future<bool> deleteVehicle(String vehicleId) async {


      var url = Uri.parse('${Strings.domain}api/vehicle/delete_vehicle/$vehicleId');
      print(url);

      // Sending parameters to http request. Implemented in base controller
      var result = await sendAuthorizedHttpRequest(url, {}, 'delete');

      if (result == false) {
        return result;
      } else {
        vehicles.removeWhere((elem)=> elem['_id'] == vehicleId );
        setMessage("Vehicle Deleted Success");
        return Future<bool>.value(true);
      }
  }


  Future<bool> vehicleUpdate(String vehicleType, String vehicleName, String vehicleYear, String vehiclePlateNumber, String vehicleColor, String vehicleId) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/vehicle/vehicle_update');

    data = {
      "vehicle_name": vehicleName,
      "vehicle_type": vehicleType,
      "vehicle_color": vehicleColor,
      "vehicle_plate_number": vehiclePlateNumber,
      "vehicle_year": vehicleYear,
      "_id": vehicleId
    };

    print(url);

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, data, 'put');
    if (result == false) {
      return result;
    } else {

      int indexElement = vehicles.indexWhere((element) => (element['_id'] == vehicleId));
      vehicles.replaceRange(indexElement, indexElement + 1, [result]);

      setMessage("Vehicle Update Success");
      return Future<bool>.value(true);
    }
    return false;
  }



  Future<bool> asyncDocumentUpload (String text, String expiryDate, String documentType, File file) async {
    var url = Uri.parse('${Strings.domain}api/vehicle/upload_vehicle_document');

    print(url);

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
    request.fields["user_id"] = _id;
    request.fields["vehicle_id"] = text;
    request.fields["expiry_date"] = expiryDate;
    request.fields["document_type"] = documentType;

    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("document_image", file.path);
    //add multipart to request
    request.files.add(pic);


    var response = await request.send();


    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var result = jsonDecode(responseString);


    if (documents.isEmpty) {
      documents.addNonNull({
        "expiry_date": result['data']['expiry_date'],
        "document_type": result['data']['document_type'],
        "images": [result['data']['image_url']]
      });
    } else {
      // Getting index of element
      var ind = documents.indexWhere((element) =>
      element['document_type'] == result['data']['document_type']);

      // If element doesn't exist in list add it
      if (ind == -1) {
        documents.addNonNull({
          "expiry_date": result['data']['expiry_date'],
          "document_type": result['data']['document_type'],
          "images": [result['data']['image_url']]
        });
      }else{

        // if element exists, update it
        var element = documents.elementAt(ind);
        element['images'] = [...element['images'], result['data']['image_url']];

        documents.replaceRange(ind, ind + 1, [element]);
      }
    }

    setMessage('Document Upload Success');
    return true;
  }



  Future<bool> getUploadedDocument(String vehicleId) async {

      var url = Uri.parse('${Strings.domain}api/vehicle/get_documents?vehicle_id=$vehicleId');
      print(url);
      // Sending parameters to http request. Implemented in base controller
      var result = await sendAuthorizedHttpRequest(url, {}, 'get');
      if (result == false) {
        return result;
      } else {
        edittedDocuments = result;

        // setMessage("Goods Creation Success");
        return Future<bool>.value(true);
      }
  }


  Future<bool> deleteDocument( String documentId) async {
    var url = Uri.parse('${Strings.domain}api/vehicle/delete_document/$documentId');

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, {}, 'delete');

    if (result == false) {
      return result;
    } else {

      // edittedDocuments.removeWhere((elem)=> elem['_id'] == documentId );
      setMessage("Document Deleted Success");
      return Future<bool>.value(true);
    }
    return false;
  }


}
