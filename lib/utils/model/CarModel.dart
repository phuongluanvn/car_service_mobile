import 'package:equatable/equatable.dart';

class CarModel extends Equatable {
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

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        maPhim: json['maPhim'],
        tenPhim: json['tenPhim'],
        biDanh: json['biDanh'],
        trailer: json['trailer'],
        hinhAnh: json['hinhAnh'],
        moTa: json['moTa'],
        maNhom: json['maNhom'],
        ngayKhoiChieu: json['ngayKhoiChieu'],
        danhGia: json['danhGia'],
      );

  @override
  // TODO: implement props
  List<Object> get props => [maPhim, tenPhim, biDanh, trailer,
   hinhAnh, moTa, maNhom, ngayKhoiChieu, danhGia];
}
