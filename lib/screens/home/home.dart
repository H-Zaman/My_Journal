import 'package:flutter/material.dart';
import 'package:myapp/Dashboard/dashboard.dart';
import 'package:myapp/fab_circular_menu/fab_custom.dart';
import 'package:myapp/fab_circular_menu/fab_package.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Dashboard(),
      ],
    );
//      Scaffold(
//      body: Column(
//        mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//
//                Dashboard(),

//                SizedBox(height: 50,),

              // Main button Container
//                Container(
//                  height: 220,
//                  width: MediaQuery.of(context).size.width,
//                  color: Colors.brown,
//                    child: Align(
//                      alignment: Alignment.bottomCenter,
//                        child: Padding(
//                          padding: const EdgeInsets.only(bottom: 20),
//                          child: CustomFab(),
//                        )
//                    )
//                ),
//              ],
//            ),
//    );
  }
}


