// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
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
    this.role,
    this.address,
    this.profileImage,
    this.numOfAcceptedAnnouncementsCount,
    this.numOfCompletedActivitiesCount,
    this.numOfCompletedPollsCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      password: json['password'] as String?,
      address: json['address'] as String?,
      profileImage: json['profileImage'] as String?,
      numOfAcceptedAnnouncementsCount:
          json['numOfAcceptedAnnouncementsCount'] ?? 0,
      numOfCompletedActivitiesCount: json['numOfCompletedActivitiesCount'] ?? 0,
      numOfCompletedPollsCount: json['numOfCompletedPollsCount'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'role': role,
    'password': password,
    'address': address,
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
      role,
      address,
      profileImage,
      numOfAcceptedAnnouncementsCount,
      numOfCompletedActivitiesCount,
      numOfCompletedPollsCount,
    ];
  }
}
