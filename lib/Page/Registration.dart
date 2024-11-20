import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Page/firebase_auth/databaseUser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_auth/firebase_auth_service.dart';
import 'moduls/home_user.dart';

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
        backgroundColor: Color.fromARGB(255, 20, 23, 24),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //ЗАГОЛОВОК
                Text(
                  'Регистрация',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 40,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                //
                const SizedBox(
                  height: 24,
                ),

                //LOGIN
                _buildTextField(
                  controller: _usernameController,
                  hintText: 'Введите имя',
                  icon: Icons.person,
                ),
                //
                const SizedBox(
                  height: 12,
                ),

                //EMAIL
                _buildTextField(
                  controller: _emailrnameController,
                  hintText: 'Введите почту',
                  icon: Icons.mail_outline,
                ),
                //
                const SizedBox(
                  height: 12,
                ),

                //PASSWORD
                _buildTextField(
                    controller: _passwordController,
                    hintText: 'Введите пароль',
                    icon: Icons.lock_outline,
                    obscureText: true),

                //
                const SizedBox(
                  height: 32,
                ),

                //LOGIN
                ElevatedButton(
                  onPressed: () {
                    _signUp();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Color.fromARGB(255, 0, 132, 255),
                  ),
                  child: Text(
                    'Зарегистрироваться',
                    style: GoogleFonts.roboto(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                ),

                //
                const SizedBox(
                  height: 12,
                ),

                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Есть аккаунт?',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      child: Text(
                        'Войти',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 132, 255),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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

      UserDataMain['email'] = _emailrnameController.text;
      UserDataMain['Name'] = _usernameController.text;
      UserDataMain['privilege'] = 'user';

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

Widget _buildTextField({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  bool obscureText = false,
}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color.fromARGB(255, 35, 38, 39), // Тёмно-серый фон поля
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color.fromARGB(255, 108, 114, 117),
        fontSize: 20,
        fontWeight: FontWeight.w200,
      ),
      prefixIcon: Icon(icon, color: Color.fromARGB(255, 108, 114, 117)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
