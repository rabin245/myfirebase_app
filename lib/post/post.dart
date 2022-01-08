import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post({
    required this.title,
    required this.likes,
    required this.createdAt,
    required this.imageUrl,
  });
  final String title;
  final int likes;
  final DateTime createdAt;
  final String imageUrl;

  Post.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          likes: json['likes']! as int,
          createdAt: (json['createdAt']! as Timestamp).toDate(),
          imageUrl: json['imageUrl']! as String,
        );
  Map<String, Object?> toJson() => {
        'title': title,
        'likes': likes,
        'createdAt': createdAt,
        'imageUrl': imageUrl,
      };
}
