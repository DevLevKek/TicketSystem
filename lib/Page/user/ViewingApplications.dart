import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Page/firebase_auth/databaseUser.dart';

class Viewingapplications extends StatefulWidget {
  const Viewingapplications({super.key});

  @override
  State<Viewingapplications> createState() => _ViewingapplicationsState();
}

class _ViewingapplicationsState extends State<Viewingapplications> {
  // Query dbRef =
  //     FirebaseDatabase.instance.ref().child('request/${UserDataMain['Name']}');
  DatabaseReference ref =
      FirebaseDatabase.instance.ref('request/${UserDataMain['Name']}');
  void _data() async {
    DatabaseEvent event = await ref.once();
    Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
    data.forEach(
      (key, value) {
        Map<dynamic, dynamic> dataValue = data as Map<dynamic, dynamic>;
        dataValue.forEach(
          (key, value) {
            
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new FirebaseAnimatedList(
              query: FirebaseDatabase.instance
                  .ref()
                  .child('request/${UserDataMain['Name']}'),
              padding: new EdgeInsets.all(8.0),
              reverse: false,
              itemBuilder: (_, DataSnapshot snapshot,
                  Animation<double> animatable, int x) {
                return new ListTile(
                  title: Text(UserDataMain['Name']!),
                  subtitle: new Text(snapshot.value.toString()),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Вернутся'),
          ),
          const SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }
}