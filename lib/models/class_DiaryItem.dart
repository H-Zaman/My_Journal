class Diary{
  int id;
  String date;
  String diary;
  Diary({this.id,this.date,this.diary});

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'id' : id,
      'date' : date,
      'diary' : diary,
    };
    return map;
  }

  Diary.fromMap(Map<String, dynamic> map){
    id = map['id'];
    date = map['date'];
    diary = map['diary'];
  }
}