import 'package:fire_base_app/headers.dart';
import 'package:fire_base_app/modal/note_modal.dart';
import 'package:fire_base_app/modal/user_modal.dart';

class FirestoreServices {
  static final instance = FirestoreServices._();
  FirestoreServices._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userCollection = "user collection";
  String noteCollection = "note collection";
  UserModel? currentUser;

  Future<void> getUser() async {
    try {
      DocumentSnapshot snapshot = await firestore
          .collection(userCollection)
          .doc(AuthServices.instance.auth.currentUser!.email)
          .get();

      currentUser = UserModel.fromMap(snapshot.data() as Map);
    } catch (e) {
      Get.snackbar('User Get Error', e.toString());
    }
  }

  Future<void> addUser({required User user}) async {
    Map<String, dynamic> data = {
      'uid': user.uid,
      'displayName': user.displayName ?? "DEMO USER",
      'email': user.email ?? "demo_mail",
      'phoneNumber': user.phoneNumber ?? "NO DATA",
      'photoURL': user.photoURL ??
          "https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg",
    };
    try {
      await firestore.collection(userCollection).doc(user.email).set(data);
    } catch (e) {
      Get.snackbar('User Add Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  void addNote({required NoteModal note}) {
    try {
      firestore
          .collection(userCollection)
          .doc(AuthServices.instance.auth.currentUser!.email)
          .collection(noteCollection)
          .add(note.toMap);
    } catch (e) {
      Get.snackbar('Note Add Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getNotes() {
    return firestore
        .collection(userCollection)
        .doc(AuthServices.instance.auth.currentUser!.email)
        .collection(noteCollection)
        .snapshots();
  }
}
