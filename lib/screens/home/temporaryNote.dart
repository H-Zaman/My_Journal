import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TemporaryPage extends StatefulWidget {
  @override
  _TemporaryPageState createState() => _TemporaryPageState();
}

class _TemporaryPageState extends State<TemporaryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      /*decoration: BoxDecoration(
        image: DecorationImage(
          //TODO add a BACKGROUND image TEMP PAGE
          image: AssetImage(null),
          fit: BoxFit.cover,
        ),
      ),*/
      child: Scaffold(
        appBar: AppBar(
          /*removes the back button that comes automatically
          * we don't need it since going back to the loading screen
          * is not needed*/
          automaticallyImplyLeading: false,
//          titleSpacing: -5.0,
          title: Row(
            children: <Widget>[
              Image(
                image: AssetImage('assets/flag/bd.png'),
                width: 30,
              ),
              SizedBox(width: 5,),
              Text(
                'Temporary Note-Pad'
              )
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
              child: FlatButton.icon(
                textColor: Colors.white,
                color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: (()=> exit(0)),
                  icon: Icon(Icons.close),
                  label: Text('Close'),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text('Add'),
          icon: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
