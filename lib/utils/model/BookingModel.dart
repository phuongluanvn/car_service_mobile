class BookingModel {
  String taiKhoan;
  String hoTen;
  String email;
  String soDt;
  String matKhau;
  String maLoaiNguoiDung;

  BookingModel(
      {this.taiKhoan,
      this.hoTen,
      this.email,
      this.soDt,
      this.matKhau,
      this.maLoaiNguoiDung});

  BookingModel.fromJson(Map<String, dynamic> json) {
    taiKhoan = json['taiKhoan'];
    hoTen = json['hoTen'];
    email = json['email'];
    soDt = json['soDt'];
    matKhau = json['matKhau'];
    maLoaiNguoiDung = json['maLoaiNguoiDung'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taiKhoan'] = this.taiKhoan;
    data['hoTen'] = this.hoTen;
    data['email'] = this.email;
    data['soDt'] = this.soDt;
    data['matKhau'] = this.matKhau;
    data['maLoaiNguoiDung'] = this.maLoaiNguoiDung;
    return data;
  }
}
