import 'package:flutter/material.dart';
import 'package:myapp/fab_circular_menu/fab_custom.dart';

class TileCustomFab extends StatefulWidget {
  @override
  _TileCustomFabState createState() => _TileCustomFabState();
}

class _TileCustomFabState extends State<TileCustomFab> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 20,
      shadowColor: Colors.brown,
      borderRadius: BorderRadius.circular(25.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: CustomFab(),
        ),
      ),
    );
  }
}
