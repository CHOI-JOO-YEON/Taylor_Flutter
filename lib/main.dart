import 'package:flutter/material.dart';
import 'package:flutter_kiosk_new/page/main_page.dart';
import 'package:flutter/services.dart';
void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(


      home: MainPage()
    );
  }
}
