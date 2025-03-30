import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? address;
  final String? profileImage;
  final int? numOfAcceptedAnnouncementsCount;
  final int? numOfCompletedActivitiesCount;
  final int? numOfCompletedPollsCount;

  const UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.address,
    this.profileImage,
    this.numOfAcceptedAnnouncementsCount,
    this.numOfCompletedActivitiesCount,
    this.numOfCompletedPollsCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    phone: json['phone'] as String?,
    password: json['password'] as String?,
    address: json['Address'] as String?,
    profileImage: json['profileImage'] as String?,
    numOfAcceptedAnnouncementsCount:
        json['numOfAcceptedAnnouncementsCount'] as int?,
    numOfCompletedActivitiesCount:
        json['numOfCompletedActivitiesCount'] as int?,
    numOfCompletedPollsCount: json['numOfCompletedPollsCount'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'password': password,
    'Address': address,
    'profileImage': profileImage,
    'numOfAcceptedAnnouncementsCount': numOfAcceptedAnnouncementsCount,
    'numOfCompletedActivitiesCount': numOfCompletedActivitiesCount,
    'numOfCompletedPollsCount': numOfCompletedPollsCount,
  };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      phone,
      password,
      address,
      profileImage,
      numOfAcceptedAnnouncementsCount,
      numOfCompletedActivitiesCount,
      numOfCompletedPollsCount,
    ];
  }
}
