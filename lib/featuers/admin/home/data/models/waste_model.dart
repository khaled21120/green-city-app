class WasteModel {
  final String id;
  final String wasteType;
  final String description;
  final double pricePerKg;
  final double availableQuantity;
  final String imageUrl;

  WasteModel({
    required this.id,
    required this.wasteType,
    required this.description,
    required this.pricePerKg,
    required this.availableQuantity,
    required this.imageUrl,
  });

  // Convert to Map for Firestore/API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'wasteType': wasteType,
      'description': description,
      'pricePerKg': pricePerKg,
      'availableQuantity': availableQuantity,
      'imageUrl': imageUrl,
    };
  }

  factory WasteModel.fromJson(Map<String, dynamic> map) {
    return WasteModel(
      id: map['id'] ?? '',
      wasteType: map['wasteType'] ?? '',
      description: map['description'] ?? '',
      pricePerKg: map['pricePerKg']?.toDouble() ?? 0.0,
      availableQuantity: map['availableQuantity']?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'],
    );
  }
}
