import 'package:dot_safety/app/ui/pages/dashboard/broadcast_page.dart';
import 'package:dot_safety/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:highlight_text/highlight_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:permission_handler/permission_handler.dart';

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {

  List<String> testWords = ['kidnap', 'accident', 'traffic offence'];

  final Map<String, HighlightedWord> _highlights = {
    'kidnap': HighlightedWord(
      onTap: () => print('kidnap'),
      textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontFamily: 'Montserrat Bold',
          color: AppColors.color7),
    ),
    'accident': HighlightedWord(
      onTap: () => print('accident'),
      textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontFamily: 'Montserrat Bold',
          color: AppColors.color7),
    ),
    'traffic': HighlightedWord(
      onTap: () => print('traffic'),
      textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
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
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if(testWords.contains(val.recognizedWords)){
              onJoin(isBroadcaster: true);

            }
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }else{
        setState(() => _isListening = false);
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }



  // This method is used by the live stream broadcaster
  Future<void> onJoin({required bool isBroadcaster}) async {
    await [Permission.camera, Permission.microphone].request().then((value) => print(value)).catchError((onError){
      print(onError);
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BroadcastPage(
          channelName: 'Dotsafety',
          isBroadcaster: isBroadcaster,
        ),
      ),
    );
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
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        // repeat: true,
        child: FloatingActionButton(
          backgroundColor: AppColors.appPrimaryColor,
          onPressed: _listen,
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