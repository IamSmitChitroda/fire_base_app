import 'package:fire_base_app/headers.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isObscure = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginWithEmailAndPassword() async {
    isLoading(true);

    User? user = await AuthServices.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);

    if (user != null) {
      await FirestoreServices.instance.addUser(user: user);
      await FirestoreServices.instance.getUser();
      Get.offAllNamed(Routes.dashboard);
    }
  }

  Future<void> googleSignIn() async {
    isLoading(true);
    UserCredential? userCredential =
        await AuthServices.instance.signInWithGoogle();
    if (userCredential?.user != null) {
      await FirestoreServices.instance.addUser(user: userCredential!.user!);
      await FirestoreServices.instance.getUser();
      Get.offAllNamed(Routes.dashboard);
    }
    isLoading(false);
  }

  Future<void> signOut() async {
    isLoading(true);
    await AuthServices.instance.signOut();
    isLoading(false);
    Get.offAllNamed(Routes.login);
  }

  void toggleObscure() {
    isObscure(!isObscure.value);
  }
}
