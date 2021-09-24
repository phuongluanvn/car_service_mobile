import 'package:equatable/equatable.dart';

class ImageModel extends Equatable {
  String imageUrl;
  bool isRequest;

  ImageModel({this.imageUrl: '', this.isRequest: true});

  ImageModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    isRequest = json['isRequest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['isRequest'] = this.isRequest;
    return data;
  }

  ImageModel copyWith(String username, bool isLeader) {
    return ImageModel(
        imageUrl: imageUrl ?? this.imageUrl,
        isRequest: isRequest ?? this.isRequest);
  }

  @override
  // TODO: implement props
  List<Object> get props => [this.imageUrl, this.isRequest];
}
