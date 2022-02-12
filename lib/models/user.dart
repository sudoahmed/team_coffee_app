class CustomUser {
  CustomUser({required this.uid});

  final String? uid;
}

class UserData {
  final String? uid;
  final String name, sugars;
  final int strength;

  UserData(
      {required this.uid,
      required this.name,
      required this.sugars,
      required this.strength});
}
