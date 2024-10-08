
import 'package:bidcart/repository/navigation/navigation.dart';
import 'package:bidcart/screens/common/onboarding.dart';
import 'package:bidcart/themes/theme.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notification.dart';

void main() async {
  // This will make sure firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  NotificationService().initNotification();
  //Get.put(CustomerAuthenticationRepository());
  //Get.put(SellerAuthenticationRepository());
  Get.put(Navigation());
  //Get.put(CustomerHomeRepository());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: BidcartTheme.lightTheme,
      darkTheme: BidcartTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const OnBoarding(),
    );
  }
}
