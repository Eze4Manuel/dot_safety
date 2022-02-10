import 'package:dot_safety/app/controller/agora_controller.dart';
import 'package:dot_safety/app/ui/pages/dashboard/broadcast_page.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:dot_safety/app/utils/temp_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:highlight_text/highlight_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:permission_handler/permission_handler.dart';

class SpeechScreen extends StatefulWidget {
  Socket socket;

  SpeechScreen({required this.socket});

  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  List<String> testWords = ['kidnap', 'accident', 'traffic offence'];
  AgoraController agoraController = Get.put(AgoraController());
  late String uid;
  late String broadcast;
  late var rtcToken;

  final Map<String, HighlightedWord> _highlights = {
    'kidnap': HighlightedWord(
      onTap: () => print('kidnap'),
      textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          fontFamily: 'Montserrat Bold',
          color: AppColors.color7),
    ),
    'accident': HighlightedWord(
      onTap: () => print('accident'),
      textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          fontFamily: 'Montserrat Bold',
          color: AppColors.color7),
    ),
    'traffic': HighlightedWord(
      onTap: () => print('traffic'),
      textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          fontFamily: 'Montserrat Bold',
          color: AppColors.color7),
    ),
  };

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Listening';
  String vettedText = '';
  double _confidence = 1.0;

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => {
          print('onStatus: $val'),
          print(_isListening),
          if (val == 'done')
            {
              setState(() {
                _text = 'No Match Found';
                _isListening = false;
              })
            }
        },
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (testWords.contains(val.recognizedWords)) {
              onJoin(isBroadcaster: true);
            }
            // if (val.hasConfidenceRating && val.confidence > 0) {
            //   _confidence = val.confidence;
            // }
          }),
        );
      } else {
        setState(() => _isListening = false);
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Future<void> onJoin({required bool isBroadcaster}) async {

    uid = new DateTime.now().millisecondsSinceEpoch.toString();
    uid = uid.substring(uid.length - 4);


    broadcast = (isBroadcaster) ? 'publisher' : 'subscriber';

    if (await agoraController.getAvailableChannel()) {
      // send request to get user token session
      rtcToken = await agoraController.getSessionToken(
          agoraController.activeChannelAppID, agoraController.activeChannelCertificate, agoraController.activeChannelName, int.parse(uid), broadcast);

      if (rtcToken.length > 0 &&
          agoraController.activeChannelAppID.length > 0) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => BroadcastPage(
                channelName: agoraController.activeChannelName,
                isBroadcaster: isBroadcaster,
                uid: uid,
                rtcToken: rtcToken,
                socket: widget.socket,
                app_ID: agoraController.activeChannelAppID,
            ),
          ),
        );
      } else {
        toast('Something went wrong, Try again');
      }
    } else {
      toast(agoraController.message.value);
    }
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _listen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        // title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
        title: Text(''),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: AppColors.whiteColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 1000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        // repeat: true,
        child: FloatingActionButton(
          backgroundColor: AppColors.appPrimaryColor,
          onPressed: (){
            _listen();
          },
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: Center(
            child: TextHighlight(
              text: _text,
              words: _highlights,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  fontFamily: 'Montserrat Bold',
                  color: AppColors.whiteColor),
            ),
          ),
        ),
      ),
    );
  }
}
