import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the UI
  String time = ''; // the time in that location
  String url; //location url for api end point
  String flag; //the url to an asset flag icon
  bool? isDayTime; //true or false if daytime or not

  WorldTime({required this.location,required this.flag, required this.url});

  Future<void> getTime() async {
    try{
      //make the request
      Response response = await get(
          Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(offset);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      time = DateFormat.jm().format(now);
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    }
    catch(e) {
      print('Cought error$e');
      time = "Could not fetch time";
    }

  }
}

