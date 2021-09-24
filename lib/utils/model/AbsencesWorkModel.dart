class AbsencesWorkModel {
  String username;
  List<AbsencesWork> absences;

  AbsencesWorkModel({this.username, this.absences});

  AbsencesWorkModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    if (json['absences'] != null) {
      absences = new List<AbsencesWork>();
      json['absences'].forEach((v) {
        absences.add(new AbsencesWork.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    if (this.absences != null) {
      data['absences'] = this.absences.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AbsencesWork {
  String timeStart;
  String timeEnd;
  String noteEmp;

  AbsencesWork({this.timeStart, this.timeEnd, this.noteEmp});

  AbsencesWork.fromJson(Map<String, dynamic> json) {
    timeStart = json['timeStart'];
    timeEnd = json['timeEnd'];
    noteEmp = json['noteEmp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeStart'] = this.timeStart;
    data['timeEnd'] = this.timeEnd;
    data['noteEmp'] = this.noteEmp;
    return data;
  }
}