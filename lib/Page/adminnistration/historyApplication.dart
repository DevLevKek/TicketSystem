import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_application_1/Page/firebase_auth/databaseUser.dart';
import 'package:flutter_application_1/Page/user/ViewingApplications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

class Historyapplication extends StatefulWidget {
  const Historyapplication({super.key});

  @override
  State<Historyapplication> createState() => _Historyapplication();
}

class _Historyapplication extends State<Historyapplication> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 20, 23, 24),
        body: Container(
          alignment: Alignment.center,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 70, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //
                Text(
                  'Завершенные заявки',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 40,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                //Flexible
                Flexible(
                  child: FirebaseAnimatedList(
                    query: FirebaseDatabase.instance.ref('history'),
                    //padding: const EdgeInsets.all(12.0),
                    reverse: false,
                    itemBuilder: (_, DataSnapshot snapshot,
                        Animation<double> animatable, int x) {
                      return ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //TEXT
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.child('name').value.toString(),
                                  style: GoogleFonts.roboto(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      snapshot
                                          .child('urgency')
                                          .value
                                          .toString(),
                                      style: GoogleFonts.roboto(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: snapshot
                                                      .child('urgency')
                                                      .value
                                                      .toString() ==
                                                  'Низкий'
                                              ? const Color.fromARGB(
                                                  255, 118, 200, 147)
                                              : snapshot
                                                          .child('urgency')
                                                          .value
                                                          .toString() ==
                                                      'Средний'
                                                  ? const Color.fromARGB(
                                                      255, 167, 201, 87)
                                                  : snapshot
                                                              .child('urgency')
                                                              .value
                                                              .toString() ==
                                                          'Высокий'
                                                      ? const Color.fromARGB(
                                                          255, 244, 162, 97)
                                                      : const Color.fromARGB(
                                                          255, 231, 111, 81),
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),

                            //
                            // SizedBox(
                            //   height: 8,
                            // ),

                            //Описание
                            Text(
                              snapshot.child('description').value.toString(),
                              style: GoogleFonts.roboto(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200),
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
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
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
                                          ? const Color.fromARGB(
                                              255, 251, 133, 0)
                                          : const Color.fromARGB(
                                              255, 106, 153, 78),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
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
                    'Вернуться',
                    style: GoogleFonts.roboto(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
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
