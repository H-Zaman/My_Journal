import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myapp/fab_circular_menu/fab_package.dart';
import 'package:myapp/shared/bg_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  /*the function to make tiles with pre settings*/
  Material dashItems(IconData icon,String title,Color color) {
    return Material(
      color: Colors.white10,
      elevation: 20,
      shadowColor: Colors.blueAccent,
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

  //a MAP to store all time related data's
  Map data = {};

  @override
  Widget build(BuildContext context) {

    /*receive-ing the time data from the loading widget*/
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
//    print(data);


    return Scaffold(
      body: Container(
        decoration: customBackgroundImage('assets/backgrounds/blur/app-blurred-bg-3.jpg'),
        child: SafeArea(
          child: StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              dashItems(Icons.graphic_eq,'Diary',Colors.red),
              dashItems(Icons.add,'todo list item',Colors.red),

              //Showing time Tile,
              //TODO make time auto update each minute
              Material(
                color: Colors.white10,
                elevation: 20,
                shadowColor: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: ListTile(
                      onTap: () async{
                        //goes to selecting time page
                        dynamic result = await Navigator.pushNamed(context, '/time');
                        setState(() {
                          data = {
                            'time' : result['time'],
                            'location' : result['location'],
                            'flag' : result['flag']
                          };
                        });
                      },
                      leading: CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage('assets/flag/${data['flag']}'),
                      ),
                      title: Text(
                        data['location']
                      ),
                      subtitle: Text(
                        data['time']
                      ),
                    )
                  ),
                ),
              ),

              dashItems(Icons.monetization_on,'Money',Colors.lime),
              dashItems(Icons.view_list,'Total six',Colors.red),
            ],
            staggeredTiles: [
              //Diary Item

              StaggeredTile.extent(2,300),

              //list to-do
              StaggeredTile.extent(1,300),

              //US time tile
              StaggeredTile.extent(1,80),

              //Travelling cost
              StaggeredTile.extent(1,205),
              //temp page
              StaggeredTile.extent(2,220),
            ],
          ),
        ),
      ),
      floatingActionButton: PackageFab(),
    );
  }
}
