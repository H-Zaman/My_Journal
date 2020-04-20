import 'package:flutter/material.dart';
import 'package:myapp/Dashboard/dashboard.dart';
import 'package:myapp/fab_circular_menu/fab_custom.dart';
import 'package:myapp/fab_circular_menu/fab_lee.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Dashboard(),
    floatingActionButton: Padding(
      padding: const EdgeInsets.only(left: 34.0),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: CustomFabLee()
      ),
    ),
    );
  }
}


