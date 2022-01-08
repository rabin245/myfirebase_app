import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/post/post.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class SecondPage extends StatelessWidget {
  SecondPage({Key? key}) : super(key: key);

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
      body: FirestoreQueryBuilder<Post>(
        query: queryPost,
        pageSize: 2,
        builder: (context, snapshot, _) {
          if (snapshot.isFetching) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final post = snapshot.docs[index].data();

                if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                  // Tell FirestoreQueryBuilder to try to obtain more items.
                  // It is safe to call this function from within the build method.
                  snapshot.fetchMore();
                }
                if (snapshot.isFetching) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Text('Some error');
                }
                return buildPost(post);
              },
            );
          }
        },
      ),
    );
  }

  Widget buildPost(Post post) => Card(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  post.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 12),
              Text(post.title),
            ],
          ),
        ),
      );
}
