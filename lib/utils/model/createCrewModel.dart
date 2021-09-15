import 'package:equatable/equatable.dart';

class CreateCrewModel extends Equatable{
  String username;
  bool isLeader;

  CreateCrewModel({this.username: '', this.isLeader: false});

  CreateCrewModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    isLeader = json['isLeader'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['isLeader'] = this.isLeader;
    return data;
  }

  CreateCrewModel copyWith(String username, bool isLeader) {
    return CreateCrewModel(
        username: username ?? this.username,
        isLeader: isLeader ?? this.isLeader);
  }

  @override
  // TODO: implement props
  List<Object> get props => [this.username, this.isLeader];
}
