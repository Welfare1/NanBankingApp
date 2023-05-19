import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
        ),
        actions: [
          IconButton(
              onPressed: () {
                final name = controller.text;
                creatUser(name: name);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      backgroundColor: Colors.amber,
      body: Column(
        children: const [Text("Les formes"), Text("Les yeux")],
      ),
    );
  }

  Future creatUser({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection("Users").doc();
    final json = {
      "Name": name,
      "Prenom": "Albert",
      "Birthday": DateTime(2000, 10, 11)
    };
    await docUser.set(json);
  }
}
