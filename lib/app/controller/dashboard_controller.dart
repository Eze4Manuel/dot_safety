import 'dart:io';
import 'dart:math';
import 'package:dot_safety/app/controller/base_controller.dart';
import 'package:http/http.dart' as http;
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class DashboardController extends BaseController {
  RxBool loading = false.obs;
  RxList lawEnforcementAgencies = [].obs;


  Future<bool> getAgencyList() async {
    var url = Uri.parse('${Strings.domain}api/regulation/get_agency_list');

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, {}, 'get');

    if (result == false) {
      return result;
    } else {
      lawEnforcementAgencies.value = result;
      return Future<bool>.value(true);
    }
    return false;
  }

  Future<bool> makePayment(data) async {
    var url = Uri.parse('${Strings.domain}api/payment/make_payment');

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, data, 'post');

    if (result == false) {
      return result;
    } else {
      setMessage("Payment Made Successfully");
      return Future<bool>.value(true);
    }
    return false;
  }

  Future<bool> updateComment(_id, String comment) async {
    var data;
    var url = Uri.parse('${Strings.domain}api/payment/update_comment');
    data = {
      "_id": _id,
      "comment": comment
    };

    print(data);

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, data, 'post');

    if (result == false) {
      return result;
    } else {
      setMessage("Comment Added");
      return Future<bool>.value(true);
    }
  }
}
