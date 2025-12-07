class MyUser {
  String uid;
  String name;
  String email;
  String? phone;

  MyUser({
    required this.uid,
    required this.name,
    required this.email,
    this.phone,
  });

  MyUser.initialData() : uid = '', name = '', email = '', phone = null;

  /// Constructs a [MyUser] from a database row/map.
  MyUser.fromDatabase(Map<String, dynamic> data)
    : uid = data['id'],
      name = data['name'],
      email = data['email'],
      phone = data['phone'];
}
