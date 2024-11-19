import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Registration.dart';
import 'firebase_auth/firebase_auth_service.dart';
import 'adminnistration/home_admin.dart';
import 'user/home_user.dart';
import 'firebase_auth/databaseUser.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailrnameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('user');
  }

  //Удаляем данные
  @override
  void dispose() {
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
                  'Вход',
                  style: TextStyle(fontSize: 30),
                ),

                //
                const SizedBox(
                  height: 32,
                ),

                //LOGIN
                TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  controller: _emailrnameController,
                ),

                //
                const SizedBox(
                  height: 24,
                ),

                //PASSWORD
                TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
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
                    _signIn();
                  },
                  child: const Text('Войти'),
                ),

                const SizedBox(
                  height: 12,
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Regist(),
                      ),
                    );
                  },
                  child: const Text('Регистрация'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailrnameController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is successfully signedIn");
      Map<String, String> user = {
        'name': _emailrnameController.text,
        'privilege': 'user'
      };
      final String emailUser = _emailrnameController.text;
      DatabaseReference ref = FirebaseDatabase.instance.ref('user');
      DatabaseEvent event = await ref.once();
      //Извлеакаем из БД нужные данные, а именно nameUser
      //Пример:
      //                name: Lev
      //в forEach - это key и value
      Map<dynamic, dynamic> data =
          event.snapshot.value as Map<dynamic, dynamic>;
      data.forEach(
        (key, value) {
          var nameUser = key;
          // ignore: prefer_const_declarations
          var privilegeBool = false;
          final Map<dynamic, dynamic> dataValue =
              value as Map<dynamic, dynamic>;
          dataValue.forEach(
            (key, value) {
              if (key == 'email' && value == emailUser) {
                UserDataMain['email'] = value;
                UserDataMain['name'] = nameUser;
                privilegeBool = true;
              }
              if (key == 'privilege' && privilegeBool) {
                var privilegeBool = false;
                UserDataMain['privilege'] = value;
              }
            },
          );
        },
      );
      if (UserDataMain['privilege'] == 'admin') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home_admin_page(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home_page(),
          ),
        );
        print(UserDataMain['name']);

        print(UserDataMain);
        // dbRef.child('lev').set(user);
      }
    }
  }
}
