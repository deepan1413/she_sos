class AppUser {
  final String uid;
  final String email;
  final String name;
  // final String phoneNumber;
  // final String address;
  // final List<Map<String, String>> emergencyContacts;
  // final String? profilePicture;
  // final bool isVolunteer;
  // final Map<String, double>? currentLocation;
  // final bool isSafe;

  AppUser({
    required this.uid,
    required this.email,
    this.name = '',
   
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'],
      email: json['email'],
      name: json['name'] ?? '',
      
    );
  }
}
