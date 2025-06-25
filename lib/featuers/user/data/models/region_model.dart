import 'package:equatable/equatable.dart';

class RegionModel extends Equatable {
  final int? id;
  final String? regionName;
  final int? numOfBins;

  const RegionModel({this.id, this.regionName, this.numOfBins});

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
    id: json['id'] as int?,
    regionName: json['regionName'] as String?,
    numOfBins: json['numOfBins'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'regionName': regionName,
    'numOfBins': numOfBins,
  };

  @override
  List<Object?> get props => [id, regionName, numOfBins];
}
