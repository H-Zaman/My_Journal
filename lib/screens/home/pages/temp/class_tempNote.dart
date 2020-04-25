import 'package:myapp/main.dart';

class TodoItem{
  int id;
  int level;
  String todoItem;

  TodoItem({this.id,this.level,this.todoItem});

  //convert to MapData to store in db
  Map<String, dynamic> toMap() {

    var map = <String, dynamic> {
      'id' : id,
      'level' : level,
      'item' : todoItem,
    };
    return map;
  }

  //convert to string to show in APP
  TodoItem.fromMap(Map<String, dynamic> map) {

    id = map['id'];
    level = map['level'];
    todoItem = map['item'];
  }
}