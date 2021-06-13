part of 'services.dart';

class CarServices implements Services {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void init() {
    // TODO: implement init
  }
  List<CarModel> car = [];

  static Future<ServiceResult<List<CarModel>>> getCars(
      {http.Client client}) async {
    client ??= http.Client();
    try {
      String url =
          "https://movie0706.cybersoft.edu.vn/api/QuanLyPhim/LayDanhSachPhim?maNhom=GP01";

      var response =
          await client.get(url, headers: {"Accept": "application/json"});
      print(response.body);
      print("object");

      if (response.body != null) {
        var data = jsonDecode(response.body);
        print(response.body);
        List carModel = (data as Iterable)
            .map((e) => (CarModel.fromJson(e)))
            .toList();
            print(carModel);
        return ServiceResult(data: carModel);
      } else {
        return ServiceResult(
            status: false, message: "Status Code ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return ServiceResult(status: false, message: e.toString());
    }
  }

  // Get Movie Detail
  static Future<CarModel> getCarDetail(CarModel carModel,
      {http.Client client}) async {
    client ??= http.Client();

    try {
      String url =
          'https://movie0706.cybersoft.edu.vn/api/QuanLyPhim/LayDanhSachPhim?maNhom=GP01&tenPhim=' +carModel.tenPhim;

      var response =
          await client.get(url, headers: {"Accept": "application/json"});

      if (response != null) {
        var data = jsonDecode(response.body);

        final result = data;
        print(result);

        return CarModel.fromJson(result);
      }
    } catch (e) {
      print(e);
    }
  }
}
