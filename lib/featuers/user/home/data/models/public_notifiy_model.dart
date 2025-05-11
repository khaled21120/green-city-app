import 'package:equatable/equatable.dart';

class PublicNotifiyModel extends Equatable {
  final String? id;
  final String? notificationContent;
  final String? notificationDate;

  const PublicNotifiyModel({
    this.id,
    this.notificationContent,
    this.notificationDate,
  });

  factory PublicNotifiyModel.fromJson(Map<String, dynamic> json) =>
      PublicNotifiyModel(
        id: json['id'] as String?,
        notificationContent: json['notificationContent'] as String?,
        notificationDate: json['notificationDate'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'notificationContent': notificationContent,
    'notificationDate': notificationDate,
  };

  @override
  List<Object?> get props {
    return [id, notificationContent, notificationDate];
  }
}
