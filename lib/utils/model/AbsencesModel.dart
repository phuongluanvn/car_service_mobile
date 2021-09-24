class AbsencesModel {
  String id;
  String timeStart;
  String timeEnd;
  String noteEmp;
  Null noteAdmin;
  bool isApproved;

  AbsencesModel(
      {this.id,
      this.timeStart,
      this.timeEnd,
      this.noteEmp,
      this.noteAdmin,
      this.isApproved});

  AbsencesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeStart = json['timeStart'];
    timeEnd = json['timeEnd'];
    noteEmp = json['noteEmp'];
    noteAdmin = json['noteAdmin'];
    isApproved = json['isApproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['timeStart'] = this.timeStart;
    data['timeEnd'] = this.timeEnd;
    data['noteEmp'] = this.noteEmp;
    data['noteAdmin'] = this.noteAdmin;
    data['isApproved'] = this.isApproved;
    return data;
  }
}