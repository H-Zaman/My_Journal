import 'package:myapp/models/class_DiaryItem.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class LocalDbDiary{
  static Database _db;
  static const String ID = 'id';
  static const String DATE = 'date';
  static const String DIARY = 'diary';
  static const String TABLE = 'localdiary';
  static const String DB_NAME = 'localdiary.db';

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initializeDB();
    return _db;
  }

  initializeDB() async{
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,DB_NAME);
    var db = await openDatabase(path,version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db,int version) async{
    await db.execute('CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $DATE TEXT, $DIARY TEXT)');
  }

  Future<Diary> insert(Diary diary) async{
    var dbClient = await db;
    diary.id = await dbClient.insert(TABLE, diary.toMap());
    return diary;
  }

  Future<List<Diary>> getData() async{
    var dbc = await db;
    List<Map> maps = await dbc.query(TABLE,columns: [DIARY,DATE]);
    List<Diary> diary = [];
    if(maps.length > 0){
      for (int z = 0; z <maps.length; z++){
        diary.add(Diary.fromMap(maps[z]));
      }
    }
    return diary;
  }

  Future<List<Map>> getDataSimp() async{
    var dbc = await db;
    List<Map> maps = await dbc.query(TABLE,columns: [DIARY,DATE]);
    return maps;
  }

  Future close() async{
    var dbc = await db;
    dbc.close();
  }
}