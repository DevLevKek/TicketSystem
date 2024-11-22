import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Page/firebase_auth/databaseUser.dart';
import 'package:google_fonts/google_fonts.dart';
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
  var items = ['Низкий', 'Средний', 'Высокий', 'Критический'];
  //final
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 20, 23, 24),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 32, right: 32, top: 70, bottom: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              const SizedBox(
                height: 24,
              ),
              TextField(
                style: GoogleFonts.roboto(
                    color: const Color.fromARGB(255, 255, 255, 255), fontSize: 20),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 35, 38, 39),
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 108, 114, 117),
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                    ),
                    hintText: 'Опишите проблему'),
                maxLines: 5,
                // obscureText: true,
                controller: _descriptionController,
              ),

              const SizedBox(
                height: 24,
              ),

              //Уровень срочности
              Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 35, 38, 39),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),
                    isExpanded: true,
                    dropdownColor: const Color.fromARGB(255, 35, 38, 39),
                    borderRadius: BorderRadius.circular(10),
                    // Array list of items
                    items: items.map(
                      (String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: GoogleFonts.roboto(
                              color: items == 'Низкий'
                                  ? const Color.fromARGB(255, 118, 200, 147)
                                  : items == 'Средний'
                                      ? const Color.fromARGB(255, 167, 201, 87)
                                      : items == 'Высокий'
                                          ? const Color.fromARGB(255, 244, 162, 97)
                                          : const Color.fromARGB(255, 231, 111, 81),
                            ),
                          ),
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
                ),
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
      ),
    );
  }
}

void _sendRequest(description, urgency) async {
  // String Name = UserDataMain['Name']!;
  Map<String, dynamic> application = {
    'email': UserDataMain['email'],
    'name': UserDataMain['name'],
    'description': description,
    'urgency': urgency,
    'Condition': 'Ожидает ответа'
  };
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('request');

  dbRef.push().set(application);
}
