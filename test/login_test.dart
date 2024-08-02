import 'package:fire_base_app/headers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Login Test',
    () {
      LoginController loginController = Get.put(LoginController());

      test(
        "Login password test",
        () {
          expect(loginController.validatePassword("test"),
              "Password must be at least 8 characters");
        },
      );

      test(
        "Login password test",
        () {
          expect(loginController.validatePassword("password.123"),
              "Password must contain '@' symbol");
        },
      );
      test(
        "Login password test",
        () {
          expect(loginController.validatePassword("password@123"), null);
        },
      );

      test(
        "Login email test",
        () {
          expect(loginController.validateEmail(""), "Email can't be empty");
        },
      );
      test(
        "Login email test",
        () {
          expect(loginController.validateEmail("smitchitroda2210.gmail.com"),
              "Email is not valid");
        },
      );

      test(
        "Login email test",
        () {
          expect(loginController.validateEmail("smitchitroda2210@gmail.com"),
              null);
        },
      );
      test(
        "Login email test",
        () {
          expect(loginController.validateEmail(""), "Email can't be empty");
        },
      );
    },
  );
}
