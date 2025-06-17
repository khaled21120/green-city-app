import 'package:equatable/equatable.dart';

class DriverReportsModel extends Equatable {
  final String? driverName;
  final String? reportDesc;
  final String? sentAt;
  final int? announcementsId;
  final String? photoFile;

  const DriverReportsModel({
    this.driverName,
    this.reportDesc,
    this.sentAt,
    this.announcementsId,
    this.photoFile,
  });

  factory DriverReportsModel.fromJson(Map<String, dynamic> json) {
    return DriverReportsModel(
      driverName: json['driverName'] as String?,
      reportDesc: json['reportDESC'] as String?,
      sentAt: json['sentAt'] as String?,
      announcementsId: json['announcementsID'] as int?,
      photoFile: json['photoFile'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'driverName': driverName,
    'reportDESC': reportDesc,
    'sentAt': sentAt,
    'announcementsID': announcementsId,
    'photoFile': photoFile,
  };

  @override
  List<Object?> get props {
    return [driverName, reportDesc, sentAt, announcementsId, photoFile];
  }
}
