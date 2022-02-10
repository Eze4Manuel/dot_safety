import 'dart:async';

import 'package:dot_safety/app/controller/agora_controller.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/ui/theme/app_strings.dart';
import 'package:dot_safety/app/utils/device_utils.dart';
import 'package:dot_safety/app/utils/shared_prefs.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'dart:math';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socket_io_client/socket_io_client.dart';

class BroadcastPage extends StatefulWidget {
  final String channelName;
  final bool isBroadcaster;
  final String uid;
  final String rtcToken;
  final Socket socket;
  final String app_ID;

  const BroadcastPage({required this.channelName, required this.isBroadcaster, required this.uid, required this.rtcToken, required this.socket, required this.app_ID});

  @override
  _BroadcastPageState createState() => _BroadcastPageState();
}

class _BroadcastPageState extends State<BroadcastPage> {
  AgoraController agoraController = Get.put(AgoraController());

  final _users = <int>[];
  late RtcEngine _engine;
  bool muted = false;
  late int streamId;

  var now = new DateTime.now();

  late String path;
  late int currentTime;

  var agoraUid;

  String text = '';
  bool recording = false;
  bool allSet = false;


  @override
  void initState() {
    super.initState();

    // initialize agora sdk
    initializeAgora();

  }

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk and leave channel
    _engine.destroy();
    super.dispose();
  }

  Future<void> getResourceIDAcquire() async {
    agoraUid = int.parse(widget.uid) + 2;

    var acquire = await agoraController.getResourceIDAcquire(
        Strings.cname, widget.uid, agoraUid);
    print('acquire');
    print(acquire);
    if (acquire) {
      var start = await agoraController.getResourceIDStart(
          Strings.cname, widget.uid, agoraUid, (widget.isBroadcaster) ? 'publisher' : 'subscriber');
      print(start);



       // Sending an emit of livestream
       widget.socket.emit('liveStream', {
         'cname': agoraController.activeChannelName,
         'app_id': agoraController.activeChannelAppID,
         'app_certificate': agoraController.activeChannelCertificate,
         'temp_token': agoraController.activeTempToken,
         'first_name': agoraController.activeFirstName,
         'last_name': agoraController.activeLastName,
         'image_path': agoraController.activeImagePath,
         'started_at': DateTime.now().toIso8601String(),
       });
       toast('Recording Start Called');

    } else {
      toast('Something went wrong with recording');
      setState(() {
        recording = false;
        allSet = false;
      });
    }
  }


    Future<void> initializeAgora() async {
    print(widget.app_ID);

        await _initAgoraRtcEngine(widget.app_ID);

        if (widget.isBroadcaster)
          streamId = (await _engine.createDataStream(false, false))!;

        _engine.setEventHandler(RtcEngineEventHandler(
          joinChannelSuccess: (channel, uid, elapsed) {
            setState(() {
              print('onJoinChannel: $channel, uid: $uid');
            });
          },
          leaveChannel: (stats) {
            setState(() {
              print('onLeaveChannel');
              _users.clear();
            });
          },
          userJoined: (uid, elapsed) {
            setState(() {
              print('userJoined: $uid');

              _users.add(uid);
            });
          },
          userOffline: (uid, elapsed) {
            setState(() {
              toast('Livestream Ended');
              print('userOffline: $uid');
              _users.remove(uid);
            });
          },
          streamMessage: (_, __, message) {
            final String info = "here is the message $message";
            print(info);
          },
          streamMessageError: (_, __, error, ___, ____) {
            final String info = "here is the error $error";
            print(info);
          },
        ));

        await _engine.joinChannel(widget.rtcToken, widget.channelName, null, int.parse(widget.uid));

        if(widget.isBroadcaster){
          getResourceIDAcquire();
        }
        setState(() {
          allSet = true;
        });
  }

  Future<void> _initAgoraRtcEngine(app_id) async {
    _engine = await RtcEngine.create(app_id);
      await _engine.enableVideo();

      await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
      if (widget.isBroadcaster) {
        await _engine.setClientRole(ClientRole.Broadcaster);
      } else {
        await _engine.setClientRole(ClientRole.Audience);
      }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPop(context),
      child: Scaffold(
        body: Center(
            child: allSet
                ? Stack(
                    children: <Widget>[
                      _broadcastView(),
                      _toolbar(),
                    ],
                  )
                : Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  )),
      ),
    );
  }

  Widget _toolbar() {
    return widget.isBroadcaster
        ? Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: _onToggleMute,
                  child: Icon(
                    muted ? Icons.mic_off : Icons.mic,
                    color: muted ? Colors.white : Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: muted ? Colors.blueAccent : Colors.white,
                  padding: const EdgeInsets.all(12.0),
                ),
                RawMaterialButton(
                  onPressed: () => {_onCallEnd(context)},
                  child: Icon(
                    Icons.call_end,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.redAccent,
                  padding: const EdgeInsets.all(15.0),
                ),

                ///Check Record Button

                RawMaterialButton(
                  onPressed: _onSwitchCamera,
                  child: Icon(
                    Icons.switch_camera,
                    color: Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                ),
              ],
            ),
          )
        : Container();
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.isBroadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  /// Video view row wrapper
  Widget _expandedVideoView(List<Widget> views) {
    final wrappedViews = views
        .map<Widget>((view) => Expanded(child: Container(child: view)))
        .toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _broadcastView() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            height: DeviceUtils.getScaledHeight(context, scale: 1),
            width: DeviceUtils.getScaledWidth(context, scale: 1),
            child: Column(
              children: <Widget>[
                _expandedVideoView([views[0]])
              ],
            ));
      case 2:
        return Container(
            height: DeviceUtils.getScaledHeight(context, scale: 1),
            width: DeviceUtils.getScaledWidth(context, scale: 1),
            child: Column(
              children: <Widget>[
                _expandedVideoView([views[0]]),
                _expandedVideoView([views[1]])
              ],
            ));
      case 3:
        return Container(
            height: DeviceUtils.getScaledHeight(context, scale: 1),
            width: DeviceUtils.getScaledWidth(context, scale: 1),
            child: Column(
              children: <Widget>[
                _expandedVideoView(views.sublist(0, 2)),
                _expandedVideoView(views.sublist(2, 3))
              ],
            ));
      case 4:
        return Container(
            height: DeviceUtils.getScaledHeight(context, scale: 1),
            width: DeviceUtils.getScaledWidth(context, scale: 1),
            child: Column(
              children: <Widget>[
                _expandedVideoView(views.sublist(0, 2)),
                _expandedVideoView(views.sublist(2, 4))
              ],
            ));
      default:
    }
    return Container();
  }

  Future<void> _onCallEnd(BuildContext context) async {
    if (await agoraController.endCall(Strings.cname, int.parse(widget.uid))) {
        _willPop(context);
    } else {
      toast('Unable to end call');
    }
  }

  Future<void> _onToggleMute() async {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    agoraController.queryStream(Strings.cname, int.parse(widget.uid));

    // if (streamId != null) _engine.sendStreamMessage(streamId, "mute user blet");
    // _engine.switchCamera();
  }

  Future<bool> _willPop(BuildContext context) {
    final completer = Completer<bool>();

    // Sending an emit of livestream
    widget.socket.emit('end-liveStream', {
      'cname': agoraController.activeChannelName,
      'app_id': agoraController.activeChannelAppID,
      'temp_token': agoraController.activeTempToken,
      'first_name': agoraController.activeFirstName,
      'last_name': agoraController.activeLastName,
      'image_path': agoraController.activeImagePath,
      'started_at': DateTime.now().toIso8601String(),
    });
    completer.complete(true);
    Navigator.of(context).pop();

    return completer.future;
  }

}
