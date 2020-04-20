import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myapp/Dashboard/tileConfigs/customFabTile.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Material dashItems(IconData icon,String title,Color color) {
    return Material(
      color: Colors.white,
      elevation: 20,
      shadowColor: Colors.brown,
      borderRadius: BorderRadius.circular(25.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: color,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: color,
                    borderRadius: BorderRadius.circular(20.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            dashItems(Icons.graphic_eq,'Last Item on Diary',Colors.red),
            dashItems(Icons.add,'todo list item',Colors.red),
            dashItems(Icons.monetization_on,'Money',Colors.lime),

            //Custom FAB tile
            TileCustomFab(),

            dashItems(Icons.view_list,'Total six',Colors.red),
          ],
          staggeredTiles: [
            StaggeredTile.extent(2,130),
            StaggeredTile.extent(1,150),
            StaggeredTile.extent(1,150),

            //Custom FAB tile
            StaggeredTile.extent(2,220),

            StaggeredTile.extent(1,150),
          ],
        ),
      ),
    );
  }
}
