import 'package:flutter/material.dart';
import 'package:myapp/screens/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context)=> Wrapper(),
      },

      debugShowCheckedModeBanner: false,
    );
  }
}