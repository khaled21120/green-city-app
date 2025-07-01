import 'package:equatable/equatable.dart';

class ActivitiesModel extends Equatable {
  final int? id;
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
        id: json['id'] as int?,
        actName: json['actName'] as String?,
        imgFile: json['photo'] as String?,
        actDescription: json['actDescription'] as String?,
        actIntervalDate: json['actIntervalDate'] as String?,
        actstate: json['actState'] as String?,
        numOfSubscribers: json['numOfSubscribers'] as int?,
        numOfRequiredSubscribers: json['numOfRequiredSubscribers'] as int?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'ActName': actName,
    'photo': imgFile,
    'ActDescription': actDescription,
    'actIntervalDate': actIntervalDate,
    'actState': actstate,
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
