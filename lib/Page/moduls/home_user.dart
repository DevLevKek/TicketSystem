import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Page/user/ViewingApplications.dart';
import '../user/CreateApplicationPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Home_page extends StatelessWidget {
  const Home_page({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Viewingapplications(),
                      ),
                    );
                  },
                  child: const Text('Посмотреть состояние заявок'),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateApplication(),
                      ),
                    );
                  },
                  child: const Text('Создать заявку'),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                  },
                  child: const Text('Выйти из аккаунта'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
