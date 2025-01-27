import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uuid;
  final DateTime createdAt;
  final String role;

  UserModel({
    required this.email,
    required this.uuid,
    required this.createdAt,
    required this.role,
  });

  // Factory constructor to create a UserModel from Firestore data
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      uuid: map['uuid'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      role: map['role'] ?? '',
    );
  }

  // Method to convert UserModel to Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uuid': uuid,
      'createdAt': FieldValue.serverTimestamp(), // For saving to Firestore
      'role': role,
    };
  }
}
