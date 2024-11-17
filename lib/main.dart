import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Page/login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const main_page());
  //runApp(const Home_page());
}

// ignore: camel_case_types
class main_page extends StatelessWidget {
  const main_page({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginUser(),
    );
  }
}
