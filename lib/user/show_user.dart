import 'package:firebase_app/user/create_user.dart';
import 'package:firebase_app/user/single_user.dart';
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

            // return ListView(
            //   children: users.map(buildUser).toList(),
            // );
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SingleUser(id: users[index].id),
                    ),
                  );
                },
                leading: CircleAvatar(
                  child: Text('${users[index].age}'),
                ),
                title: Text(users[index].name),
                subtitle: Text(users[index].birthday.toIso8601String()),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateUserPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildUser(User user) => ListTile(
        onTap: () {},
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
