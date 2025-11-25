class AppUser {
  String uid;
  String email;
  AppUser({required this.email, required this.uid});

Map<String,dynamic> toJson(){
return {
  'uid':uid,
  'email':email
};
}

factory AppUser.fromJson(Map<String,dynamic>jsonUser){
  return AppUser(email: jsonUser['email'], uid: jsonUser['uid']);
}

}
