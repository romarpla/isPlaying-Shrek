import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* AppBar
      appBar: AppBar(
        title: Text('Make Shrek dance'),
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
                      print('Pressed $isPlaying');
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
                      print('Pressed $isPlaying');
                    },
                    child: const Text('Start Playing'),
                  )
                ],
              ),
            ),
      // body: currentPage == 0
      //       ? CustomScreen(color:  Colors.pink )
      //       : currentPage == 1
      //           ? CustomScreen(color:  Colors.indigo )
      //           : CustomScreen(color:  Colors.green ),
    );
  }
}
