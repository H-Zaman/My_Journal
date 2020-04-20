import 'package:flutter/material.dart';
import 'package:myapp/fab_circular_menu/fab_custom.dart';
import 'package:myapp/fab_circular_menu/fab_package.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'eyyy'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Align(

            alignment: Alignment.topCenter,
            child: CustomFab()),
      ),
    );
  }
}


