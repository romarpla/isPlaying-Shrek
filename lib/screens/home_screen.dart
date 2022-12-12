import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platformChannel = MethodChannel('flutter.methodchannel/iOS');
  bool isPlaying = false;

  Future<void> music(String action) async {
    try {
      await platformChannel.invokeMethod(action);
    } catch (e) {
      rethrow;
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
                  const Text(
                    'Listen to this JAM!!!',
                    style: TextStyle(fontSize: 20),
                  ),
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
                      music('stopMusic');
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
                  const Text(
                    'You are not playing any music',
                    style: TextStyle(fontSize: 20),
                  ),
                  Image.network(
                    'https://pbs.twimg.com/media/Emi0b6sXYAAsb03.jpg',
                  ),
                  ElevatedButton(
                    onPressed: () {
                      isPlaying = !isPlaying;
                      setState(() {});
                      music('playMusic');
                    },
                    child: const Text('Start Playing'),
                  )
                ],
              ),
            ),
    );
  }
}
