import 'package:fire_base_app/headers.dart';

class SignUpController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isObscure = true.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void toggleObscure() {
    isObscure(!isObscure.value);
  }

  void signUpWithEmailAndPassword() async {
    isLoading(true);
    await AuthServices.instance.signUpWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    Get.offAllNamed(Routes.login);

    isLoading(false);
  }
}
