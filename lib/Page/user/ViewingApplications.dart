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
  _showPopupMenu() async {
    await showMenu(
      context: context,
      position: RelativeRect.fill,
      items: [
        PopupMenuItem(
          child: Text("Menu 2"),
        ),
        PopupMenuItem(
          child: Text("Menu 3"),
          value: 'lev',
        ),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 23, 24),
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
                color: Color.fromARGB(255, 255, 255, 255),
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
                    onTap: UserDataMain['privilege'] == 'admin'
                        ? _showPopupMenu
                        : null,
                    //TITLE
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //Описание
                        Text(
                          snapshot.child('description').value.toString(),
                          style: GoogleFonts.roboto(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),

                        //
                        SizedBox(
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
                                color: Color.fromARGB(255, 255, 255, 255),
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
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                    //SUBTITLE
                  );
                },
              ),
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateApplication()));
                print(UserDataMain['name']);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Color.fromARGB(255, 0, 132, 255),
              ),
              child: Text(
                'Создать заявку',
                style: GoogleFonts.roboto(
                    color: Color.fromARGB(255, 255, 255, 255),
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
