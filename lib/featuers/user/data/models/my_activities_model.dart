import 'package:equatable/equatable.dart';

class MyActivitiesModel extends Equatable {
  final String? userName;
  final int? userId;
  final String? userEmail;
  final String? activityName;
  final String? activityDescription;
  final String? activityIntervalDate;

  const MyActivitiesModel({
    this.userName,
    this.userId,
    this.userEmail,
    this.activityName,
    this.activityDescription,
    this.activityIntervalDate,
  });

  factory MyActivitiesModel.fromJson(Map<String, dynamic> json) {
    return MyActivitiesModel(
      userName: json['userName'] as String?,
      userId: json['userId'] as int?,
      userEmail: json['userEmail'] as String?,
      activityName: json['activityName'] as String?,
      activityDescription: json['activityDescription'] as String?,
      activityIntervalDate: json['activityIntervalDate'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'userId': userId,
    'userEmail': userEmail,
    'activityName': activityName,
    'activityDescription': activityDescription,
    'activityIntervalDate': activityIntervalDate,
  };

  @override
  List<Object?> get props {
    return [
      userName,
      userId,
      userEmail,
      activityName,
      activityDescription,
      activityIntervalDate,
    ];
  }
}
