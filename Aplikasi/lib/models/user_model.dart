import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final String phoneNumber;
  final bool isProvider;
  final bool emailVerified;
  final bool phoneVerified;
  final bool isVerified;
  final String ktmUrl;
  final String ktpUrl;
  final String selfieKtpUrl;
  final String authMethod;
  final DateTime createdAt;

  UserModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.isProvider,
    required this.emailVerified,
    required this.phoneVerified,
    required this.isVerified,
    required this.ktmUrl,
    required this.ktpUrl,
    required this.selfieKtpUrl,
    required this.authMethod,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      isProvider: json['isProvider'] ?? false,
      emailVerified: json['emailVerified'] ?? false,
      phoneVerified: json['phoneVerified'] ?? false,
      isVerified: json['isVerified'] ?? false,
      ktmUrl: json['ktmUrl'] ?? '',
      ktpUrl: json['ktpUrl'] ?? '',
      selfieKtpUrl: json['selfieKtpUrl'] ?? '',
      authMethod: json['authMethod'] ?? 'email',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'isProvider': isProvider,
      'emailVerified': emailVerified,
      'phoneVerified': phoneVerified,
      'isVerified': isVerified,
      'ktmUrl': ktmUrl,
      'ktpUrl': ktpUrl,
      'selfieKtpUrl': selfieKtpUrl,
      'authMethod': authMethod,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
