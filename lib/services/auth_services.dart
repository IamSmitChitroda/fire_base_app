import 'package:fire_base_app/headers.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:logger/logger.dart';

class AuthServices {
  AuthServices._();
  static final instance = AuthServices._();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;
  Future<User?> signInWithEmailAndPassword({
    required email,
    required password,
  }) async {
    try {
      currentUser = null;
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.snackbar("Success", "User logged in successfully",
          colorText: Colors.white, backgroundColor: primaryColor);

      currentUser = credential.user;
      return credential.user;
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
      return null;
    }
  }

  signUpWithEmailAndPassword({required email, required password}) async {
    try {
      currentUser = null;
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.snackbar("Success", "User created successfully",
          colorText: Colors.white, backgroundColor: primaryColor);

      return credential.user;
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
      return null;
    }
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      Get.snackbar("Success", "User created successfully",
          colorText: Colors.white, backgroundColor: primaryColor);

      // Once signed in, return the UserCredential
      return await auth.signInWithCredential(credential);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
      return null;
    }
  }

  signOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
  }

  signInWithFacebook() async {
    Logger().i("facebookSignIn called !!!");
    try {
      FacebookAuth facebookAuth = FacebookAuth.instance;
      LoginResult loginResult = await facebookAuth.login();
      if (loginResult.accessToken != null) {
        Logger().i('Login Result: ${loginResult.accessToken!.tokenString}');
        OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(
                loginResult.accessToken!.tokenString);

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);

        return userCredential.user;
      } else {
        Logger().e(' Facebook login failed: ${loginResult.message}');
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
