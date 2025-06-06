import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? phone;
  String? password;
  bool? recieveNotificationsEmail;
  String? accountType;
  String? status;
  String? pictureUrl;
  String? lastLogin;
  String? resetPasswordToken;
  String? resetPasswordExpires;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.phone,
    this.password,
    this.recieveNotificationsEmail,
    this.accountType,
    this.status,
    this.pictureUrl,
    this.lastLogin,
    this.resetPasswordToken,
    this.resetPasswordExpires,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'email': email,
      'phone': phone,
      'password': password,
      'recieveNotificationsEmail': recieveNotificationsEmail,
      'accountType': accountType,
      'status': status,
      'pictureUrl': pictureUrl,
      'lastLogin': lastLogin,
      'resetPasswordToken': resetPasswordToken,
      'resetPasswordExpires': resetPasswordExpires,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      recieveNotificationsEmail:
          map['recieveNotificationsEmail'] != null
              ? map['recieveNotificationsEmail'] as bool
              : null,
      accountType:
          map['accountType'] != null ? map['accountType'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      pictureUrl:
          map['pictureUrl'] != null ? map['pictureUrl'] as String : null,
      lastLogin: map['lastLogin'] != null ? map['lastLogin'] as String : null,
      resetPasswordToken:
          map['resetPasswordToken'] != null
              ? map['resetPasswordToken'] as String
              : null,
      resetPasswordExpires:
          map['resetPasswordExpires'] != null
              ? map['resetPasswordExpires'] as String
              : null,
      createdBy: map['createdBy'] != null ? map['createdBy'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
