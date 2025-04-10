import 'package:equatable/equatable.dart';

class PollsModel extends Equatable {
  final String? id;
  final String? pollName;
  final String? pollDesc;
  final String? pollEndDate;
  final String? pollFormLink;
  final String? imgFile;

  const PollsModel({
    this.id,
    this.pollName,
    this.pollDesc,
    this.pollEndDate,
    this.pollFormLink,
    this.imgFile,
  });

  factory PollsModel.fromJson(Map<String, dynamic> json) => PollsModel(
    id: json['id'] as String?,
    pollName: json['pollName'] as String?,
    pollDesc: json['pollDesc'] as String?,
    pollEndDate: json['pollEndDate'] as String?,
    pollFormLink: json['pollFormLink'] as String?,
    imgFile: json['imgFile'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'pollName': pollName,
    'pollDesc': pollDesc,
    'pollEndDate': pollEndDate,
    'pollFormLink': pollFormLink,
    'imgFile': imgFile,
  };

  @override
  List<Object?> get props {
    return [id, pollName, pollDesc, pollEndDate, pollFormLink, imgFile];
  }
}
