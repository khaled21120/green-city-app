import 'package:equatable/equatable.dart';

class UserReportsModel extends Equatable {
  final int? id;
  final String? userName;
  final String? email;
  final String? announcementType;
  final String? announcementDescription;
  final String? siteLocation;
  final String? binNumber;
  final String? region;
  final String? todayDate;
  final String? photoFile;
  final String? status;

  const UserReportsModel({
    this.id,
    this.userName,
    this.email,
    this.binNumber,
    this.region,
    this.announcementType,
    this.announcementDescription,
    this.siteLocation,
    this.todayDate,
    this.photoFile,
    this.status,
  });

  factory UserReportsModel.fromJson(Map<String, dynamic> json) =>
      UserReportsModel(
        id: json['id'] as int?,
        userName: json['userName'] as String?,
        email: json['email'] as String?,
        binNumber: json['binNumber'] as String?,
        region: json['regionName'] as String?,
        announcementType: json['announcementType'] as String?,
        announcementDescription: json['announcementDescription'] as String?,
        siteLocation: json['siteLocation'] as String?,
        todayDate: json['todayDate'] as String?,
        photoFile: json['photoFile'] as String?,
        status: json['status'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'regionName': region,
    'UserName': userName,
    'Email': email,
    'AnnouncementType': announcementType,
    'AnnouncementDescription': announcementDescription,
    'BinNumber': binNumber,
    'SiteLocation': siteLocation,
    'TodayDate': todayDate,
    'PhotoFile': photoFile,
  };

  @override
  List<Object?> get props {
    return [
      id,
      userName,
      email,
      announcementType,
      binNumber,
      region,
      announcementDescription,
      siteLocation,
      todayDate,
      photoFile,
      status,
    ];
  }
}
