class TodoItems {
  int id;
  int level;
  String item;

  TodoItems(this.id, this.level, this.item);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'level' : level,
      'item': item,
    };
    return map;
  }

  TodoItems.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    level = map['level'];
    item = map['item'];
  }
}