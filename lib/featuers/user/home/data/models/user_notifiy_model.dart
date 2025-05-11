import 'package:equatable/equatable.dart';

class UserNotifiyModel extends Equatable {
  final String? id;
  final String? notificationContent;
  final String? notificationDate;
  final String? userId;

  const UserNotifiyModel({
    this.id,
    this.notificationContent,
    this.notificationDate,
    this.userId,
  });

  factory UserNotifiyModel.fromJson(Map<String, dynamic> json) =>
      UserNotifiyModel(
        id: json['id'] as String?,
        notificationContent: json['notificationContent'] as String?,
        notificationDate: json['notificationDate'] as String?,
        userId: json['userId'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'notificationContent': notificationContent,
    'notificationDate': notificationDate,
    'userId': userId,
  };

  @override
  List<Object?> get props {
    return [id, notificationContent, notificationDate, userId];
  }
}
