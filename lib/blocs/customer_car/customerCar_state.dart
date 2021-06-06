import 'package:car_service/utils/model/CarModel.dart';
import 'package:equatable/equatable.dart';

class CustomerCarState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class InitCustomerCarState extends CustomerCarState{}

class LoadingCusCarState extends CustomerCarState{}

class FetchCusCarSuccess extends CustomerCarState{
  List<CarModel> cars;
  FetchCusCarSuccess({this.cars});
}

class ErrorCusCarState extends CustomerCarState{
  String mess;
  ErrorCusCarState({this.mess});
}

class CusCarDetailSuccessState extends CustomerCarState{
  CarModel data;
  CusCarDetailSuccessState({this.data});
}

