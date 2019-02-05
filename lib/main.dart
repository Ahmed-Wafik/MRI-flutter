import 'package:flutter/material.dart';
import 'package:mri_booking/pages/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MRI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          
          accentColor:Color.fromRGBO(0, 160, 163, 1)
      ),
          // accentColor: Color.fromRGBO(0, 160, 163, 1)),
      home: HomePage(),
    );
  }
}
          // accentColor: Color.fromRGBO(0, 160, 163, 1)), treacawz
      //  Color.fromRGBO(236, 28, 63, 1)) red