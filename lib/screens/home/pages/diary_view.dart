import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myapp/localDatabase/localDiary.dart';
import 'package:myapp/models/class_DiaryItem.dart';

class DiaryView extends StatefulWidget {
  @override
  _DiaryViewState createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> {

  Future<List<Diary>> diary;
  var db;

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


  list(){
    return FutureBuilder(
      future: diary,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return diaryView(snapshot.data);
        }
        return CircularProgressIndicator();
      },
    );
  }

  diaryView(List<Diary> diary){
    return ListView.builder(
      itemCount: diary.length,
      itemBuilder: (context,index){
        return card(diary[index]);
      },
    );
  }

  card(Diary diary){
    return Card(
      child: ListTile(
        title: Text(diary.diary ?? 'asd'),
        subtitle: Text(diary.date ?? 'ads'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diary'),
      ),
      body: list(),
    );
  }
}
