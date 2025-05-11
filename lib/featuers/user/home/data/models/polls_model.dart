import 'package:equatable/equatable.dart';

class PollsModel extends Equatable {
  final int? id;
  final String? pollName;
  final String? pollDesc;
  final String? pollEndDate;
  final String? pollFormLink;
  final String? imgFile;
  final int? numOfSubscribers;

  const PollsModel({
    this.id,
    this.pollName,
    this.numOfSubscribers,
    this.pollDesc,
    this.pollEndDate,
    this.pollFormLink,
    this.imgFile,
  });

  factory PollsModel.fromJson(Map<String, dynamic> json) => PollsModel(
    id: json['id'] as int?,
    pollName: json['pollName'] as String?,
    pollDesc: json['pollDesc'] as String?,
    pollEndDate: json['pollEndDate'] as String?,
    pollFormLink: json['pollFormLink'] as String?,
    numOfSubscribers: json['NumOfSubscribers'] as int?,
    imgFile: json['imgFile'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'pollName': pollName,
    'pollDesc': pollDesc,
    'pollEndDate': pollEndDate,
    'pollFormLink': pollFormLink,
    'NumOfSubscribers': numOfSubscribers,
    'imgFile': imgFile,
  };

  @override
  List<Object?> get props {
    return [
      id,
      pollName,
      pollDesc,
      numOfSubscribers,
      pollEndDate,
      pollFormLink,
      imgFile,
    ];
  }
}
