import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'User.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final controllerName = TextEditingController();
  final controllerPrenom = TextEditingController();
  final controllerBirthday = TextEditingController();

  DateTime initialDate = DateTime.now();
  DateTime onSelectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User page"),
      ),
      backgroundColor: Colors.amber,
      body: Row(
        children: [
          const Spacer(),
          Flexible(
            child: Column(children: [
              TextField(
                decoration: const InputDecoration(
                    hintText: "Name", label: Text("Name")),
                controller: controllerName,
              ),
              TextField(
                decoration: const InputDecoration(
                    hintText: "Prenoms", label: Text("Prenoms")),
                controller: controllerPrenom,
              ),
              TextField(
                decoration: const InputDecoration(
                    hintText: "01/01/2023", label: Text("Birthday")),
                controller: controllerBirthday,
              ),
              ElevatedButton(
                  onPressed: () {
                    final user = User(
                        id: "",
                        name: controllerName.text,
                        prenom: controllerPrenom.text,
                        dateNaissance: controllerBirthday.text);
                    creatUser(user: user);
                    // Navigator.pop(context);
                    controllerName.clear();
                    controllerPrenom.clear();
                    controllerBirthday.clear();
                  },
                  child: const Text("Enregistrer"))
            ]),
          ),
          const Spacer()
        ],
      ),
    );
  }

  Future creatUser({required User user}) async {
    final docUser = FirebaseFirestore.instance.collection("Users").doc();
    final json = {
      "id": docUser.id,
      "Name": user.name,
      "Prenom": user.prenom,
      "Birthday": user.dateNaissance,
    };
    await docUser.set(json);
  }

  showDate(context) {
    showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime(1900),
            lastDate: DateTime(2090))
        .then((value) => setState(
            () => initialDate = (value != null) ? value : initialDate));
  }
}
