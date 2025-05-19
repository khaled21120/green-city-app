import 'package:equatable/equatable.dart';

class PollsModel extends Equatable {
  final int? id;
  final String? pollName;
  final String? pollDesc;
  final String? pollEndDate;
  final String? pollLink;
  final String? photo;
  final int? numOfSubscribers;

  const PollsModel({
    this.id,
    this.pollName,
    this.numOfSubscribers,
    this.pollDesc,
    this.pollEndDate,
    this.pollLink,
    this.photo,
  });

  factory PollsModel.fromJson(Map<String, dynamic> json) => PollsModel(
    id: json['id'] as int?,
    pollName: json['pollName'] as String?,
    pollDesc: json['pollDesc'] as String?,
    pollEndDate: json['pollEndDate'] as String?,
    pollLink: json['pollLink'] as String?,
    numOfSubscribers: json['NumOfSubscribers'] as int?,
    photo: json['photo'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'pollName': pollName,
    'pollDesc': pollDesc,
    'pollEndDate': pollEndDate,
    'pollLink': pollLink,
    'NumOfSubscribers': numOfSubscribers,
    'photo': photo,
  };

  @override
  List<Object?> get props {
    return [
      id,
      pollName,
      pollDesc,
      numOfSubscribers,
      pollEndDate,
      pollLink,
      photo,
    ];
  }
}
