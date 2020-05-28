import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myapp/fab_circular_menu/fab_package.dart';
import 'package:myapp/localDatabase/localDiary.dart';
import 'package:myapp/models/class_DiaryItem.dart';
import 'package:myapp/shared/bg_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<List<Diary>> diary;
  var db;

  String date,note;

  @override
  void initState() {
    super.initState();
    db = LocalDbDiary();
    refresh();
  }

  refresh(){
    setState(() {
      diary = db.getData();
    });
  }

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

  headingTile(){
    return Material(
      color: Colors.white10,
      elevation: 20,
      shadowColor: Colors.blueAccent,
      borderRadius: BorderRadius.circular(25.0),
      child: Center(child: Text('Heading will be used here')),
    );
  }

  refreshGrid(){
    return Material(
      color: Colors.white10,
      elevation: 20,
      shadowColor: Colors.blueAccent,
      borderRadius: BorderRadius.circular(25.0),
      child: IconButton(
        icon: Icon(Icons.refresh),
        onPressed: (){
          setState(() {
            refresh();
          });
        },
      ),
    );
  }

  diaryTile(){
    return FutureBuilder(
      future: diary,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return diaryTileMaker(snapshot.data);
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }

  diaryTileMaker(List<Diary> data){
    int length = data.length;
    return GestureDetector(
      onTap: ()async{
        Navigator.pushNamed(context, '/diaryView');
      },
      child: Material(
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
                      child: Material(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(25.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.event_note,
                                size: 20,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                'Diary',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Material(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(25.0),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Last Entry on : ${data[length-1].date}')
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Material(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Center(
                            child: Text(
                              data[length-1].diary ?? 'Empty',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 6,
                              style: TextStyle(
                                letterSpacing: 1.5,
                                textBaseline: TextBaseline.alphabetic
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  timeTile(){
    return Material(
      color: Colors.white10,
      elevation: 20,
      shadowColor: Colors.blueGrey,
      borderRadius: BorderRadius.circular(25),
      child: Center(
        child: Padding(
            padding: EdgeInsets.all(2.0),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
              onTap: () async{
                //goes to selecting time page
                dynamic result = await Navigator.pushNamed(context, '/time');
                print(diary);
                setState(() {
                  data = {
                    'time' : result['time'],
                    'location' : result['location'],
                    'flag' : result['flag'],
                    'date' : result['date'],
                  };
                });
              },
              leading: CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage('assets/flag/${data['flag']}'),
              ),
              title: Text(
                data['time'],
                style: TextStyle(
                    fontSize: 12
                ),
              ),
              subtitle: Text(
                data['date'],
                style: TextStyle(
                    fontSize: 8
                ),
              ),
            )
        ),
      ),
    );
  }

  todoTile(IconData icon,String title,Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/temp',arguments: {'internet' : true});
      },
      child: Material(
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
            crossAxisCount: 10,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              //heading
              headingTile(),

              //refresh
              refreshGrid(),

              //Diary Tile
              diaryTile(),
              //DashItems To-do list

              //Showing time Tile,
              //TODO make time auto update each minute
              timeTile(),

              //Showing to-do itle
              todoTile(Icons.view_list, 'EXTRA', Colors.red),
              //dashItems(Icons.view_list,'EXTRA',Colors.red),
            ],
            staggeredTiles: [
              //Heading
              StaggeredTile.extent(8, 40),
              //refresh button
              StaggeredTile.extent(2,40),
              //Diary Item
              StaggeredTile.extent(10,230),

              //time tile
              StaggeredTile.extent(4,80),

              //list to-do
              StaggeredTile.extent(6,300),

              //Travelling cost
              //StaggeredTile.extent(1,205),
              //temp page
              //StaggeredTile.extent(2,220),
            ],
          ),
        ),
      ),
      floatingActionButton: PackageFab(),
    );
  }
}
