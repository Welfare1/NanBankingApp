class User {
  String id;
  String name;
  String prenom;
  String dateNaissance;
  User(
      {required this.id,
      required this.name,
      required this.prenom,
      required this.dateNaissance});

  static User fromJson(Map<String, dynamic> map) {
    return User(
        id: map["id"] ?? "",
        name: map["Name"] ?? "",
        prenom: map["Prenom"] ?? "",
        dateNaissance: map["Birthday"] ?? "");
  }
}
