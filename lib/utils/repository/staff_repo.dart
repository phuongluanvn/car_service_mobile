import 'package:car_service/utils/model/CalendarModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StaffRepository {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  String BASE_URL = "https://carservicesystem.azurewebsites.net/api/";

  getTaskList(String username) async {
    List<CalendarModel> listTasks = [];
    var res = await http.post(
        Uri.parse(BASE_URL + "employees/" + username + "/tasks"),
        headers: headers);
    final data = (res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);

      try {
        if (data != null) {
          data
              .map((order) => listTasks.add(CalendarModel.fromJson(order)))
              .toList();
          return listTasks;
        } else {
          print('No calendar data');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
