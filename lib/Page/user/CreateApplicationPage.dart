import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Page/firebase_auth/databaseUser.dart';
import '';

class CreateApplication extends StatefulWidget {
  const CreateApplication({super.key});

  @override
  State<CreateApplication> createState() => CreateApplicationState();
}

class CreateApplicationState extends State<CreateApplication> {
  TextEditingController _descriptionController = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('request');
  }

  //Удаляем данные
  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  String dropdownvalue = 'Низкий';
  var items = ['Низкий', 'Средний', 'Высокий', 'Критический', 'Экстренный'];
  //final
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            TextField(
              // decoration: const InputDecoration(
              //   border: OutlineInputBorder(),
              // ),
              maxLines: 10,
              // obscureText: true,
              controller: _descriptionController,
            ),

            const SizedBox(
              height: 24,
            ),

            //Уровень срочности
            DropdownButton(
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map(
                (String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                },
              ).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(
                  () {
                    dropdownvalue = newValue!;
                  },
                );
              },
            ),

            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {
                //print(_descriptionController.text);
                _sendRequest(_descriptionController.text, dropdownvalue);
                Navigator.pop(context);
              },
              child: const Text('Создать заявку'),
            )
          ],
        ),
      ),
    );
  }
}

void _sendRequest(description, urgency) async {
  String Name = UserDataMain['Name']!;
  Map<String, dynamic> application = {
    'name': UserDataMain['email'],
    'description': description,
    'urgency': urgency,
    'Condition': 'Ожидает ответа'
  };
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('request');

  dbRef.child(Name).push().set(application);
}
