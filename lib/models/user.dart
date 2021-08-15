class UserData {
  final String uid;

  UserData({required this.uid});
}

class DocData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  DocData(
      {required this.uid,
      required this.name,
      required this.sugars,
      required this.strength});
}
