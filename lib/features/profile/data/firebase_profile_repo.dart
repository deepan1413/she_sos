import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:she_sos/features/profile/domain/entities/profile_user.dart';
import 'package:she_sos/features/profile/domain/repo/profile_repo.dart';
import 'package:she_sos/myLogs/mylogs.dart';

class FirebaseProfileRepo implements ProfileRepo {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      final userDoc = await firebaseFirestore
          .collection('users')
          .doc(uid)
          .get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null) {
          return ProfileUser(
            uid: uid,
            email: userData['email'],
            name: userData['name'],
            phoneNumber: userData['phoneNumber'],
            profilePicture: userData['profilepicture'].toString(),
            address: userData['address'],
            emergencyContacts: userData['emergencyContacts'],
          );
        }
      }
      return null;
    } catch (e) {
      MyLog.error(e.toString());
      MyLog.highlight('Error on FirebaseProfileRepo: fetchUserProfile');
      return null;
    }
  }

  @override
  Future<void> updateUserProfile(ProfileUser updatedProfile) async{
    try {
      await firebaseFirestore.collection('users').doc(updatedProfile.uid).update({
        'profilePicture':updatedProfile.profilePicture
      });

    } catch (e) {
      MyLog.error(e.toString());
      MyLog.highlight('Error on FirebaseProfileRepo: updateUserProfile');

    }
  }
}
