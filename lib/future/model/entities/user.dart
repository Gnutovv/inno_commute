class User {
  String id;
  bool active;
  String phoneNumber;
  String alias;
  String name;
  String password;

  User(
      {required this.active,
      required this.alias,
      required this.id,
      required this.name,
      required this.password,
      required this.phoneNumber});
}
