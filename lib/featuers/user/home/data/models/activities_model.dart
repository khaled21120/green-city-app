import 'package:equatable/equatable.dart';

class ActivitiesModel extends Equatable {
  final String? id;
  final String? actName;
  final String? actDescription;
  final String? actIntervalDate;
  final String? actstate;
  final String? imgFile;
  final int? numOfSubscribers;
  final int? numOfRequiredSubscribers;

  const ActivitiesModel({
    this.id,
    this.actName,
    this.actDescription,
    this.actIntervalDate,
    this.actstate,
    this.imgFile,
    this.numOfSubscribers,
    this.numOfRequiredSubscribers,
  });

  factory ActivitiesModel.fromJson(Map<String, dynamic> json) =>
      ActivitiesModel(
        id: json['id'] as String?,
        actName: json['ActName'] as String?,
        imgFile: json['imgFile'] as String?,
        actDescription: json['ActDescription'] as String?,
        actIntervalDate: json['actIntervalDate'] as String?,
        actstate: json['actstate'] as String?,
        numOfSubscribers: json['NumOfSubscribers'] as int?,
        numOfRequiredSubscribers: json['NumOfRequiredSubscribers'] as int?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'ActName': actName,
    'imgFile': imgFile,
    'ActDescription': actDescription,
    'actIntervalDate': actIntervalDate,
    'actstate': actstate,
    'NumOfSubscribers': numOfSubscribers,
    'NumOfRequiredSubscribers': numOfRequiredSubscribers,
  };

  @override
  List<Object?> get props {
    return [
      id,
      actName,
      actDescription,
      imgFile,
      actIntervalDate,
      actstate,
      numOfSubscribers,
      numOfRequiredSubscribers,
    ];
  }
}
