import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/shared/bg_image.dart';
import 'package:myapp/shared/testInputDecoration.dart';

class DiaryADD extends StatefulWidget {
  @override
  _DiaryADDState createState() => _DiaryADDState();
}

class _DiaryADDState extends State<DiaryADD> {

  String diaryString;
  String date;
  bool dateSelected;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateSelected = false;
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Diary'),
      ),
      body: Container(
        decoration: customBackgroundImage('assets/backgrounds/blur/app-blurred-bg-15.jpg'),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller,
                  onChanged: (val){
                    setState(() {
                      diaryString = val;
                    });
                  },
                  decoration: customInputDecoration.copyWith(hintText: 'Write your shits here..'),
                  maxLines: 15,
                  minLines: 1,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(dateSelected ?
                    'Selected Date : ' : 'Current Date : '
                    ),
                    Text( dateSelected ?
                    date : DateFormat.yMMMd().format(DateTime.now())
                    ),
                   IconButton(
                     iconSize: 30,
                     icon: Icon(Icons.edit),
                      onPressed: (){
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2222),
                        ).then((onValue){
                          setState(() {
                            dateSelected = true;
                            date = DateFormat.yMMMd().format(onValue);
                          });
                        });
                      },
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: ButtonTheme(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      height: 100,
                      minWidth: 100,
                      buttonColor: Colors.white24,
                      child: RaisedButton(
                        onPressed: (){
                          controller.text = '';
                        },
                        child: Column(
                          children: <Widget>[
                            Ink(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 5.0,
                                ),
                                shape: BoxShape.circle
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.add_box),
                                )
                            ),
                            Text('Clear')
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: ButtonTheme(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      height: 100,
                      minWidth: 100,
                      buttonColor: Colors.white24,
                      child: RaisedButton(
                        onPressed: (){},
                        child: Column(
                          children: <Widget>[
                            Ink(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 5.0,
                                    ),
                                    shape: BoxShape.circle
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.add_box),
                                )
                            ),
                            Text('Insert')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
