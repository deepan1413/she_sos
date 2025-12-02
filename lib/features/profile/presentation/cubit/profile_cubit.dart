import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:she_sos/features/profile/domain/repo/profile_repo.dart';
import 'package:she_sos/features/profile/presentation/cubit/profile_states.dart';
import 'package:she_sos/myLogs/mylogs.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(ProfileLoading());
      MyLog.highlight("working on profilecubit fetchUserProfile");
      final user = await profileRepo.fetchUserProfile(uid);
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError("user not found"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));

      MyLog.error(e.toString());
      MyLog.highlight('Error on ProfileCubit: fetchUserProfile');
    }
  }

  Future<void> updateProfile({required String uid, String? some}) async {
    try {
      final currentuser = await profileRepo.fetchUserProfile(uid);
      if (currentuser == null) {
        emit(ProfileError('Failed to fetch user data for update'));
      return;
      }
      final updatedProfile=currentuser.copyWith(
        address: some??currentuser.address
      );
      await profileRepo.updateUserProfile(updatedProfile);
      await profileRepo.fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError(e.toString()));

      MyLog.error(e.toString());
      MyLog.highlight('Error on ProfileCubit: updateProfile');
    }
  }
}
