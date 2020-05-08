import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              autoPlayInterval: Duration(seconds: 2),
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
            items: data.map((item){
              return GestureDetector(
                onTap: (){
                  print(item.diary);
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          item.diary ?? 'Error Null Data Entry'
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                            item.date ?? 'Error Null Data Entry'
                        ),
                      )
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diary'),
      ),
      body: carouselSlider(),
    );
  }
}