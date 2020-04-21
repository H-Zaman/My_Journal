import 'package:flutter/material.dart';
import 'package:myapp/screens/home/home.dart';
import 'package:myapp/screens/home/pages/diary_add.dart';
import 'package:myapp/screens/home/pages/diary_view.dart';
import 'package:myapp/screens/home/pages/todo_list.dart';
import 'package:myapp/screens/home/pages/travelling_cost.dart';
import 'package:myapp/screens/home/temporaryNote.dart';
import 'package:myapp/screens/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context)=> Wrapper(),
        '/home' : (context)=> HomeScreen(),
        '/diaryAdd' : (context)=> DiaryADD(),
        '/diaryView' : (context)=> DiaryView(),
        '/todo' : (context)=> TodoListPage(),
        '/travel' : (context)=> TravellingCost(),
        '/temp' : (context)=> TemporaryPage(),
      },

      debugShowCheckedModeBanner: false,
    );
  }
}
