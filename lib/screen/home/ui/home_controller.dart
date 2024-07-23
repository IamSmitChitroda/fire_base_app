import 'package:fire_base_app/headers.dart';
import 'package:fire_base_app/modal/note_modal.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<NoteModal> notes = <NoteModal>[].obs;

  getNotes() async {
    isLoading(true);
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> data =
          FirestoreServices.instance.getNotes();
    } catch (e) {
      Get.snackbar('Controller Note Get Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    isLoading(false);
  }
}
