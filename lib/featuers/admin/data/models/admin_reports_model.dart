import 'package:equatable/equatable.dart';

class AdminReportsModel extends Equatable {
  final String? warehouseManger;
  final String? warehouseName;
  final String? sendAt;
  final String? material;
  final int? quantity;
  final int? price;
  final String? description;

  const AdminReportsModel({
    this.warehouseManger,
    this.warehouseName,
    this.sendAt,
    this.material,
    this.quantity,
    this.price,
    this.description,
  });

  factory AdminReportsModel.fromJson(Map<String, dynamic> json) {
    return AdminReportsModel(
      warehouseManger: json['warehouseManger'] as String?,
      warehouseName: json['warehouseName'] as String?,
      sendAt: json['sendAt'] as String?,
      material: json['material'] as String?,
      quantity: json['quantity'] as int?,
      price: json['price'] as int?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'warehouseManger': warehouseManger,
    'warehouseName': warehouseName,
    'sendAt': sendAt,
    'material': material,
    'quantity': quantity,
    'price': price,
    'description': description,
  };

  @override
  List<Object?> get props {
    return [
      warehouseManger,
      warehouseName,
      sendAt,
      material,
      quantity,
      price,
      description,
    ];
  }
}
