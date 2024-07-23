import 'package:fire_base_app/headers.dart';
import 'package:fire_base_app/routes.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: primaryColor,
      ),
      initialRoute: Routes.login,
      getPages: Routes.routes,
    );
  }
}
