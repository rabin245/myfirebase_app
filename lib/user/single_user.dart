import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'user.dart';

class SingleUser extends StatelessWidget {
  const SingleUser({
    required this.id,
    Key? key,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single User'),
      ),
      body: FutureBuilder<User?>(
        future: readSingleUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something\'s wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final user = snapshot.data;

            // return buildUser(user!);
            return user == null
                ? const Center(child: Text('No user'))
                : buildUser(user);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<User?> readSingleUser() async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(id);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
  }

  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(
          child: Text('${user.age}'),
        ),
        title: Text(user.name),
        subtitle: Text(user.birthday.toIso8601String()),
      );
}
