import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_application_1/Page/firebase_auth/databaseUser.dart';
import 'package:flutter_application_1/Page/user/ViewingApplications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Home_admin_page extends StatefulWidget {
  const Home_admin_page({super.key});

  @override
  State<Home_admin_page> createState() => _Home_admin_pageState();
}

class _Home_admin_pageState extends State<Home_admin_page> {
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
                Flexible(
                  child: FirebaseAnimatedList(
                    query: FirebaseDatabase.instance.ref('request'),
                    padding: const EdgeInsets.all(24.0),
                    reverse: false,
                    itemBuilder: (_, DataSnapshot snapshot,
                        Animation<double> animatable, int x) {
                      return ListTile(
                        subtitle: Text(snapshot.child('name').value.toString()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _data_Admin(users) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('request');
  DatabaseEvent event = await ref.once();
  Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
  data.forEach((key, value) {
    users = key;
    return users;
  });
}
