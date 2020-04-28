import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myapp/database/Database.dart';
import 'package:myapp/screens/home/pages/temp/class_tempNote.dart';

class TemporaryNotePad extends StatefulWidget {
  @override
  _TemporaryNotePadState createState() => _TemporaryNotePadState();
}

class _TemporaryNotePadState extends State<TemporaryNotePad> {

  Future<List<TodoItems>> todoItems;
  TextEditingController controller = TextEditingController();
  String item;
  int curItemLevel;
  int curItemId;

  final formKey = GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;
  bool formShow;
  bool fabshow;

  @override
  void initState() {
    super.initState();
    formShow = true;
    fabshow = false;
    isUpdating = false;
    dbHelper = DBHelper();
    refreshList();
  }

  ////////////////////////////////// FUNCTIONS /////////////////////////////////////

  //gets all data from the table
  refreshList() {
    setState(() {
      todoItems = dbHelper.getData();
    });
  }

  //clearing controller text
  clearItem() {
    controller.text = '';
  }

  //form validation
  /*works with isUpdating to insert or update data accordingly*/
  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        TodoItems e = TodoItems(curItemId, curItemLevel, item);
        dbHelper.update(e);
        setState(() {
          isUpdating = false;
          formShow = !formShow;
          fabshow = !fabshow;
        });
      } else {
        TodoItems e = TodoItems(null, curItemLevel, item);
        dbHelper.insert(e);
        setState(() {
          formShow = !formShow;
          fabshow = !fabshow;
        });
      }
      clearItem();
      refreshList();
    }
  }

  //animated dialog for the delete confirmation
  void _showAnimatedDialog(int id, String item){
    showAnimatedDialog(
      context: context,
      alignment: Alignment.bottomCenter,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          titleText: 'Confirmation',

          //deciding which buttons to use
          /*actions: <Widget>[
              Material(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20.0),
                child: FlatButton.icon(
                  textColor: Colors.black,
                  icon: Icon(Icons.close),
                  onPressed: ()=> Navigator.pop(context),
                  label: Text(
                      'Exit'
                  ),
                ),
              ),
              Material(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20.0),
                child: FlatButton.icon(
                    textColor: Colors.white,
                    onPressed: (){
                      dbHelper.delete(id);
                      refreshList();
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.check),
                    label: Text(
                        'Confirm'
                    )
                ),
              )
            ],*/
          contentText: item,
          onPositiveClick: (){
            dbHelper.delete(id);
            refreshList();
            Navigator.pop(context);
          },
          onNegativeClick: () {
            Navigator.pop(context);
          },
        );
      },
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 500),
    );
  }

  //Input item form
  form() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey[400],
        ),
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(labelText: 'Todo Item'),
                  validator: (val) => val.length == 0 ? 'Enter Item' : null,
                  onSaved: (val) => item = val,
                ),
                SizedBox(height: 10,),
                Slider(
                  label: 'Task Importance',
                  value: (curItemLevel ?? 100).toDouble(),
                  min: 100,
                  max: 900,
                  divisions: 8,
                  activeColor: Colors.red[curItemLevel ?? 200],
                  inactiveColor: Colors.lime[curItemLevel ?? 200],
                  onChanged: (val) => setState(() => curItemLevel = val.round()),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      onPressed: validate,
                      child: Text(isUpdating ? 'Update' : 'Add'),
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          isUpdating = false;
                          formShow = !formShow;
                          fabshow = !fabshow;
                        });
                        clearItem();
                      },
                      child: Text('Cancel'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //my custom card
  card(TodoItems todoItems){
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Opacity(
        opacity: .65,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0,right: 5.0),
          child: GestureDetector(
            onTap: (){
              setState(() {
                isUpdating = true;
                curItemId = todoItems.id;
                curItemLevel = todoItems.level;
              });
              controller.text = todoItems.item;
            },
            child: Card(
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
              ),
              margin: EdgeInsets.all(1.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red[todoItems.level ?? 100],
                  radius: 25.0,
                ),
                title: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadiusDirectional.circular(10.0),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                        todoItems.item
                    ),
                  ),
                ),
                trailing: Ink(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.red,
                        width: 5.0
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    iconSize: 30.0,
                    color: Colors.red,
                    splashColor: Colors.red,
                    icon: Icon(Icons.delete_forever),
                    onPressed: () {
                      _showAnimatedDialog(todoItems.id, todoItems.item);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //list view to view my data as cards
  ListView testCards (List<TodoItems> todoItems) {
    return ListView.builder(
      itemCount: todoItems.length,
      itemBuilder: (context, index) {
        return card(todoItems[index]);
      },
    );
  }

  //getting and setting data to list view for it to build cards
  list() {
    return Expanded(
      child: FutureBuilder(
        future: todoItems,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return testCards(snapshot.data);
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return SpinKitChasingDots(
              size: 50,
              color: Colors.green,
              duration: Duration(seconds: 3),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  ////////////////////////////////// FUNCTIONS /////////////////////////////////////

  Map data = {};
  bool internetStatus ;

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    internetStatus = data['internet'];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        titleSpacing: 0,
        title: Text(
          'Temporary Note-Pad',
          style: TextStyle(
            fontSize: 17,
            letterSpacing: 1.5
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 10.0,
            backgroundImage: AssetImage('assets/backgrounds/sword.jpg'),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              color: internetStatus ? Colors.green : Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: () {
                internetStatus ? Navigator.pop(context) : SystemNavigator.pop();
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    internetStatus ? Icons.keyboard_return : Icons.close,
                    size: 20,
                  ),
                  Text(
                    internetStatus ? 'Back' : 'Close',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),

      //TODO add a background image tempPage
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/black-red.jpg'),
            fit: BoxFit.fill
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            list(),
            formShow ? Text('') : form(),
          ],
        ),
      ),
      floatingActionButton: fabshow ? Text('') : FloatingActionButton.extended(
          onPressed: (){
            setState(() {
              formShow = !formShow;
              fabshow = !fabshow;
            });
          },
          backgroundColor: Colors.white70,
          icon: Icon(
            isUpdating ? Icons.update : Icons.add_box
          ),
          label: Text(
            isUpdating ? 'Update' : 'Add'
          )
      ),
    );
  }
}