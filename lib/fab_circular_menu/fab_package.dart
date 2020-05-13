import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PackageFab extends StatefulWidget {
  @override
  _PackageFabState createState() => _PackageFabState();
}

class _PackageFabState extends State<PackageFab> {

  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
      ringDiameter: 300.0,
      ringWidth: 60.0,
      fabMargin: EdgeInsets.all(20.0),
      ringColor: Colors.white54,
      fabColor: Colors.white10,
      fabOpenIcon: Icon(Icons.settings),
      //position
//      alignment: Alignment.bottomCenter,
      children: <Widget>[
        //Diary
        IconButton(
          icon: Icon(Icons.note_add),
          onPressed: () {
            Navigator.pushNamed(context, '/diaryAdd');
          },
        ),
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            Navigator.pushNamed(context, '/diaryView');
          },
        ),
        IconButton(
          icon: Icon(Icons.note),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.monetization_on),
          onPressed: () {
            Navigator.pushNamed(context, '/travel');
          },
        ),
        IconButton(
          icon: Icon(Icons.speaker_notes_off),
          onPressed: () {
            Navigator.pushNamed(context, '/temp',arguments: {'internet' : true});
          },
        ),
        IconButton(
          icon: Icon(Icons.adb),
          onPressed: () {},
        ),
      ],
    );
  }
}
