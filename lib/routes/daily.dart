import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'dailyEntity.dart';

class Daily extends ConsumerWidget {
  Daily({
    Key? key,
  }) : super(key: key) {
    //コンストラクタ
  }

  final myController = TextEditingController();
  SpeechToText _speechToText = SpeechToText();
  String _lastWords = '';
  bool _speechEnabled = false;
  bool initialProcessFlg =true;

  /// This has to happen only once per app
  void _initSpeech(WidgetRef ref) async {
    _speechEnabled = await _speechToText.initialize();
    ref.watch(dailyPageDataProvider.notifier).rebuildWidget();
    // setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening(WidgetRef ref) async {
    await _speechToText.listen(onResult: _onSpeechResult);
    ref.watch(dailyPageDataProvider.notifier).rebuildWidget();
    //setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening(WidgetRef ref) async {
    await _speechToText.stop();
    ref.watch(dailyPageDataProvider.notifier).rebuildWidget();
    //setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
    // myController.text=myController.text+'\n$_lastWords';
    myController.text='$_lastWords';
    // ref.watch(dailyPageDataProvider.notifier).rebuildWidget();
    // setState(() {
    //   _lastWords = result.recognizedWords;
    // });
  }

  Widget build(BuildContext context, WidgetRef ref) {


    if(initialProcessFlg){
      initialProcessFlg=false;
      _initSpeech(ref);
    }
    // myController.text='$_lastWords';

    return Scaffold(
      appBar: AppBar(
        title: Text(ref.watch(dailyPageDataProvider).textForReload == ""
            ? 'Speech Demo'
            : 'Speech Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),Container(
                padding: EdgeInsets.all(16),
                child: Text('$_lastWords'
                  // If listening is active show the recognized words
                  // _speechToText.isListening
                  //     ? '$_lastWords'
                  //     // If listening isn't active but could be tell the user
                  //     // how to start it, otherwise indicate that speech
                  //     // recognition is not yet ready or not supported on
                  //     // the target device
                  //     : _speechEnabled
                  //         ? 'Tap the microphone to start listening...'
                  //         : 'Speech not available',
                ),
              ),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller:myController,
                decoration: InputDecoration(
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // If not yet listening for speech start, otherwise stop
          if (_speechToText.isNotListening) {
            _startListening(ref);
          } else {
            _stopListening(ref);
          }
        },
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}
