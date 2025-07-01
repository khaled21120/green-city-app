import 'package:equatable/equatable.dart';

class UserReportsModel extends Equatable {
  final int? id;
  final String? userName;
  final String? email;
  final String? announcementType;
  final String? announcementDescription;
  final String? siteLocation;
  final int? binNumber;
  final String? region;
  final String? todayDate;
  final String? photoFile;
  final String? status;
  final String? contactNumber;
  final String? institutionName;
  final String? subscriptionType;
  final String? institutionType;
  final String? paymentMethod;
  final String? startDate;
  final String? startTime;
  final double? price;
  final String? subscriptionDuration;
  final String? additionalNotes;
  final String? institutionAddress;

  const UserReportsModel({
    this.contactNumber,
    this.institutionName,
    this.subscriptionType,
    this.institutionType,
    this.paymentMethod,
    this.startDate,
    this.startTime,
    this.id,
    this.userName,
    this.price,
    this.email,
    this.binNumber,
    this.region,
    this.announcementType,
    this.announcementDescription,
    this.subscriptionDuration,
    this.siteLocation,
    this.todayDate,
    this.photoFile,
    this.status,
    this.institutionAddress,
    this.additionalNotes,
  });

  factory UserReportsModel.fromJson(Map<String, dynamic> json) =>
      UserReportsModel(
        id: json['id'] as int?,
        userName: json['userName'] as String?,
        email: json['email'] as String?,
        binNumber: json['binNumber'] as int?,
        region: json['regionName'] as String?,
        announcementType: json['announcementType'] as String?,
        announcementDescription: json['announcementDescription'] as String?,
        siteLocation: json['siteLocation'] as String?,
        todayDate: json['todayDate'] as String?,
        photoFile: json['photoFile'] as String?,
        status: json['status'] as String?,
        contactNumber: json['contactNumber'] as String?,
        institutionName: json['institutionName'] as String?,
        subscriptionType: json['subscriptionType'] as String?,
        institutionType: json['institutionType'] as String?,
        paymentMethod: json['paymentMethod'] as String?,
        startDate: json['startDate'] as String?,
        startTime: json['startTime'] as String?,
        price: json['price'] as double?,
        subscriptionDuration: json['subscriptionDuration'] as String?,
        additionalNotes: json['additionalNotes'] as String?,
        institutionAddress: json['institutionAddress'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'email': email,
    'institutionName': institutionName,
    'institutionType': institutionType,
    'contactNumber': contactNumber,
    'additionalNotes': announcementDescription,
    'institutionAddress': siteLocation,
    'subscriptionDuration': subscriptionDuration,
    'subscriptionType': subscriptionType,
    'paymentMethod': paymentMethod,
    'startDate': startDate,
    'startTime': startTime,
    'price': price,
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
      contactNumber,
      institutionName,
      subscriptionType,
      institutionType,
      paymentMethod,
      startDate,
      startTime,
      price,
      subscriptionDuration,
    ];
  }
}
