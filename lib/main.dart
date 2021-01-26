import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/views/fullscreenmap.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Materal App',
      home: Scaffold(
        body: FullScreenMap(),
      ),
    );
  }
}
