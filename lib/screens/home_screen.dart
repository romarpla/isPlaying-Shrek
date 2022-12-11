import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platformChannel =
      MethodChannel('test.flutter.methodchannel/iOS');
  bool isPlaying = false;

  Future<void> playMusic() async {
    String _model;
    try {
      final String result =
          await platformChannel.invokeMethod('getDeviceModel');
      _model = result;
    } catch (e) {
      _model = "Can't fetch the method: '$e'.";
    }
  }

  Future<void> stopMusic() async {
    String _model;
    try {
      final String result = await platformChannel.invokeMethod('stopMusic');
      _model = result;
    } catch (e) {
      _model = "Can't fetch the method: '$e'.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* AppBar
      appBar: AppBar(
        title: const Text('Make Shrek dance'),
        elevation: 0,
      ),

      //? Cambiar la pantalla
      body: isPlaying
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Listen that JAM'),
                  Image.network(
                    'https://www.icegif.com/wp-content/uploads/shrek-icegif.gif',
                    loadingBuilder: (context, child, loadingProgress) {
                      return loadingProgress == null
                          ? child
                          : const LinearProgressIndicator();
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      isPlaying = !isPlaying;
                      setState(() {});
                      stopMusic();
                    },
                    child: const Text('Stop playing'),
                  )
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('You are not playing any music'),
                  Image.network(
                    'https://pbs.twimg.com/media/Emi0b6sXYAAsb03.jpg',
                  ),
                  ElevatedButton(
                    onPressed: () {
                      isPlaying = !isPlaying;
                      setState(() {});
                      playMusic();
                    },
                    child: const Text('Start Playing'),
                  )
                ],
              ),
            ),
    );
  }
}
