import 'package:equatable/equatable.dart';

class AbsencesModel {
  List<Absences> absences;

  AbsencesModel({this.absences});

  AbsencesModel.fromJson(Map<String, dynamic> json) {
    if (json['absences'] != null) {
      absences = new List<Absences>();
      json['absences'].forEach((v) {
        absences.add(new Absences.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.absences != null) {
      data['absences'] = this.absences.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Absences extends Equatable{
  String empUsername;
  String timeStart;
  String timeEnd;
  String noteEmp;

  Absences({this.empUsername, this.timeStart, this.timeEnd, this.noteEmp});

  Absences.fromJson(Map<String, dynamic> json) {
    empUsername = json['empUsername'];
    timeStart = json['timeStart'];
    timeEnd = json['timeEnd'];
    noteEmp = json['noteEmp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empUsername'] = this.empUsername;
    data['timeStart'] = this.timeStart;
    data['timeEnd'] = this.timeEnd;
    data['noteEmp'] = this.noteEmp;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [{this.empUsername, this.timeStart, this.timeEnd, this.noteEmp}];
}