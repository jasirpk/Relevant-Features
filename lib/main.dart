import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/controller/adjust.dart';
import 'package:flutter_demo/controller/notification_service.dart';
import 'package:flutter_demo/model/hive_model.dart';
import 'package:flutter_demo/view/pages/auth.dart';
import 'package:flutter_demo/view/webview/webview_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase first

  await Hive.initFlutter();
  Hive.registerAdapter(NotificaitonModelAdapter());

  await FirebaseNotification().initNotification();
  AdjustService.initializeAdjust();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };

  runApp(SampleProject());
}

class SampleProject extends StatelessWidget {
  const SampleProject({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: TextTheme(
            titleMedium: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          )),
      debugShowCheckedModeBanner: false,
      // home: AuthScreen(),
      home: WebviewScreen(),
    );
  }
}
