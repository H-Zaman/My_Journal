import 'package:flutter/material.dart';
import 'package:myapp/services/setup_time.dart';

class ChangeTimeLocation extends StatefulWidget {
  @override
  _ChangeTimeLocationState createState() => _ChangeTimeLocationState();
}

class _ChangeTimeLocationState extends State<ChangeTimeLocation> {

  List<SetupTime> locations = [

    SetupTime(location: 'UTC',url: 'Etc/UTC',flag: 'utc.png'),
    SetupTime(location: 'Bangladesh',url: 'Asia/Dhaka',flag: 'bd.png'),
    SetupTime(location: 'US-ET',url: 'America/New_York',flag: 'us.png'),
  ];

  void updateTime(index) async{

    SetupTime setupTime = locations[index];
    await setupTime.getTime();
    Navigator.pop(context, {
      'location' : setupTime.location,
      'time' : setupTime.time,
      'flag' : setupTime.flag,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Choose New Location',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context,index) {
          return Padding(
            padding: EdgeInsets.all(5),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(
                  locations[index].location
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/flag/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
