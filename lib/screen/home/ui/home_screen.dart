import 'package:fire_base_app/headers.dart';
import 'package:fire_base_app/modal/note_modal.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*notification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    RemoteMessage? message = await messaging.getInitialMessage();

    if (messaging != null) {
      if (message != null) {
        Logger().i(message.data);
        FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
      } else {
        Logger().e("message is null !!!");
      }
    } else {
      Logger().e('firebase message is null !!!');
    }
  }

  void handleMessage(RemoteMessage message) {
    Logger().d("onMessageOpenApp${message.notification!.body}");
  }*/

  notification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    Logger().i('Notification${settings.authorizationStatus}');
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   Logger().d("onMessage: ${message.data}");
    // });

    /*FirebaseMessaging.onBackgroundMessage(
      (RemoteMessage message) async {
        Logger().d('Handling a background message: ${message.messageId}');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        Logger().i('Message data: ${message.data}');
      },
    );*/

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {
        Logger().d('Handling a background message: ${message.messageId}');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        Logger().i('Message data: ${message.data}');
      },
    );
  }

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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Home Screen'),
                        const Spacer(),
                        IconButton(
                          onPressed: AuthServices.instance.signOut,
                          icon: const Icon(Icons.logout),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(),
                      // child: StreamBuilder(
                      //   stream: FirestoreServices.instance.getNotes(),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasData) {
                      //       List<NoteModal> notes = snapshot.data!.docs
                      //           .map(
                      //             (e) => NoteModal.fromMap(
                      //               e.data(),
                      //             ),
                      //           )
                      //           .toList();
                      //       return ListView.builder(
                      //         itemCount: notes.length,
                      //         itemBuilder: (context, index) => ListTile(
                      //           title: Text(
                      //             notes[index].title.toString(),
                      //           ),
                      //         ),
                      //       );
                      //     } else {
                      //       return const LoadingView();
                      //     }
                      //   },
                      // ),
                    ),
                  ],
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
