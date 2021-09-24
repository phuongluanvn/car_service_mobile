import 'package:car_service/utils/model/CalendarModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
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

  absentWork(String username, List<Absences> abs) async {
    var body = {
      "username": username,
      "absences": List.generate(abs.length, (index) => abs[index].toJson())
    };
    print(json.encode(body));
    var res = await http.post(
        Uri.parse(
            "https://carservicesystem.azurewebsites.net/api/employees/absences"),
        headers: headers,
        body: json.encode(body));
    if (res.statusCode != null) {
      if (res.statusCode == 200) {
        return res.body;
      } else if (res.statusCode == 404) {
        return res.body;
      } else if (res.statusCode == 400) {
        return res.body;
      }
    } else {
      return null;
    }
  }

  absentWorkTest(
      String username, String timeStart, String timeEnd, String noteEmp) async {
    var body = {
      "username": username,
      "absences": [
        {
          "empUsername": username,
          "timeStart": timeStart,
          "timeEnd": timeEnd,
          "noteEmp": noteEmp
        }
      ]
    };
    print(json.encode(body));
    var res = await http.post(
        Uri.parse(
            "https://carservicesystem.azurewebsites.net/api/employees/absences"),
        headers: headers,
        body: json.encode(body));
    print(res.body);
    if (res.statusCode != null) {
      if (res.statusCode == 200) {
        return res.body;
      } else if (res.statusCode == 404) {
        return res.body;
      } else if (res.statusCode == 400) {
        return res.body;
      }
    } else {
      return null;
    }
  }
}
