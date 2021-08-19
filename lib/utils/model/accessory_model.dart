import 'package:equatable/equatable.dart';

class AccessoryModel extends Equatable {
  final String id;
  final String name;
  final int quantity;
  final int price;
  final String unit;
  final String imageUrl;
  final String type;
  final String manufacturer;

  const AccessoryModel({
    this.id,
    this.name,
    this.quantity,
    this.price,
    this.unit,
    this.imageUrl,
    this.type,
    this.manufacturer,
  });

  factory AccessoryModel.fromJson(Map<String, dynamic> json) => AccessoryModel(
        id: json['id'] as String,
        name: json['name'] as String,
        quantity: json['quantity'] as int,
        price: json['price'] as int,
        unit: json['unit'] as String,
        imageUrl: json['imageUrl'] as String,
        type: json['type'] as String,
        manufacturer: json['manufacturer'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'quantity': quantity,
        'price': price,
        'unit': unit,
        'imageUrl': imageUrl,
        'type': type,
        'manufacturer': manufacturer,
      };

  AccessoryModel copyWith({
    String id,
    String name,
    int quantity,
    int price,
    String unit,
    String imageUrl,
    String type,
    String manufacturer,
  }) {
    return AccessoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      manufacturer: manufacturer ?? this.manufacturer,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      quantity,
      price,
      unit,
      imageUrl,
      type,
      manufacturer,
    ];
  }
}
