import 'package:car_service/utils/model/CarModel.dart';
import 'package:car_service/utils/model/CouponModel.dart';
import 'package:car_service/utils/model/CustomerProfileModel.dart';
import 'package:car_service/utils/model/ManufacturerModel.dart';
import 'package:car_service/utils/model/OrderDetailModel.dart';
import 'package:car_service/utils/model/OrderModel.dart';
import 'package:car_service/utils/model/PackageServiceDetailModel.dart';
import 'package:car_service/utils/model/PackageServiceModel.dart';
import 'package:car_service/utils/model/ServiceModel.dart';
import 'package:car_service/utils/model/VehicleModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerRepository {
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': ' */*'
  };

  String BASE_URL = 'https://carservicesystem.azurewebsites.net/api/';

  createNewBooking(String vehicleId, String packageId, String note,
      String bookingTime, String imageUrl) async {
    var body = {
      "vehicleId": vehicleId,
      "packageId": packageId,
      "note": note,
      "bookingTime": bookingTime,
      "imageurl": imageUrl
    };
    print(json.encode(body));
    var res = await http.post(
      Uri.parse(BASE_URL + "orders"),
      headers: headers,
      body: json.encode(body),
    );
    if (res.statusCode != null) {
      print(res.statusCode);
      if (res.statusCode == 200) {
        return res;
      } else if (res.statusCode == 404) {
        return res;
      } else if (res.statusCode == 400) {
        return res;
      }
    } else {
      return res;
    }
  }

  createNewVehicle(String username, String manufacturer, String model,
      String licensePlateNumber) async {
    var body = {
      "username": '$username',
      "manufacturer": '$manufacturer',
      "model": '$model',
      "licensePlate": '$licensePlateNumber'
    };
    var res = await http.post(
      Uri.parse(BASE_URL + "vehicles"),
      headers: headers,
      body: json.encode(body),
    );
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

  updateVehicle(String id, String manufacturer, String model,
      String licensePlateNumber) async {
    var body = {
      "id": id,
      "manufacturer": manufacturer,
      "model": model,
      "licensePlate": licensePlateNumber,
    };
    var res = await http.put(
      Uri.parse(BASE_URL + "vehicles"),
      headers: headers,
      body: json.encode(body),
    );
    if (res.statusCode != null) {
      if (res.statusCode == 200) {
        return res.body;
      } else if (res.statusCode == 404) {
        return res.body;
      }
    } else {
      return null;
    }
  }

  getVehicleDetail(String vehicleId) async {
    List convertData = [];
    List<VehicleModel> detailVehicle = [];
    var res = await http.get(
      Uri.parse(BASE_URL + 'vehicles/' + vehicleId),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      convertData.add(data);
      print(convertData);
      try {
        if (data != null) {
          convertData
              .map((vehicleDetail) =>
                  detailVehicle.add(VehicleModel.fromJson(vehicleDetail)))
              .toList();
          return detailVehicle;
        } else {
          res.body;
        }
      } catch (e) {
        res.body;
      }
    } else {
      res.body;
    }
  }

  deleteVehicle(String vehicleId) async {
    print(vehicleId);
    print("hihihihi");
    var res = await http.delete(
      Uri.parse(BASE_URL + "vehicles?id=" + vehicleId),
      headers: headers,
    );
    print(res.body);
    if (res.statusCode != null) {
      if (res.statusCode == 200) {
        return res.body;
      } else if (res.statusCode == 404) {
        return res.body;
      }
    } else {
      return res.body;
    }
  }

  getCarListOfCustomer(String username) async {
    String message = '';
    List<VehicleModel> vehicleLists = [];
    var ressponse = await http.get(
      Uri.parse(BASE_URL + "customers/" + username),
      headers: headers,
    );
    if (ressponse.statusCode == 200) {
      var data = json.decode(ressponse.body);
      var enc = json.encode(data);
      var dec = json.decode(enc);
      if (dec != null) {
        dec['vehicles']
            .map((vehicle) => vehicleLists.add(VehicleModel.fromJson(vehicle)))
            .toList();
        return vehicleLists;
      } else {
        return 'Không tìm thấy xe';
      }
    } else if (ressponse.statusCode == 404) {
      message = 'Không tìm thấy xe ' + ressponse.statusCode.toString();
      return message;
    } else {
      return ressponse.body;
    }
  }

  getOrderList(String username) async {
    List<OrderModel> orderLists = [];
    var res = await http.get(
      Uri.parse(BASE_URL + "customers/" + username + "/orders"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data
            .map((order) => orderLists.add(OrderModel.fromJson(order)))
            .toList();
        return orderLists;
      } else {
        return res.body;
      }
    } else {
      return res.body;
    }
  }

  getOrderDetail(String id) async {
    List<OrderDetailModel> orderDetails = [];
    List convertData = [];
    print(id);
    var res = await http.get(
      Uri.parse(BASE_URL + 'orders/' + id),
      headers: headers,
    );
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      convertData.add(data);
      print(convertData);
      try {
        if (data != null) {
          convertData
              .map((orderDetail) =>
                  orderDetails.add(OrderDetailModel.fromJson(orderDetail)))
              .toList();
          return orderDetails;
        } else {
          res.body;
        }
      } catch (e) {
        res.body;
      }
    } else {
      res.body;
    }
  }

  getPackageServiceList() async {
    List<PackageServiceModel> packageServiceLists = [];
    var res = await http.get(
      Uri.parse(BASE_URL + "packages/content"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data
            .map((order) =>
                packageServiceLists.add(PackageServiceModel.fromJson(order)))
            .toList();
        return packageServiceLists;
      } else {
        return res.body;
      }
    } else {
      return res.body;
    }
  }

  getPackageServiceDetail(String id) async {
    List<PackageServiceDetailModel> orderDetails = [];
    List convertData = [];
    var res = await http.get(
      Uri.parse(BASE_URL + 'packages/' + id),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      convertData.add(data);
      try {
        if (data != null) {
          convertData
              .map((orderDetail) => orderDetails
                  .add(PackageServiceDetailModel.fromJson(orderDetail)))
              .toList();
          return orderDetails;
        } else {
          res.body;
        }
      } catch (e) {
        res.body;
      }
    } else {
      res.body;
    }
  }

  Future<List<ServiceModel>> getServiceList() async {
    List<ServiceModel> serviceLists = [];
    var res = await http.get(
      Uri.parse("https://carservicesystem.azurewebsites.net/api/Services"),
      headers: headers,
    );
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

  getManufacturerList() async {
    List<ManufacturerModel> manufacturerLists = [];

    var res = await http.get(
      Uri.parse(BASE_URL + "manufacturers"),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data
            .map((order) =>
                manufacturerLists.add(ManufacturerModel.fromJson(order)))
            .toList();
        return manufacturerLists;
      } else {
        return res.body;
      }
    }
  }

  getListModelOfManufacturer(String namuName) async {
    List<VehicleModels> modelOfManufacturer = [];
    var res = await http.get(
      Uri.parse(BASE_URL + "manufacturers/" + namuName),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data['vehicleModels']
            .map((order) =>
                modelOfManufacturer.add((VehicleModels.fromJson(order))))
            .toList();
        return modelOfManufacturer;
      } else {
        return res.body;
      }
    }
  }

  editProfile(String username, String fullname, String phoneNumber,
      String email, String address) async {
    print(username);
    final body = jsonEncode({
      "username": username,
      "email": email,
      "fullname": fullname,
      "phoneNumber": phoneNumber,
      "address": address
    });

    var res = await http.put(Uri.parse(BASE_URL + "customers"),
        headers: headers, body: body);
    final data = (res.body);
    if (data != null) {
      return data;
    } else {
      return res.body;
    }
  }

  getProfile(String username) async {
    String message;
    List convertData = [];
    List<CustomerProfileModel> cusProfile = [];
    var res = await http.get(Uri.parse(BASE_URL + "customers/" + username),
        headers: headers);
    final data = json.decode(res.body);
    convertData.add(data);
    if (res.statusCode == 200) {
      if (data != null) {
        convertData
            .map((e) => cusProfile.add(CustomerProfileModel.fromJson(e)))
            .toList();
        return cusProfile;
      } else {
        return 'Không tìm thấy thông tin người dùng';
      }
    } else if (res.statusCode == 404) {
      message =
          'Không tìm thấy thông tin người dùng ' + res.statusCode.toString();
      return message;
    } else {
      return res.body;
    }
  }

  getCoupon() async {
    String message;
    // List convertData = [];
    List<CouponModel> couponsList = [];
    var res = await http.get(Uri.parse(BASE_URL + "coupons"), headers: headers);
    final data = json.decode(res.body);
    print(data);
    if (res.statusCode == 200) {
      if (data != null) {
        data.map((e) => couponsList.add(CouponModel.fromJson(e))).toList();
        return couponsList;
      } else {
        return 'Không tìm thấy thông tin người dùng';
      }
    } else if (res.statusCode == 404) {
      message =
          'Không tìm thấy thông tin người dùng ' + res.statusCode.toString();
      return message;
    } else {
      return res.body;
    }
  }

  sendFeedbackOrder(String orderId, int rating, String description) async {
    final body = jsonEncode(
        {"orderId": orderId, "rating": rating, "description": description});
    var res = await http.post(Uri.parse(BASE_URL + "orders/feedback"),
        headers: headers, body: body);
    final data = (res.body);
    if (data != null) {
      return data;
    } else {
      return res.body;
    }
  }

  sendNoteReasonCancelBooking(
      String id, String managerNote, String customerNote) async {
    final body = jsonEncode(
        {"id": id, "managerNote": managerNote, "customerNote": customerNote});
    var res = await http.put(Uri.parse(BASE_URL + 'orders/note'),
        headers: headers, body: body);
    final data = res.body;
    if (data != null) {
      return data;
    } else {
      return data;
    }
  }
}
