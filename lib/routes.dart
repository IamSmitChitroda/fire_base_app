import 'headers.dart';

class Routes {
  static const String splash = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';

  static List<GetPage> routes = [
    // GetPage(name: splash, page: () => const Splash()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const SignUpScreen()),
    GetPage(name: dashboard, page: () => const HomeScreen()),
  ];
}
