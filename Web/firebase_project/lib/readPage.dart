import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'User.dart';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: readUsers().first,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something is wron ${snapshot.error}");
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(
              children: users.map(builderUser).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection("Users")
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => User.fromJson(doc.data())).toList());

  Widget builderUser(User user) => ListTile(
        leading: Container(
          color: Colors.lightBlue,
          child: Text(user.prenom),
        ),
        title: Text(user.name),
        subtitle: Text(user.dateNaissance),
      );
}
