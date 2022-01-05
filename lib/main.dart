import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Posting test'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a username',
                    labelText: 'User',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  final name = controller.text;
                  createUser(name: name);
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future createUser({required name}) async {
    ///  Reference to document
    final docUser = FirebaseFirestore.instance.collection('users').doc('my_id');
    final json = {
      'name': name,
      'age': 21,
      'birthday': DateTime(2001, 2, 23),
    };

    /// Create document and write data to Firebase
    await docUser.set(json);
  }
}
