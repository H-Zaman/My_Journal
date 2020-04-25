import 'dart:async';
import 'dart:io' as io;
import 'package:myapp/screens/home/pages/temp/class_tempNote.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class LocalDBHelper{
  static Database _db;
  static const String ID = 'id';
  static const String LEVEL = 'name';
  static const String TODOITEM = 'todoItem';
  static const String TABLE = 'todolist';
  static const String DB_NAME = 'todo_db1.db';
  
  //get the db
  Future<Database> get db async {
//    if db already exist return the db
    if(_db != null){
      return _db;
    }
//    if dn does not exist create a new one
    _db = await initDb();
    return _db;
  }
  
  //creating db paths and setting up
  initDb() async{
    io.Directory databaseDirectory = await getApplicationDocumentsDirectory();
    String path = join(databaseDirectory.path,DB_NAME);
    var db = await openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }
  
  //create db
  _onCreate(Database db,int version) async{
    
    await db.execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY,$TODOITEM INTEGER,$TODOITEM TEXT)");
  }

  //insert data into database
  Future<TodoItem> insert(TodoItem todoItem) async{
    var dbC = await db;
    todoItem.id = await dbC.insert(TABLE, todoItem.toMap());
    return todoItem;
  }

  //get data from database
  Future<List<TodoItem>> getData() async {
    var dbc = await db;
    List<Map> maps = await dbc.query(TABLE,columns: [ID,LEVEL,TODOITEM]);
    List<TodoItem> todoItem = [];
    //converting the map data from return db query to strings
    if(maps.length > 0 ){
      for(int i = 0; i < maps.length; i++){
        todoItem.add(TodoItem.fromMap(maps[i]));
      }
    }
    return todoItem;
  }

  //delete from database
  Future<int> delete(int id) async{
    var dbc = await db;
    return await dbc.delete(TABLE,where: '$ID = ?',whereArgs: [id]);
  }

  //close db connection
  Future close() async {
    var dbc = await db;
    dbc.close();
  }

}