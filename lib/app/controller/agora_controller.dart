import 'dart:convert';
import 'dart:io';
import 'package:dot_safety/app/controller/base_controller.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class AgoraController extends BaseController {
  RxBool loading = false.obs;
  RxList lawEnforcementAgencies = [].obs;

  String rtcToken = '';

  late String resourceID;
  late String start_resourceID;
  late String start_sid;

  late String activeChannelName = '';
  late String activeChannelAppID = '';
  late String activeChannelCertificate = '';
  late String activeTempToken = '';
  late String activeFirstName = '';
  late String activeLastName = '';
  late String activeImagePath = '';

  late var activelivestreams = [];




  // Generating active session tokens
  Future<String> getSessionToken(String channelID, String channelCertificate, String cname, int recordingID, String role) async {
    var data = {
      "app_id": channelID,
      "app_certificate": channelCertificate,
      "channel_name": cname,
    };

    var url = Uri.parse(
        '${Strings.domain}access-token?channelName=$cname&uid=$recordingID&role=$role');
    print(url);
    var token = await SharedPrefs.readSingleString('token');

    var result = await http.post(url, headers: {
      "Accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    },
    body: jsonEncode(data)
    );

    print('Response status: ${result.statusCode}');

    if (result.statusCode == 200) {
      print(jsonDecode(result.body)['token']);
      return jsonDecode(result.body)['token'];
    } else {
      return '';
    }
  }



  // Getting available channels
  Future<bool> getAvailableChannel() async {
    var _id = await SharedPrefs.readSingleString('_id');

    var url = Uri.parse(
        '${Strings.domain}agora-cloud/get-channel?user_id=$_id');
    print(url);
    var token = await SharedPrefs.readSingleString('token');

    var result = await http.get(url, headers: {
      "Accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    print('Response status: ${result.statusCode}');
    print('Response Body: ${jsonDecode(result.body)}');

    if (result.statusCode == 200) {
      activeChannelName = jsonDecode(result.body)['data']['channel_name'];
      activeChannelAppID = jsonDecode(result.body)['data']['app_id'];
      activeChannelCertificate = jsonDecode(result.body)['data']['app_certificate'];
      activeTempToken = jsonDecode(result.body)['data']['temp_token'];
      activeFirstName = jsonDecode(result.body)['data']['first_name'];
      activeLastName = jsonDecode(result.body)['data']['last_name'];
      activeImagePath = jsonDecode(result.body)['data']['image_path'];


      return true ;
    } else {
      setMessage(jsonDecode(result.body)['msg']);
      return false;
    }
  }



  // Getting Active Livestreams
  Future<bool> getActiveLivestreams() async {

    var url = Uri.parse(
        '${Strings.domain}agora-cloud/getlivestreams');
    print(url);
    var token = await SharedPrefs.readSingleString('token');

    var result = await http.get(url, headers: {
      "Accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    print('Response status: ${result.statusCode}');
    print('Response Body: ${jsonDecode(result.body)}');

    if (result.statusCode == 200) {

      activelivestreams = jsonDecode(result.body)['data'];

      return true;
    } else {
      setMessage(jsonDecode(result.body)['msg']);
      return false;
    }
  }



  // Agora call to Acquire Livestream Recording
  Future<bool> getResourceIDAcquire(String cname, String recordingID, int agoraUid ) async {
    var url = Uri.parse(
        '${Strings.agoraDaomin}v1/apps/${Strings.APP_ID}/cloud_recording/acquire');

    print('agoraUid');
    print(agoraUid);

    var data = {
      "cname": cname,
      "uid": recordingID.toString(),
      "clientRequest": {
        "resourceExpiredHour": 24,
      }
    };

    // Sending parameters to http request. Implemented in base controller
    var result = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
          "Basic MDYxYjgxMzk2NWYzNDFkYjg5NDM3OWI1ZTdlMGY1MDk6ZDUwMGVjMjM4NTFjNGQ1YWJmOTc0NDliYmFmNjAxYTU="
        },
        body: jsonEncode(data));
    print(url);
    print(jsonEncode(data));

    print('Response status: ${result.statusCode}');
    print('Response body: ${jsonDecode(result.body)}');

    if (result.statusCode == 200) {
      print(url);
      resourceID = jsonDecode(result.body)['resourceId'];
      return true;
    } else {
      setMessage(jsonDecode(result.body)['message']);
      print(url);
      return false;
    }
  }


  // Agora call to Start Livestream Recording
  Future<bool> getResourceIDStart(String cname, String recordingID, int agoraUid, String role) async {
    // var rtctoken = await getSessionToken(cname, recordingID, role);

    var url = Uri.parse(
        '${Strings.agoraDaomin}v1/apps/${Strings.APP_ID}/cloud_recording/resourceid/${resourceID}/mode/mix/start');

    print(agoraUid);
    print('agoraUid');

    var data = {
      "cname": cname,
      "uid": recordingID.toString(),
      "clientRequest": {
        "token": Strings.rtcToken,
        "recordingConfig": {
          "maxIdleTime": 30,
          "streamTypes": 2,
          "channelType": 0,
          "videoStreamType": 0,
          "transcodingConfig": {
            "height": 640,
            "width": 360,
            "bitrate": 500,
            "fps": 15,
            "mixedVideoLayout": 1,
            "backgroundColor": "#FFFFFF"
          },
        },
        "recordingFileConfig": {
          "avFileType": ["hls", "mp4"],
        },
        "storageConfig": {
          "vendor": 1,
          "region": 1,
          "bucket": Strings.bucket,
          "accessKey": Strings.accessKey,
          "secretKey": Strings.secretKey,
          "fileNamePrefix": ["directory1", "directory2"],
        }
      }
    };

    // Sending parameters to http request. Implemented in base controller
    var result = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
          "Basic MDYxYjgxMzk2NWYzNDFkYjg5NDM3OWI1ZTdlMGY1MDk6ZDUwMGVjMjM4NTFjNGQ1YWJmOTc0NDliYmFmNjAxYTU="
        },
        body: jsonEncode(data));
    print(url);

    print('Response status: ${result.statusCode}');
    print('Response body: ${jsonDecode(result.body)}');

    if (result.statusCode == 200) {
      print(url);
      start_resourceID = jsonDecode(result.body)['resourceId'];
      start_sid = jsonDecode(result.body)['sid'];
      return true;
    } else {
      setMessage(jsonDecode(result.body)['message']);
      print(url);
      return Future<bool>.value(false);
    }
  }


  // Agora call to End Livestream Recording
  Future<bool> endCall(cname, recordingID) async {
    var url = Uri.parse(
        '${Strings.agoraDaomin}v1/apps/${Strings.APP_ID}/cloud_recording/resourceid/${start_resourceID}/sid/$start_sid/mode/mix/stop');

    var data = {
      "cname": cname,
      "uid": recordingID.toString(),
      "clientRequest":{
      }
    };

    // Sending parameters to http request. Implemented in base controller
    var result = await http.post(url,
        headers: {
          "Content-Type": "application/json;charset=utf-8",
          "Authorization":
          "Basic MDYxYjgxMzk2NWYzNDFkYjg5NDM3OWI1ZTdlMGY1MDk6ZDUwMGVjMjM4NTFjNGQ1YWJmOTc0NDliYmFmNjAxYTU="
        },
        body: jsonEncode(data));

    print(url);

    print('Response status: ${result.statusCode}');
    print('Response body: ${jsonDecode(result.body)}');

    if (result.statusCode == 200) {
      // start_resourceID = jsonDecode(result.body)['resourceId'];
      // start_sid = jsonDecode(result.body)['sid'];
      return true;
    } else {
      setMessage('Recording Stopped');
      return Future<bool>.value(true);
    }
  }


  // Agora call to Query the lLivestream Recording
  Future<bool> queryStream(cname, recordingID) async {
    var url = Uri.parse(
        '${Strings.agoraDaomin}v1/apps/${Strings.APP_ID}/cloud_recording/resourceid/${start_resourceID}/sid/$start_sid/mode/mix/query');


    // Sending parameters to http request. Implemented in base controller
    var result = await http.get(url,
        headers: {
          "Content-Type": "application/json;charset=utf-8",
          "Authorization":
          "Basic MDYxYjgxMzk2NWYzNDFkYjg5NDM3OWI1ZTdlMGY1MDk6ZDUwMGVjMjM4NTFjNGQ1YWJmOTc0NDliYmFmNjAxYTU="
        },
       );

    print(url);

    print('Response status: ${result.statusCode}');
    print('Response body: ${jsonDecode(result.body)}');

    if (result.statusCode == 200) {
      // start_resourceID = jsonDecode(result.body)['resourceId'];
      // start_sid = jsonDecode(result.body)['sid'];
      return true;
    } else {
      setMessage(jsonDecode(result.body)['message'] ?? '');
      return Future<bool>.value(false);
    }
  }



}
