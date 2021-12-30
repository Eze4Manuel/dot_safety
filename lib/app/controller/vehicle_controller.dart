
import 'package:dot_safety/app/controller/base_controller.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class VehicleController extends BaseController {
  RxBool loading = false.obs;

  List vehicles = [];

  var currentVehicle;

  Future<bool> vehicleCreate(String vehicle_type, String vehicle_name, String vehicle_year, String vehicle_plate_number, String vehicle_color) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/vehicle/vehicle_register');

    data = {
      "vehicle_name": vehicle_name,
      "vehicle_type": vehicle_type,
      "vehicle_color": vehicle_color,
      "vehicle_plate_number": vehicle_plate_number,
      "vehicle_year": vehicle_year,
      "user_id": await SharedPrefs.readSingleString('_id')
    };

    print(data);

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, data, 'post');
    if (result == false) {
      return result;
    } else {

      vehicles.add(result);
      currentVehicle = result;
      setMessage("Vehicle Created");
      return Future<bool>.value(true);
    }
    return false;
  }


  Future<bool> goodsCreate(String name_of_goods, String category_of_goods, String goods_shortnote) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/vehicle/goods_register');
    data = {
      "name_of_goods": name_of_goods,
      "category_of_goods": category_of_goods,
      "goods_shortnote": goods_shortnote,
      "user_id": await SharedPrefs.readSingleString('_id')
    };

    print(data);

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
      var user_id = await SharedPrefs.readSingleString('_id');

      var url = Uri.parse('${Strings.domain}api/vehicle/get_vehicles?user_id=${user_id}');
      print(url);

      // Sending parameters to http request. Implemented in base controller
      var result = await sendAuthorizedHttpRequest(url, {}, 'get');

      if (result == false) {
        return result;
      } else {
        vehicles.addAll(result);
        print(vehicles);
        setMessage("Goods Creation Success");
        return Future<bool>.value(true);
      }
    }
  }

  Future<bool> deleteVehicle(String vehicle_id) async {


      var url = Uri.parse('${Strings.domain}api/vehicle/delete_vehicle/${vehicle_id}');
      print(url);

      // Sending parameters to http request. Implemented in base controller
      var result = await sendAuthorizedHttpRequest(url, {}, 'delete');

      if (result == false) {
        return result;
      } else {
        vehicles.removeWhere((elem)=> elem['_id'] == vehicle_id );
        print(vehicles);
        setMessage("Vehicle Deleted Success");
        return Future<bool>.value(true);
      }
  }


  Future<bool> vehicleUpdate(String vehicle_type, String vehicle_name, String vehicle_year, String vehicle_plate_number, String vehicle_color, String vehicle_id) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}api/vehicle/vehicle_update');

    data = {
      "vehicle_name": vehicle_name,
      "vehicle_type": vehicle_type,
      "vehicle_color": vehicle_color,
      "vehicle_plate_number": vehicle_plate_number,
      "vehicle_year": vehicle_year,
      "_id": vehicle_id
    };

    print(url);

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, data, 'put');
    if (result == false) {
      return result;
    } else {

      int indexElement = vehicles.indexWhere((element) => (element['_id'] == vehicle_id));
      vehicles.replaceRange(indexElement, indexElement + 1, [result]);

      setMessage("Vehicle Update Success");
      return Future<bool>.value(true);
    }
    return false;
  }




}
