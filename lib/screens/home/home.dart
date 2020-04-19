import 'package:flutter/material.dart';
import 'package:myapp/fab_circular_menu/fab_custom.dart';
import 'package:myapp/fab_circular_menu/fab_package.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Align(

            alignment: Alignment.topCenter,
            child: CustomFab()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Center(child: PackageFab()),
    );
  }
}


