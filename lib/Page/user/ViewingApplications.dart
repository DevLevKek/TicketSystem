import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Page/firebase_auth/databaseUser.dart';
import 'package:flutter_application_1/Page/user/CreateApplicationPage.dart';
import 'package:google_fonts/google_fonts.dart';

class Viewingapplications extends StatefulWidget {
  const Viewingapplications({super.key});

  @override
  State<Viewingapplications> createState() => _ViewingapplicationsState();
}

class _ViewingapplicationsState extends State<Viewingapplications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 23, 24),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 32, right: 32, top: 70, bottom: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //ЗАГОЛОВОК
            Text(
              'Ваши заявки',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 40,
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w500,
              ),
            ),

            //List DataBase
            Flexible(
              child: FirebaseAnimatedList(
                //Запрос
                query: FirebaseDatabase.instance
                    .ref()
                    .child('request')
                    .orderByChild('name')
                    .equalTo(UserDataMain['name']),
                //padding: const EdgeInsets.all(24.0),
                reverse: false,
                itemBuilder: (_, DataSnapshot snapshot,
                    Animation<double> animatable, int x) {
                  return ListTile(
                    //TITLE
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //Описание
                        Text(
                          snapshot.child('description').value.toString(),
                          style: GoogleFonts.roboto(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),

                        //
                        const SizedBox(
                          height: 8,
                        ),

                        //Состояние заявки
                        Container(
                          child: Center(
                            child: Text(
                              snapshot.child('Condition').value.toString(),
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: snapshot
                                          .child('Condition')
                                          .value
                                          .toString() ==
                                      'Ожидает ответа'
                                  ? const Color.fromARGB(255, 0, 119, 182)
                                  : snapshot
                                              .child('Condition')
                                              .value
                                              .toString() ==
                                          'В работе'
                                      ? const Color.fromARGB(255, 251, 133, 0)
                                      : const Color.fromARGB(255, 106, 153, 78),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                    //SUBTITLE
                  );
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateApplication()));
                print(UserDataMain['name']);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: const Color.fromARGB(255, 0, 132, 255),
              ),
              child: Text(
                'Создать заявку',
                style: GoogleFonts.roboto(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
            ),
            const SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}

// void _CheckApplication() async {
//   var refDB = FirebaseDatabase.instance
//                     .ref()
//                     .child('request')
//                     .orderByChild('name')
//                     .equalTo(UserDataMain['name']);
//   if (refDB.)
// }
