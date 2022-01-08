import 'package:firebase_app/post/pagination_firestorelistview.dart';
import 'package:firebase_app/post/pagination_firestorequerybuilder.dart';
import 'package:flutter/material.dart';

class PostOption extends StatelessWidget {
  const PostOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Options'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                );
              },
              child: const Text('FirestoreListView'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              child: const Text('FirestoreQueryBuilder'),
            ),
          ],
        ),
      ),
    );
  }
}
