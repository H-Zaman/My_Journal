import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myapp/services/setup_time.dart';

//Wrapper decides based on if the device has internet connection or not
// where to go, If it has internet goes to HomeScreen else goes to a tempPage
//Shows a loading screen while waiting

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  void setupTime() async{

    SetupTime setupTime = SetupTime(
      location: 'US-ET',
      url: 'America/New_York',
      flag: 'us.png'
    );
    /*waiting for time to get here*/
    await setupTime.getTime();

    if(setupTime.time == null){
      //if no internet goes to temp page
      Navigator.pushNamed(context, '/temp',arguments: {
        'internet': false,
      });
    }
    else{

      /*when time is here we go to the home page with the time data*/
      Navigator.pushNamed(context, '/home',arguments: {
        'location' : setupTime.location,
        'flag' : setupTime.flag,
        'time' : setupTime.time,
        'date' : setupTime.date,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setupTime();
  }

 /*This is the loading widget it will start up when the app start and
  keep working while we get the time data*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Loading...',
            style: TextStyle(
              letterSpacing: 2,
              color: Colors.grey[600],
              fontSize: 20.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SpinKitWave(
                size: 40,
                color: Colors.blueGrey[800]
            ),
          )
        ],
      ),
    );
  }
}
