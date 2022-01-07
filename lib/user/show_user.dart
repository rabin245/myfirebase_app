import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

class ShowUserPage extends StatelessWidget {
  const ShowUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      // with stream builder the data can be changed in real time
      body: StreamBuilder<List<User>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something\'s wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final users = snapshot.data!;

            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(
          child: Text('${user.age}'),
        ),
        title: Text(user.name),
        subtitle: Text(user.birthday.toIso8601String()),
      );

  Stream<List<User>> readUsers() {
    //snapshots
    var documents = FirebaseFirestore.instance.collection('users').snapshots();

    return documents.map((snapshot) =>
        snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
  }
}
