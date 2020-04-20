import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

class PackageFab extends StatefulWidget {
  @override
  _PackageFabState createState() => _PackageFabState();
}

class _PackageFabState extends State<PackageFab> {
  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
      //position
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.note_add),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.note),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.monetization_on),
          onPressed: () {},
        )
      ],
    );
  }
}
