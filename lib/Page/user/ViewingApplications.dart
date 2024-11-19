import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Page/firebase_auth/databaseUser.dart';

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
          child: Text("Menu 3") ,value: 'lev',
        ),
      ],
      elevation: 8.0,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            child: FirebaseAnimatedList(
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
                  onTap: _showPopupMenu,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(snapshot.key.toString()),
                      Text(snapshot.child('name').value.toString()),
                    ],
                  ),
                  subtitle:
                      Text(snapshot.child('description').value.toString()),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              print(UserDataMain['name']);
            },
            child: const Text('Вернутся'),
          ),
          const SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }
}
