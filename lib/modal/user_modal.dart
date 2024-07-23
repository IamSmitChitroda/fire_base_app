class UserModel {
  var uid;
  var displayName;
  var email;
  var photoURL;
  var phoneNumber;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoURL,
    required this.phoneNumber,
  }) {
    // load();
  }

  factory UserModel.fromMap(Map data) => UserModel(
        uid: data['uid'],
        displayName: data['displayName'],
        email: data['email'],
        photoURL: data['photoURL'],
        phoneNumber: data['phoneNumber'],
      );

  Map<String, dynamic> get toMap => {
        'uid': uid,
        'displayName': displayName ?? "DEMO USER",
        'email': email ?? "demo_mail",
        'phoneNumber': phoneNumber ?? "NO DATA",
        'photoURL': photoURL ??
            "https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg",
      };
}
