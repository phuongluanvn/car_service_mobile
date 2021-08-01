import 'package:car_service/utils/model/AssignOrderModel.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/CustomerModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/ServiceModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/TestOrderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManagerRepository {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  String BASE_URL = 'https://carservicesystem.azurewebsites.net/api/';

  createOrder(String vehicleId, String packageId, String note,
      String bookingTime) async {
    var body = {
      "vehicleId": '$vehicleId',
      "packageId": '$packageId',
      "note": '$note',
      "bookingTime": '$bookingTime'
    };
    var res = await http.post(
      Uri.parse(BASE_URL + "orders"),
      headers: headers,
      body: json.encode(body),
    );
    if (res.statusCode != null) {
      if (res.statusCode == 200) {
        // updateStatusOrder(res.body.id)
        return res.body;
      } else if (res.statusCode == 404) {
        return res.body;
      }
    } else {
      return null;
    }
  }

  Future<List<StaffModel>> getStaffList() async {
    List<StaffModel> staffList = [];

    var resStaff = await http.get(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/employees"),
      headers: headers,
    );
    if (resStaff.statusCode == 200) {
      var dataProcessing = json.decode(resStaff.body);
      if (dataProcessing != null) {
        dataProcessing
            .map((order) => staffList.add(StaffModel.fromJson(order)))
            .toList();
        var newList = [...staffList];
        return newList;
      } else {
        return null;
      }
    } else {
      print('No test order data');
      return null;
    }
  }

  Future<List<StaffModel>> getStaffDetail(String username) async {
    List<StaffModel> listdata = [];
    List convertData = [];

    var res = await http.get(
      Uri.parse('https://carservicesystem.azurewebsites.net/api/employees/' +
          username),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      convertData.add(data); //thêm [] để dùng .map bêndưới

      try {
        if (data != null) {
          convertData
              .map((element) => listdata.add(StaffModel.fromJson(element)))
              .toList();
          return listdata;
        } else {
          print('No detail order data');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<List<ServiceModel>> getServiceList() async {
    List<ServiceModel> serviceLists = [];
    var res = await http.get(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/Services"),
      headers: headers,
    );
    print(res);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data
            .map((order) => serviceLists.add(ServiceModel.fromJson(order)))
            .toList();
        return serviceLists;
      } else {
        print('No service data');
        return null;
      }
    }
  }

  Future<List<OrderDetailModel>> getBookingOrderList() async {
    List<OrderDetailModel> bookingList = [];

    var res = await http.get(
      Uri.parse(
          "https://carservicesystem.azurewebsites.net/api/orders?status=Accepted"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);

      if (data != null) {
        data
            .map((order) => bookingList.add(OrderDetailModel.fromJson(order)))
            .toList();
        return bookingList;
      } else {
        print('No test order data');
        return null;
      }
    }
  }

  Future<List<OrderDetailModel>> getAssingOrderList() async {
    List<OrderDetailModel> checkinList = [];
    List<OrderDetailModel> acceptedList = [];
    List<OrderDetailModel> checkingList = [];

    var resAccepted = await http.get(
      Uri.parse(
          "https://carservicesystem.azurewebsites.net/api/orders?status=Accepted"),
      headers: headers,
    );
    var resCheckin = await http.get(
      Uri.parse(
          "https://carservicesystem.azurewebsites.net/api/orders?status=Checkin"),
      headers: headers,
    );
    var resChecking = await http.get(
      Uri.parse(
          "https://carservicesystem.azurewebsites.net/api/orders?status=Checking"),
      headers: headers,
    );
    if (resAccepted.statusCode == 200 &&
        resCheckin.statusCode == 200 &&
        resChecking.statusCode == 200) {
      var dataAccepted = json.decode(resAccepted.body);
      var dataCheckin = json.decode(resCheckin.body);
      var dataChecking = json.decode(resChecking.body);

      if (dataAccepted != null && dataCheckin != null && dataChecking != null) {
        print('Check assign success');
        dataAccepted
            .map((order) => acceptedList.add(OrderDetailModel.fromJson(order)))
            .toList();
        dataCheckin
            .map((order) => checkinList.add(OrderDetailModel.fromJson(order)))
            .toList();
        dataChecking
            .map((order) => checkingList.add(OrderDetailModel.fromJson(order)))
            .toList();
        List<OrderDetailModel> newList = [
          ...acceptedList,
          ...checkinList,
          ...checkingList
        ];
        print('????');
        print(newList);
        return newList;
      } else {
        print('Đuu');
        return null;
      }
    } else {
      print('No test order data');
      return null;
    }
  }

  Future<List<OrderDetailModel>> getProcessOrderList() async {
    List<OrderDetailModel> processList = [];

    var resProcessing = await http.get(
      Uri.parse(
          "https://carservicesystem.azurewebsites.net/api/Orders?status=Processing"),
      headers: headers,
    );
    if (resProcessing.statusCode == 200) {
      var dataProcessing = json.decode(resProcessing.body);

      if (dataProcessing != null) {
        dataProcessing
            .map((order) => processList.add(OrderDetailModel.fromJson(order)))
            .toList();
        var newList = [...processList];
        print('????');
        print(newList);
        return newList;
      } else {
        return null;
      }
    } else {
      print('No test order data');
      return null;
    }
  }

  Future<List<OrderDetailModel>> getTestList() async {
    List<OrderDetailModel> orderLists = [];
    var res = await http.get(
      Uri.parse(
          "https://carservicesystem.azurewebsites.net/api/Orders?status=Booked"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data
            .map((order) => orderLists.add(OrderDetailModel.fromJson(order)))
            .toList();
        return orderLists;
      } else {
        print('No order data');
      }
    } else {
      return null;
    }
  }

  Future<List<OrderDetailModel>> getVerifyOrderDetail(String id) async {
    List<OrderDetailModel> listdata = [];
    List convertData = [];

    var res = await http.get(
      Uri.parse('https://carservicesystem.azurewebsites.net/api/orders/' + id),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      convertData.add(data); //thêm [] để dùng .map bêndưới

      try {
        if (data != null) {
          convertData
              .map(
                  (element) => listdata.add(OrderDetailModel.fromJson(element)))
              .toList();
          return listdata;
        } else {
          print('No detail order data');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  updateStatusOrder(String id, String status) async {
    var body = {
      "id": '$id',
      "status": '$status',
    };
    var res = await http.put(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/orders/status"),
      headers: headers,
      body: json.encode(body),
    );
    if (res.statusCode != null) {
      if (res.statusCode == 200) {
        return res.body;
      }
    } else {
      return null;
    }
  }

  updateStaffStatusOrder(String username, String status) async {
    var body = {
      "username": '$username',
      "role": 'staff',
      "status": '$status',
    };
    var res = await http.put(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/employees"),
      headers: headers,
      body: json.encode(body),
    );
    if (res.statusCode != null) {
      if (res.statusCode == 200) {
        return res.body;
      }
    } else {
      return res.body;
    }
  }

  Future<List<OrderDetailModel>> getOrderHistoryList() async {
    List<OrderDetailModel> finishList = [];
    List<OrderDetailModel> cancelList = [];

    var resAccepted = await http.get(
      Uri.parse(
          "https://carservicesystem.azurewebsites.net/api/Orders?status=Finish"),
      headers: headers,
    );
    var resCheckin = await http.get(
      Uri.parse(
          "https://carservicesystem.azurewebsites.net/api/Orders?status=Cancel"),
      headers: headers,
    );

    if (resAccepted.statusCode == 200 && resCheckin.statusCode == 200) {
      var dataAccepted = json.decode(resAccepted.body);
      var dataCheckin = json.decode(resCheckin.body);

      if (dataAccepted != null && dataCheckin != null) {
        dataAccepted
            .map((order) => finishList.add(OrderDetailModel.fromJson(order)))
            .toList();
        dataCheckin
            .map((order) => cancelList.add(OrderDetailModel.fromJson(order)))
            .toList();

        var newList = [
          ...finishList,
          ...cancelList,
        ];
        print('????');
        print(newList);
        return newList;
      } else {
        return null;
      }
    } else {
      print('No test order data');
      return null;
    }
  }

  Future<List<CustomerModel>> getCreateOrderDetail(String id) async {
    List<CustomerModel> listdata = [];
    List convertData = [];

    var res = await http.get(
      Uri.parse(
          'https://carservicesystem.azurewebsites.net/api/customers/' + id),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      convertData.add(data); //thêm [] để dùng .map bêndưới

      try {
        if (data != null) {
          convertData
              .map((element) => listdata.add(CustomerModel.fromJson(element)))
              .toList();
          return listdata;
        } else {
          print('No detail order data');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  //   createNewOrder(String cusId, String packageId, String note,
  //     String bookingTime) async {
  //   var body = {
  //     "vehicleId": '$cusId',
  //     "packageId": null,
  //     "note": '$note',
  //     "bookingTime": '$bookingTime'
  //   };
  //   var res = await http.post(
  //     Uri.parse(BASE_URL + "Orders"),
  //     headers: headers,
  //     body: json.encode(body),
  //   );
  //   if (res.statusCode != null) {
  //     if (res.statusCode == 200) {
  //       return res.body;
  //     } else if (res.statusCode == 404) {
  //       return res.body;
  //     }
  //   } else {
  //     return null;
  //   }
  // }
}
