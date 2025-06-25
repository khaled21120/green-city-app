class ContactUsModel {
  final String? name;
  final String? email;
  final String? message;

  ContactUsModel({this.name, this.email, this.message});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'name': name, 'email': email, 'message': message};
  }

  factory ContactUsModel.fromJson(Map<String, dynamic> map) {
    return ContactUsModel(
      name: map['name'] as String?,
      email: map['email'] as String?,
      message: map['message'] as String?,
    );
  }
}
