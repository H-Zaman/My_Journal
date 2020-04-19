import 'package:flutter/material.dart';
import 'package:myapp/screens/home/home.dart';

//Wrapper decides based on if the device has internet connection or not
// where to go, If it has internet goes to HomeScreen else goes to a tempPage

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
