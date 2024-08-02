import 'package:fire_base_app/headers.dart';
import 'package:logger/logger.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isObscure = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginWithEmailAndPassword() async {
    isLoading(true);

    try {
      User? user = await AuthServices.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      if (user != null) {
        await FirestoreServices.instance.addUser(user: user);
        await FirestoreServices.instance.getUser();
        Get.offAllNamed(Routes.dashboard);
      }
    } catch (e) {
      isLoading(false);
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
    try {
      await AuthServices.instance.signOut();
      isLoading(false);
    } catch (e) {
      isLoading(false);
    }
    Get.offAllNamed(Routes.login);
  }

  Future<void> facebookSignIn() async {
    Logger().i("facebookSignIn called !!!");
    isLoading(true);
    User? user = await AuthServices.instance.signInWithFacebook();
    isLoading(false);
    if (user != null) Get.offAllNamed(Routes.dashboard);
  }

  void toggleObscure() {
    isObscure(!isObscure.value);
  }

  String? validateEmail(String? value) {
    return value!.isEmpty
        ? "Email can't be empty"
        : !RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')
                .hasMatch(value)
            ? "Email is not valid"
            : null;
  }

  String? validatePassword(value) {
    return value != null && value.isNotEmpty
        ? value.length <= 8
            ? "Password must be at least 8 characters"
            : value.contains("@")
                ? null
                : "Password must contain '@' symbol"
        : "Password can't be empty";
  }
}
