import 'package:car_service/utils/model/CarModel.dart';
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

// '{
//   "vehicleId": "e42d42cf-af6b-4e15-89df-264a7bb9ffee",
//   "packageId": null,
//   "note": "Hông có",
//   "bookingTime": "2021-07-05T15:14:57.644Z"
// }'

  createNewBooking(String vehicleId, String packageId, String note,
      String bookingTime) async {
    var body = {
      "vehicleId": '$vehicleId',
      "packageId": packageId,
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
        return res.body;
      } else if (res.statusCode == 404) {
        return res.body;
      }
    } else {
      return null;
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
      }
    } else {
      return null;
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

  Future<List<VehicleModel>> getVehicleDetail(String vehicleId) async {
    var res = await http.get(
      Uri.parse(
          'https://movie0706.cybersoft.edu.vn/api/QuanLyNguoiDung/LayDanhSachNguoiDung?MaNhom=GP01&tuKhoa=' +
              vehicleId),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      try {
        if (data != null) {
          List<VehicleModel> listdata = [];
          data.forEach((element) {
            Map<String, dynamic> map = element;
            listdata.add(VehicleModel.fromJson(map));
          });
          return listdata;
        } else {
          print('No data');
        }
      } catch (e) {
        print(e.toString());
      }
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
      Uri.parse(BASE_URL + 'Orders/' + id),
      headers: headers,
    );
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      convertData.add(data);
      print(convertData);
      try {
        if (data != null) {
          print('jịịịịịi');
          convertData
              .map((orderDetail) =>
                  orderDetails.add(OrderDetailModel.fromJson(orderDetail)))
              .toList();
              print('?????');
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

  Future<List<ManufacturerModel>> getManufacturerList() async {
    List<ManufacturerModel> manufacturerLists = [];

    var res = await http.get(
      Uri.parse( BASE_URL+ "Manufacturers"),
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
        print('No manufacturer data');
        return null;
      }
    }
  }

  Future<List<String>> getListModelOfManufacturer(String namuName) async {
    List<String> modelOfManufacturer = [];
    var res = await http.get(
      Uri.parse(
          BASE_URL+"Manufacturers/" +
              namuName),
      headers: headers,
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data != null) {
        data['vehicleModels']
            .map((order) => modelOfManufacturer.add((order)))
            .toList();
        return modelOfManufacturer;
      } else {
        print('No manufacturer data');
        return null;
      }
    }
  }
}
