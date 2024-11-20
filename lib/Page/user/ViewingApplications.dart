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
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
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
            SizedBox(
              height: 12,
            ),
            Flexible(
              child: FirebaseAnimatedList(
                //Запрос
                query: FirebaseDatabase.instance
                    .ref()
                    .child('request')
                    .orderByChild('name')
                    .equalTo(UserDataMain['name']),
                padding: const EdgeInsets.all(24.0),
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
                        Text(snapshot.child('description').value.toString()),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          snapshot.child('Condition').value.toString(),
                          style:
                              GoogleFonts.roboto(backgroundColor: Colors.blue),
                        )
                      ],
                    ),
                    //SUBTITLE
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateApplication()));
                print(UserDataMain['name']);
              },
              child: const Text('Вернутся'),
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
