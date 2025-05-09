import 'package:equatable/equatable.dart';

class AnnounsModel extends Equatable {
  final int? id;
  final String? userName;
  final String? email;
  final String? announcementType;
  final String? announcementDescription;
  final String? siteLocation;
  final String? todayDate;
  final String? photoFile;
  final String? status;

  const AnnounsModel({
    this.id,
    this.userName,
    this.email,
    this.announcementType,
    this.announcementDescription,
    this.siteLocation,
    this.todayDate,
    this.photoFile,
    this.status,
  });

  factory AnnounsModel.fromJson(Map<String, dynamic> json) => AnnounsModel(
    id: json['id'] as int?,
    userName: json['userName'] as String?,
    email: json['email'] as String?,
    announcementType: json['announcementType'] as String?,
    announcementDescription: json['announcementDescription'] as String?,
    siteLocation: json['siteLocation'] as String?,
    todayDate: json['todayDate'] as String?,
    photoFile: json['photoFile'] as String?,
    status: json['status'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userName': userName,
    'email': email,
    'announcementType': announcementType,
    'announcementDescription': announcementDescription,
    'siteLocation': siteLocation,
    'todayDate': todayDate,
    'photoFile': photoFile,
    'status': status,
  };

  @override
  List<Object?> get props {
    return [
      id,
      userName,
      email,
      announcementType,
      announcementDescription,
      siteLocation,
      todayDate,
      photoFile,
      status,
    ];
  }
}
