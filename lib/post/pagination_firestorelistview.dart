import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/post/post.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();

    //upload random posts to firebase only at start
    // uploadRandom();
  }

  void uploadRandom() async {
    final postCollection =
        FirebaseFirestore.instance.collection('posts').withConverter<Post>(
              fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
              toFirestore: (post, _) => post.toJson(),
            );
    final numbers = List.generate(500, (index) => index + 1);

    for (final number in numbers) {
      final post = Post(
        title: 'Random Title $number',
        likes: Random().nextInt(1000),
        createdAt: DateTime.now(),
        imageUrl: 'https://source.unsplash.com/random?sig=$number',
      );

      postCollection.add(post);
    }
  }

  final queryPost = FirebaseFirestore.instance
      .collection('posts')
      .orderBy('createdAt')
      .withConverter(
        fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
        toFirestore: (post, _) => post.toJson(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Pagination'),
      ),
      body: FirestoreListView<Post>(
        query: queryPost,
        pageSize: 20, //10
        itemBuilder: (context, snapshot) {
          final post = snapshot.data();

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.imageUrl),
            ),
            title: Text(post.title),
            subtitle: Text('${post.likes} Likes'),
          );
        },
      ),
    );
  }
}
