import 'package:equatable/equatable.dart';

class AnnounsModel extends Equatable {
  final String? id;
  final String? userName;
  final String? email;
  final String? announcementType;
  final String? announcementDescription;
  final String? region;
  final String? binNumber;
  final String? siteLocation;
  final String? todayDate;
  final String? photoFile;
  final String? userId;

  const AnnounsModel({
    this.id,
    this.userName,
    this.email,
    this.announcementType,
    this.announcementDescription,
    this.region,
    this.binNumber,
    this.siteLocation,
    this.todayDate,
    this.photoFile,
    this.userId,
  });

  factory AnnounsModel.fromJson(Map<String, dynamic> json) => AnnounsModel(
    id: json['id'] as String?,
    userName: json['userName'] as String?,
    email: json['email'] as String?,
    announcementType: json['AnnouncementType'] as String?,
    announcementDescription: json['AnnouncementDescription'] as String?,
    region: json['region'] as String?,
    binNumber: json['binNumber'] as String?,
    siteLocation: json['siteLocation'] as String?,
    todayDate: json['todayDate'] as String?,
    photoFile: json['photoFile'] as String?,
    userId: json['userId'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userName': userName,
    'email': email,
    'AnnouncementType': announcementType,
    'AnnouncementDescription': announcementDescription,
    'region': region,
    'binNumber': binNumber,
    'siteLocation': siteLocation,
    'todayDate': todayDate,
    'photoFile': photoFile,
    'userId': userId,
  };

  @override
  List<Object?> get props {
    return [
      id,
      userName,
      email,
      announcementType,
      announcementDescription,
      region,
      binNumber,
      siteLocation,
      todayDate,
      photoFile,
      userId,
    ];
  }
}
