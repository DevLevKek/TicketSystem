import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'firebase_auth/firebase_auth_service.dart';
import 'user/home_user.dart';

class Regist extends StatefulWidget {
  const Regist({super.key});

  @override
  State<Regist> createState() => _RegistState();
}

class _RegistState extends State<Regist> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailrnameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //Удаляем данные
  @override
  void dispose() {
    _usernameController.dispose();
    _emailrnameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            alignment: Alignment.center,
            color: Colors.black26,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //ЗАГОЛОВОК
                const Text(
                  'Регистрация',
                  style: TextStyle(fontSize: 30),
                ),

                //
                const SizedBox(
                  height: 32,
                ),

                //EMAIL
                TextField(
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  controller: _emailrnameController,
                ),

                //
                const SizedBox(
                  height: 32,
                ),

                //LOGIN
                TextField(
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  controller: _usernameController,
                ),
                //
                const SizedBox(
                  height: 24,
                ),

                //PASSWORD
                TextField(
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  obscureText: true,
                  controller: _passwordController,
                ),

                //
                const SizedBox(
                  height: 32,
                ),

                //LOGIN
                ElevatedButton(
                  onPressed: () {
                    _signUp();
                  },
                  child: const Text('Зарегать :)'),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: const Text('Уже есть акк ?'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailrnameController.text;
    String password = _passwordController.text;

    Map<String, String> user_data = {
      'email': email,
      'privilege': 'user',
    };

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is successfully created");

      final ref = FirebaseDatabase.instance.ref('user');

      ref.child(username).set(user_data);

      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => Home_page(),
        ),
      );
    }
  }
}
