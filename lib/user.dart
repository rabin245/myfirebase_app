class User {
  User({
    this.id = '',
    required this.name,
    required this.age,
    required this.birthday,
  });

  String id;
  final String name;
  final int age;
  final DateTime birthday;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'birthday': birthday,
      };
}
