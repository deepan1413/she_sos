class AppUser {
  final String uid;
  final String email;
  final String name;
  final String phoneNumber;
  final String address;
  final List<Map<String, String>> emergencyContacts;
  final String? profilePicture;
  final bool isVolunteer;
  final Map<String, double>? currentLocation;
  final bool isSafe;

  AppUser({
    required this.uid,
    required this.email,
    this.name = '',
    this.phoneNumber = '',
    this.address = '',
    this.emergencyContacts = const [],
    this.profilePicture,
    this.isVolunteer = false,
    this.currentLocation,
    this.isSafe = true,
  });

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

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
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
