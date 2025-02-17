import 'package:define_digital_tasks/utils/app_contants.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'routes/router_generator.dart';
import 'routes/screen_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const DefineDigitalApp());
}

class DefineDigitalApp extends StatefulWidget {
  const DefineDigitalApp({super.key});

  @override
  State<DefineDigitalApp> createState() => _DefineDigitalAppState();
}

final scaffoldkey = GlobalKey<ScaffoldMessengerState>();

class _DefineDigitalAppState extends State<DefineDigitalApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return MaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          scaffoldMessengerKey: scaffoldkey,
          onGenerateRoute: generateRoute,
          initialRoute: ScreenRoutes.splashScreen,
        );
      },
    );
  }
}
