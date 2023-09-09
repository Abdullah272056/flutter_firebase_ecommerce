import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_ecommerce/sign_up_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   // statusBarColor:awsStartColor,
  //   // systemNavigationBarColor:awsEndColor,
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkFirebaseConnection();
    return  GetMaterialApp(
      // color: Colors.lime,
        debugShowCheckedModeBanner: false,

        // home: DashBoardPageScreen()
        home: SignUpScreen()

    );

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("AppLifecycleState changed: $state");
    if (state == AppLifecycleState.resumed) {
      //_showToast("resumed");
    }
  }

}











Future<void> checkFirebaseConnection() async {
  try {
    await Firebase.initializeApp();
    if (kDebugMode) {
      print("Firebase is connected!");
    }
    // You can proceed with Firebase operations here.
  } catch (e) {
    if (kDebugMode) {
      print("Failed to connect to Firebase: $e");
    }
  }
}



