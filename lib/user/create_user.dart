import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'user.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: ageController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Age',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: dateController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Birthday',
            ),
            onTap: () {
              pickDate();
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final user = User(
                name: nameController.text,
                age: int.parse(ageController.text),
                birthday: DateTime.parse(dateController.text),
              );

              createUser(user);

              Navigator.pop(context);
            },
            child: const Text(
              'Create',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Future pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime(2200),
      initialDate: DateTime(1999),
    );

    setState(() {
      dateController.text =
          '${date!.year.toString()}-${zeroSuffix(date.month)}-${zeroSuffix(date.day)}';
      // print(dateController.text);
      // print(date.toString());
    });
  }

  String zeroSuffix(int value) {
    if (value >= 10) {
      return value.toString();
    }
    return '0${value.toString()}';
  }

  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    user.id = docUser.id;

    final json = user.toJson();
    await docUser.set(json);
  }
}
