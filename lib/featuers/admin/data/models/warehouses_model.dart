import 'package:equatable/equatable.dart';

class WarehousesModel extends Equatable {
  final int? id;
  final String? warehouseName;
  final String? address;
  final int? totalCapacity;
  final int? currnetCapacity;

  const WarehousesModel({
    this.id,
    this.warehouseName,
    this.address,
    this.totalCapacity,
    this.currnetCapacity,
  });

  factory WarehousesModel.fromJson(Map<String, dynamic> json) {
    return WarehousesModel(
      id: json['id'] as int?,
      warehouseName: json['warehouseName'] as String?,
      address: json['address'] as String?,
      totalCapacity: json['totalCapacity'] as int?,
      currnetCapacity: json['currnetCapacity'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'warehouseName': warehouseName,
    'address': address,
    'totalCapacity': totalCapacity,
    'currnetCapacity': currnetCapacity,
  };

  @override
  List<Object?> get props {
    return [id, warehouseName, address, totalCapacity, currnetCapacity];
  }
}
