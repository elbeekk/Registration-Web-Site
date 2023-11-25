import "dart:html";

import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:reg_web_page/admin_page.dart";
import "package:reg_web_page/firebase_options.dart";
import "package:reg_web_page/home_page.dart";
import "package:shared_preferences/shared_preferences.dart";


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
