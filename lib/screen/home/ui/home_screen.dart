import 'package:fire_base_app/headers.dart';
import 'package:fire_base_app/modal/note_modal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Obx(
      () => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: AppBar(),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: StreamBuilder(
                  stream: FirestoreServices.instance.getNotes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<NoteModal> notes = snapshot.data!.docs
                              .map(
                                (e) => NoteModal.fromMap(
                                  e.data(),
                                ),
                              )
                              .toList() ??
                          [];
                      return ListView.builder(
                        itemCount: notes.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(
                            notes[index].title.toString(),
                          ),
                        ),
                      );
                    } else {
                      return const LoadingView();
                    }
                  },
                ),
              ),
              if (homeController.isLoading.value) const LoadingView(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            TextEditingController titleController = TextEditingController();
            TextEditingController descriptionController =
                TextEditingController();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Add Note'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      FirestoreServices.instance.addNote(
                        note: NoteModal(
                            title: titleController.text,
                            content: descriptionController.text),
                      );
                      Get.back();
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
