import 'package:flutter/material.dart';
import 'package:myapp/Dashboard/dashboard.dart';
import 'package:myapp/fab_circular_menu/fab_custom.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Dashboard(),
    floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: CustomFab(),
        )
    ),
    );
  }
}


