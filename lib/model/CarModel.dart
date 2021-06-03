class CarModel {
  int maPhim;
  String tenPhim;
  String biDanh;
  String trailer;
  String hinhAnh;
  String moTa;
  String maNhom;
  String ngayKhoiChieu;
  int danhGia;

  CarModel(
      {this.maPhim,
      this.tenPhim,
      this.biDanh,
      this.trailer,
      this.hinhAnh,
      this.moTa,
      this.maNhom,
      this.ngayKhoiChieu,
      this.danhGia});

  CarModel.fromJson(Map<String, dynamic> json) {
    maPhim = json['maPhim'];
    tenPhim = json['tenPhim'];
    biDanh = json['biDanh'];
    trailer = json['trailer'];
    hinhAnh = json['hinhAnh'];
    moTa = json['moTa'];
    maNhom = json['maNhom'];
    ngayKhoiChieu = json['ngayKhoiChieu'];
    danhGia = json['danhGia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maPhim'] = this.maPhim;
    data['tenPhim'] = this.tenPhim;
    data['biDanh'] = this.biDanh;
    data['trailer'] = this.trailer;
    data['hinhAnh'] = this.hinhAnh;
    data['moTa'] = this.moTa;
    data['maNhom'] = this.maNhom;
    data['ngayKhoiChieu'] = this.ngayKhoiChieu;
    data['danhGia'] = this.danhGia;
    return data;
  }
}
