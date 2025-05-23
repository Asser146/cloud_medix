import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/routing/app_router.dart';
import 'package:cloud_medix/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();

  await dotenv.load(fileName: ".env");
  String initialRoute;

  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
  String? id = await storage.read(key: "id");
  // final prefs = await SharedPreferences.getInstance();
  // await prefs.clear(); // This clears everything

  if (id != null) {
    initialRoute = Routes.home;
  } else {
    initialRoute = Routes.login;
  }

  runApp(MyApp(
    appRouter: AppRouter(),
    initialRoute: initialRoute,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter, required this.initialRoute});
  final AppRouter appRouter;
  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: child,
          onGenerateRoute: appRouter.onGenerateRoute,
          initialRoute: initialRoute,
        );
      },
    );
  }
}
