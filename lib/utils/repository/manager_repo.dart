import 'package:car_service/utils/model/AssignOrderModel.dart';
import 'package:car_service/utils/model/BookingModel.dart';
import 'package:car_service/utils/model/CalendarModel.dart';
import 'package:car_service/utils/model/CrewModel.dart';
import 'package:car_service/utils/model/CustomerModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/ServiceModel.dart';
import 'package:car_service/utils/model/StaffModel.dart';
import 'package:car_service/utils/model/TestOrderModel.dart';
import 'package:car_service/utils/model/accessory_model.dart';
import 'package:car_service/utils/model/createCrewModel.dart';
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
      "vehicleId": vehicleId,
      "packageId": packageId,
      "note": note,
      "bookingTime": bookingTime
    };
    var res = await http.post(
      Uri.parse(BASE_URL + "orders"),
      headers: headers,
      body: json.encode(body),
    );
    print(json.encode(body));
    if (res.statusCode != null) {
      if (res.statusCode == 200) {
        var id = json.decode(res.body);
        updateStatusOrder(id['orderId'].toString(), 'Đã nhận xe');
        return 'Đặt lịch hẹn thành công';
      } else if (res.statusCode == 404) {
        return res;
      } else {
        return res;
      }
    } else {
      return null;
    }
  }

  Future<List<StaffModel>> getStaffList() async {
    List<StaffModel> staffList = [];

    var resStaff = await http.get(
      Uri.parse(BASE_URL + "employees"),
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

  Future<List<StaffModel>> getAvailStaffList() async {
    List<StaffModel> staffList = [];

    var resStaff = await http.get(
      Uri.parse(BASE_URL + "employees/available"),
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
      Uri.parse(BASE_URL + 'employees/' + username),
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

  Future<List<CrewModel>> getCrewDetail(String id) async {
    List<CrewModel> listdata = [];
    List convertData = [];

    var res = await http.get(
      Uri.parse(BASE_URL + 'crews/' + id),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      convertData.add(data); //thêm [] để dùng .map bêndưới

      try {
        if (data != null) {
          convertData
              .map((element) => listdata.add(CrewModel.fromJson(element)))
              .toList();
          return listdata;
        } else {
          print('No crew data');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<List<ServiceModel>> getServiceList() async {
    List<ServiceModel> serviceLists = [];
    var res = await http.get(
      Uri.parse(BASE_URL + "Services"),
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
      Uri.parse(BASE_URL + "orders?status=Accepted"),
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

  Future<List<OrderDetailModel>> getAssingReviewList() async {
    List<OrderDetailModel> checkingList = [];
    List<OrderDetailModel> waitingList = [];
    var resChecking = await http.get(
      Uri.parse(BASE_URL + "orders?status=Kiểm tra"),
      headers: headers,
    );
    var resWaitingConfirm = await http.get(
      Uri.parse(BASE_URL + "orders?status=Đợi phản hồi"),
      headers: headers,
    );
    if (resChecking.statusCode == 200 && resWaitingConfirm.statusCode == 200) {
      var dataChecking = json.decode(resChecking.body);
      var dataWaiting = json.decode(resWaitingConfirm.body);
      if (dataChecking != null && dataWaiting != null) {
        print('Check assign success');
        dataWaiting
            .map((order) => waitingList.add(OrderDetailModel.fromJson(order)))
            .toList();
        dataChecking
            .map((order) => checkingList.add(OrderDetailModel.fromJson(order)))
            .toList();
        List<OrderDetailModel> newList = [
          ...checkingList,
          ...waitingList,
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

  Future<List<OrderDetailModel>> getAssingOrderList() async {
    List<OrderDetailModel> checkinList = [];
    List<OrderDetailModel> acceptedList = [];

    var resAccepted = await http.get(
      Uri.parse(BASE_URL + "orders?status=Đã xác nhận"),
      headers: headers,
    );
    var resCheckin = await http.get(
      Uri.parse(BASE_URL + "orders?status=Đã nhận xe"),
      headers: headers,
    );

    if (resAccepted.statusCode == 200 && resCheckin.statusCode == 200) {
      var dataAccepted = json.decode(resAccepted.body);
      var dataCheckin = json.decode(resCheckin.body);

      if (dataAccepted != null && dataCheckin != null) {
        print('Check assign success');
        dataAccepted
            .map((order) => acceptedList.add(OrderDetailModel.fromJson(order)))
            .toList();
        dataCheckin
            .map((order) => checkinList.add(OrderDetailModel.fromJson(order)))
            .toList();

        List<OrderDetailModel> newList = [
          ...acceptedList,
          ...checkinList,
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
      Uri.parse(BASE_URL + "Orders?status=Đang tiến hành"),
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
      Uri.parse(BASE_URL + "Orders?status=Đợi xác nhận"),
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

  Future<List<AccessoryModel>> getAccessoryList() async {
    List<AccessoryModel> accLists = [];
    var res = await http.get(
      Uri.parse(BASE_URL + "accessories"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data
            .map((order) => accLists.add(AccessoryModel.fromJson(order)))
            .toList();
        return accLists;
      } else {
        print('No acc data');
      }
    } else {
      return null;
    }
  }

  Future<List<CrewModel>> getCrewList() async {
    List<CrewModel> crewLists = [];
    var res = await http.get(
      Uri.parse(BASE_URL + "crews"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data.map((order) => crewLists.add(CrewModel.fromJson(order))).toList();
        return crewLists;
      } else {
        print('No crew data');
      }
    } else {
      return null;
    }
  }

  Future<List<AccessoryModel>> getAccessoryByName(String name) async {
    List<AccessoryModel> listdata = [];
    List convertData = [];

    var res = await http.get(
      Uri.parse(BASE_URL + '/accessories?searchValue=' + name),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      convertData.add(data); //thêm [] để dùng .map bêndưới

      try {
        if (data != null) {
          convertData
              .map((element) => listdata.add(AccessoryModel.fromJson(element)))
              .toList();
          return listdata;
        } else {
          print('No accessory order data');
        }
      } catch (e) {
        print(e.toString());
      }
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

  updateCrewByName(String id, String crewId) async {
    print('lololo');
    // print(selectName);

    var body = {
      "id": '$id',
      "crewId": '$crewId',
    };
    var res = await http.put(
      Uri.parse(BASE_URL + "orders/crew"),
      headers: headers,
      body: json.encode(body),
    );
    print(res.statusCode);
    if (res.statusCode != null) {
      if (res.statusCode == 200) {
        return res.body;
      }
    } else {
      return null;
    }
  }

  createCrew(List<CreateCrewModel> listUsername) async {
    // print('lololo');
    // print(selectName);

    var body = {
      "members": List.generate(
          listUsername.length, (index) => listUsername[index].toJson())
    };
    var res = await http.post(
      Uri.parse(BASE_URL + "crews"),
      headers: headers,
      body: json.encode(body),
    );
    print(res.statusCode);
    if (res.statusCode != null) {
      if (res.statusCode == 200) {
        return res.body;
      }
    } else {
      return null;
    }
  }

  updateConfirmFromCustomer(
      String id, bool isAccept, String customerNote) async {
    var body = {"id": id, "isAccept": isAccept, "customerNote": customerNote};
    var res = await http.post(
      Uri.parse(BASE_URL + "orders/confirm/manager"),
      headers: headers,
      body: json.encode(body),
    );
    if (res.statusCode != null) {
      if (res.statusCode == 200) {
        print(res.statusCode);
        print('update confirm');
        print(res.body);
        return res;
      } else {
        return res;
      }
    } else {
      return null;
    }
  }

  updateStatusOrder(String id, String status) async {
    var body = {
      "id": '$id',
      "status": '$status',
    };
    var res = await http.put(
      Uri.parse(BASE_URL + "orders/status"),
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

  updateStatusWithNote(String id, String status, String note) async {
    var body = {
      "id": '$id',
      "status": '$status',
      "managerNote": '$note',
    };
    var res = await http.post(
      Uri.parse(BASE_URL + "orders/confirm/customer"),
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

  deleteItemById(String detailId) async {
    var res = await http.delete(
      Uri.parse(BASE_URL + 'orders/details?orderDetailId=' + detailId),
      headers: headers,
    );
    if (res.statusCode != null) {
      print(res.statusCode);
      if (res.statusCode == 200) {
        return res.body;
      }
    } else {
      return res.body;
    }
  }

  updateSelectedCrew(String crewid, List<StaffModel> selectedCrew) async {
    List<String> listName = List.generate(
        selectedCrew.length, (index) => selectedCrew[index].username);
    var body = {"id": '$crewid', "memberUsernameList": listName};
    var res = await http.put(
      Uri.parse(BASE_URL + "crews/members"),
      headers: headers,
      body: json.encode(body),
    );
    if (res.statusCode != null) {
      print(res.statusCode);
      if (res.statusCode == 200) {
        return res.body;
      }
    } else {
      return res.body;
    }
  }

  updateStatusTask(String id, bool selected) async {
    print(id);
    var body = {"id": '$id', "isFinished": selected};
    var res = await http.put(Uri.parse(BASE_URL + "orders/details/status"),
        headers: headers, body: json.encode([body]));
    if (res.statusCode != null) {
      print(res.statusCode);
      if (res.statusCode == 200) {
        return res.body;
      }
    } else {
      return res.body;
    }
  }

  updateStaffStatusOrder(String username, String status) async {
    var body = {
      "username": '$username',
      "role": 'staff',
      "status": '$status',
    };
    var res = await http.put(
      Uri.parse(BASE_URL + "employees"),
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

  updateAccIdToOrder(String orderId, String detailId, String svId, String accId,
      int quantity, int price) async {
    var body = {
      "id": '$orderId',
      "orderDetails": [
        {
          "id": detailId,
          "serviceId": '$svId',
          "accessoryId": accId,
          "quantity": quantity,
          "price": price
        }
      ]
    };

    var res = await http.put(
      Uri.parse(BASE_URL + "orders/details"),
      headers: headers,
      body: json.encode(body),
    );
    print(res.body);
    if (res.statusCode != null) {
      print(res.statusCode);
      if (res.statusCode == 200) {
        print('repo 200');
        return res.body;
      }
    } else {
      print('cannot update acc');
      return res.body;
    }
  }

  Future<List<OrderDetailModel>> getConfirmOrderList() async {
    List<OrderDetailModel> acceptedList = [];
    List<OrderDetailModel> deniedList = [];

    var resAccepted = await http.get(
      Uri.parse(BASE_URL + "Orders?status=Đã đồng ý"),
      headers: headers,
    );
    var resDenied = await http.get(
      Uri.parse(BASE_URL + "Orders?status=Đã từ chối"),
      headers: headers,
    );

    if (resAccepted.statusCode == 200 && resDenied.statusCode == 200) {
      var dataAccepted = json.decode(resAccepted.body);
      var dataCheckin = json.decode(resDenied.body);

      if (dataAccepted != null && dataCheckin != null) {
        dataAccepted
            .map((order) => acceptedList.add(OrderDetailModel.fromJson(order)))
            .toList();
        dataCheckin
            .map((order) => deniedList.add(OrderDetailModel.fromJson(order)))
            .toList();

        var newList = [
          ...acceptedList,
          ...deniedList,
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

  Future<List<CrewModel>> getCalendarList(String username) async {
    List<CrewModel> listdata = [];
    // List convertData = [];

    var res = await http.get(
      Uri.parse('https://carservicesystem.azurewebsites.net/api/employees/' +
          username +
          '/tasks'),
      headers: headers,
    );

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      // convertData.add(data); //thêm [] để dùng .map bêndưới

      try {
        if (data != null) {
          data.map((order) => listdata.add(CrewModel.fromJson(order))).toList();
          return listdata;
        } else {
          print('No calendar data');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<List<OrderDetailModel>> getWaitingPaymentList() async {
    List<OrderDetailModel> acceptedList = [];
    List<OrderDetailModel> deniedList = [];

    var resAccepted = await http.get(
      Uri.parse(BASE_URL + "Orders?status=Đợi thanh toán"),
      headers: headers,
    );
    var resDenied = await http.get(
      Uri.parse(BASE_URL + "Orders?status=Đã thanh toán"),
      headers: headers,
    );

    if (resAccepted.statusCode == 200 && resDenied.statusCode == 200) {
      var dataAccepted = json.decode(resAccepted.body);
      var dataCheckin = json.decode(resDenied.body);

      if (dataAccepted != null && dataCheckin != null) {
        dataAccepted
            .map((order) => acceptedList.add(OrderDetailModel.fromJson(order)))
            .toList();
        dataCheckin
            .map((order) => deniedList.add(OrderDetailModel.fromJson(order)))
            .toList();

        var newList = [
          ...acceptedList,
          ...deniedList,
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

  Future<List<OrderDetailModel>> getOrderHistoryList() async {
    List<OrderDetailModel> finishList = [];
    List<OrderDetailModel> cancelList = [];
    List<OrderDetailModel> cancelBookingList = [];

    var resAccepted = await http.get(
      Uri.parse(BASE_URL + "Orders?status=Hoàn thành"),
      headers: headers,
    );
    var resCheckin = await http.get(
      Uri.parse(BASE_URL + "Orders?status=Hủy đơn"),
      headers: headers,
    );
    var resCancel = await http.get(
      Uri.parse(BASE_URL + "Orders?status=Từ chối đặt lịch"),
      headers: headers,
    );

    if (resAccepted.statusCode == 200 &&
        resCheckin.statusCode == 200 &&
        resCancel.statusCode == 200) {
      var dataAccepted = json.decode(resAccepted.body);
      var dataCheckin = json.decode(resCheckin.body);
      var dataCancel = json.decode(resCancel.body);
      if (dataAccepted != null && dataCheckin != null) {
        dataAccepted
            .map((order) => finishList.add(OrderDetailModel.fromJson(order)))
            .toList();
        dataCheckin
            .map((order) => cancelList.add(OrderDetailModel.fromJson(order)))
            .toList();
        dataCancel
            .map((order) =>
                cancelBookingList.add(OrderDetailModel.fromJson(order)))
            .toList();
        var newList = [
          ...finishList,
          ...cancelList,
          ...cancelBookingList,
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

  getTaskList(String username) async {
    var res = await http.get(
      Uri.parse('https://carservicesystem.azurewebsites.net/api/employees/' +
          username +
          '/tasks'),
      headers: headers,
    );
    if (res.statusCode != null) {
      print(res.statusCode);
      if (res.statusCode == 200) {
        return res.body;
      }
    } else {
      return res.body;
    }
  }

  getTaskListNew(String username) async {
    List<CalendarModel> listTasks = [];
    var res = await http.get(
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
