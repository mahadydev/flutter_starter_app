import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter_app/app/app.dart';
import 'package:flutter_starter_app/app/di/injection.dart';
import 'package:flutter_starter_app/core/constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: AppConstants.envFilePath);
  await configureDependencies();

  runApp(
    ScreenUtilInit(
      designSize: const Size(440, 956), // iPhone 16 Pro Max
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MyApp();
      },
    ),
  );
}
