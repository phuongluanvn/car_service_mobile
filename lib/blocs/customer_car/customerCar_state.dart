import 'package:car_service/model/CarModel.dart';
import 'package:equatable/equatable.dart';

class CustomerCarState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class InitState extends CustomerCarState{}

class LoadingState extends CustomerCarState{}

class FetchSuccess extends CustomerCarState{
  List<CarModel> cars;
  FetchSuccess({this.cars});
}

class ErrorState extends CustomerCarState{
  String mess;
  ErrorState({this.mess});
}