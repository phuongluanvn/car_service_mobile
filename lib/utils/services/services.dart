import 'dart:convert';

import 'package:car_service/utils/model/CarModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'car_services.dart';

abstract class Services {
  void init();
  void dispose();
}

class ServiceResult<T> {
  @required
  bool status;

  T data;
  String message;

  ServiceResult({this.data, this.message, this.status});
}
