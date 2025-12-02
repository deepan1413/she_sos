import 'package:she_sos/features/auth/domain/entitites/app_user.dart';

class ProfileUser extends AppUser {
  final String phoneNumber;
  final String address;
  final List<Map<String, String>> emergencyContacts;
  final String profilePicture;
  final bool isVolunteer;
  final Map<String, double>? currentLocation;
  final bool isSafe;

  ProfileUser({
    required super.uid,
    required super.email,
    required super.name,
    required this.phoneNumber,
    required this.address,
    required this.emergencyContacts,
    required this.profilePicture,
    this.isVolunteer = false,
    this.currentLocation,
    this.isSafe = true,
  });

  ProfileUser copyWith({
    String? phoneNumber,
    String? address,
    List<Map<String, String>>? emergencyContacts,
    String? profilePicture,
    bool? isVolunteer,
    Map<String, double>? currentLocation,
    bool? isSafe,
    String? email,
    String? name,
    String? uid,
  }) {
    return ProfileUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
      profilePicture: profilePicture ?? this.profilePicture,
      isVolunteer: isVolunteer ?? this.isVolunteer,
      currentLocation: currentLocation ?? this.currentLocation,
      isSafe: isSafe ?? this.isSafe,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'emergencyContacts': emergencyContacts,
      'profilePicture': profilePicture,
      'isVolunteer': isVolunteer,
      'currentLocation': currentLocation,
      'isSafe': isSafe,
    };
  }

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      uid: json['uid'],
      email: json['email'],
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      emergencyContacts: List<Map<String, String>>.from(
        json['emergencyContacts'] ?? [],
      ),
      profilePicture: json['profilePicture'],
      isVolunteer: json['isVolunteer'] ?? false,
      currentLocation: json['currentLocation'] != null
          ? Map<String, double>.from(json['currentLocation'])
          : null,
      isSafe: json['isSafe'] ?? true,
    );
  }
}
