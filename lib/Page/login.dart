import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Registration.dart';
import 'firebase_auth/firebase_auth_service.dart';
import 'adminnistration/home_admin.dart';
import 'firebase_auth/databaseUser.dart';
import 'user/ViewingApplications.dart';

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
        backgroundColor: const Color.fromARGB(255, 20, 23, 24),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //ЗАГОЛОВОК
                Text(
                  'Вход',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 40,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                //
                const SizedBox(
                  height: 24,
                ),

                //LOGIN
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
                    _signIn();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: const Color.fromARGB(255, 0, 132, 255),
                  ),
                  child: Text(
                    'Войти',
                    style: GoogleFonts.roboto(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Нет аккаунта?',
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Regist(),
                          ),
                        );
                      },
                      child: Text(
                        'Зарегистрируйтесь',
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

  void _signIn() async {
    String email = _emailrnameController.text;
    String password = _passwordController.text;
    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is successfully signedIn");
      final String emailUser = _emailrnameController.text;

      DatabaseReference ref = FirebaseDatabase.instance.ref('user');
      DatabaseEvent event = await ref.once();
      Map<dynamic, dynamic> data =
          event.snapshot.value as Map<dynamic, dynamic>;
      data.forEach(
        (key, value) {
          
          var nameUser = key;
          Map<dynamic, dynamic> data_dd = value as Map<dynamic, dynamic>;
          data_dd.forEach(
            (key, value) {
              print(key);
              if (key == 'email' && value == email) {
                print(key);
                UserDataMain['name'] = nameUser;
              }
            },
          );
        },
      );
      var datebase = event.snapshot.child(UserDataMain['name'].toString());
      UserDataMain['email'] = datebase.child('email').value.toString();
      UserDataMain['privilege'] = datebase.child('privilege').value.toString();
      print(UserDataMain);

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
            builder: (context) => const Viewingapplications(),
          ),
        );
        print(UserDataMain);
      }
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
    style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.w100),
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
