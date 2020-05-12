import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:myapp/localDatabase/localDiary.dart';
import 'package:myapp/models/class_DiaryItem.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myapp/shared/bg_image.dart';

class DiaryView extends StatefulWidget {
  @override
  _DiaryViewState createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> {

  Future<List<Diary>> diary;
  var db;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    db = LocalDbDiary();
    refresh();
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for(var i =0; i<list.length; i++){
      result.add(handler(i, list[i]));
    }
    return result;
  }

  refresh(){
    setState(() {
      diary = db.getData();
    });
  }

  carouselSlider(){
    return FutureBuilder(
      future: diary,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return carousel(snapshot.data);
        }
        return CircularProgressIndicator();
      },
    );
  }

  carousel(List<Diary> data){
    return Container(
      decoration: customBackgroundImage('assets/backgrounds/blur/app-blurred-bg-22.png'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(seconds: 2),
              pauseAutoPlayOnTouch: true,
              height: 400,
              initialPage: 0,
              enlargeCenterPage: true,
              onPageChanged: (index,reason){
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            //TODO add differant bg image for each item if possible
            items: data.map((item){
              return GestureDetector(
                onTap: (){
                  showAnimatedDialog(
                      animationType: DialogTransitionType.fadeScale,
                      duration: Duration(milliseconds: 500),
                      barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context){
                        return _animatedDialog(item.id,item.date,item.diary);
                      }
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent,
                        Colors.lightBlueAccent
                      ],
                      stops: [
                        0.2,0.8
                      ],
                    ),
//                color: Colors.grey,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20.0),
                            color: Colors.white12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,12.0,0.0,20.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    padding: EdgeInsets.all(7.0),
                                    child: Text(
                                      item.id.toString(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0, 12.0, 0.0, 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: EdgeInsets.all(7.0),
                                  child: Text(
                                    item.date,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              item.diary ?? 'Error Null Data Entry',
                              style: TextStyle(
                                letterSpacing: 1.5,
                                textBaseline: TextBaseline.alphabetic,
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(data,(index,url){
              return Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 3.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.black : Colors.grey[300]
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  _animatedDialog(int id, String date, String diary) {
    String titleText = 'Entry : ' + id.toString() + ', ' + date;
    return ClassicGeneralDialogWidget(
      titleText: titleText,
      contentText: diary,
      actions: <Widget>[
        FlatButton(
          color: Colors.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            children: <Widget>[
              Icon(Icons.delete_forever),
              Text('Delete')
            ],
          ),
          onPressed: (){
            Navigator.pop(context);
            showAnimatedDialog(
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              animationType: DialogTransitionType.slideFromTopFade,
              context: context,
              builder: (BuildContext context){
                return ClassicGeneralDialogWidget(
                  titleText: 'Confirmation',
                  contentText: 'Are you sure you want to delete this Entry',
                  onPositiveClick: () async{
                    await db.delete(id);
                    Navigator.pop(context);
                    refresh();
                  },
                  onNegativeClick: (){
                    Navigator.pop(context);
                  },
                );
              }
            );
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context,bool innerBoxIsScrolled){
          return <Widget>[
            SliverAppBar(
              expandedHeight: 150,
              floating: false,
              pinned: true,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, '/diaryAdd');
                    },
                    color: Colors.white10,
                    shape: StadiumBorder(),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          size: 18,
                        ),
                        SizedBox(width: 3,),
                        Text('Add')
                      ],
                    ),
                  ),
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('My Diary'),
                //TODO just add diary view type image here
                background: Image.asset('assets/backgrounds/blur/app-blurred-bg-14.jpg',fit: BoxFit.cover,),
              ),
            )
          ];
        },
      body: carouselSlider(),
      )
    );
  }
}