import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class SetupTime{
  String location;
  String time;
  String date;
  String flag;
  String url;
  
  SetupTime({this.location,this.flag,this.time,this.date,this.url});
  
  Future<void> getTime() async{
    
    try{
      //making request to get time
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
//      print (data);

      //getting properties from the mapped data individually
      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      offset = offset.substring(0,3);

      //making the date time
      DateTime currTime = DateTime.parse(datetime);
//      print(datetime);
      currTime = currTime.add(Duration(hours: int.parse(offset)));
      time = DateFormat.jm().format(currTime);
      date = DateFormat.MMMd().format(currTime);
    }
    catch(e){
      time = null;
    }
  }
  
}