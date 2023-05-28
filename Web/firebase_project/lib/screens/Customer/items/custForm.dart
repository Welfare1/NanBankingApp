import 'package:flutter/material.dart';

import 'package:firebase_project/constants.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:firebase_project/screens/Customer/items/dropButton.dart';

import 'package:firebase_project/screens/Customer/items/radioHF.dart';
import '../customers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/screens/items/solde_section.dart';

class CustForm extends StatefulWidget {
  const CustForm({super.key});

  @override
  State<CustForm> createState() => _CustFormState();
}

class _CustFormState extends State<CustForm> {
  final _formKey = GlobalKey<FormState>();
  final controllerNom = TextEditingController();
  final controllerPrenom = TextEditingController();
  final controllerProfession = TextEditingController();
  final controllerNumID = TextEditingController();
  final controllerPhone = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerMontant = TextEditingController();
  late DateTime selectDate;
  String nextId = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text("Informations relatives")),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
                                // padding:
                                //     const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  // The validator receives the text that the user has entered.
                                  controller: controllerNom,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  decoration: const InputDecoration(
                                      label: Text(
                                        "Nom",
                                      ),
                                      hintText: "Entrer le nom",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      border: OutlineInputBorder()),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Champ obligatoire !';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
                                child: TextFormField(
                                  controller: controllerPrenom,
                                  // The validator receives the text that the user has entered.
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  decoration: const InputDecoration(
                                      label: Text("Prénoms"),
                                      hintText: "Entrer le prénoms",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      border: OutlineInputBorder()),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Champ obligatoire !';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
                                // padding:
                                //     const EdgeInsets.symmetric(horizontal: 15.0),
                                child: DateTimeFormField(
                                  dateFormat: DateFormat.yMd('en_US'),
                                  mode: DateTimeFieldPickerMode.date,
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Colors.black45),
                                    errorStyle:
                                        TextStyle(color: Colors.redAccent),
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.event_note),
                                    labelText: 'Date de naissance',
                                  ),
                                  firstDate: DateTime(1930, 1, 1),
                                  // .add(const Duration(days: 10)),
                                  initialDate: DateTime(2010, 1, 1),
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: (DateTime? e) => (e?.day ?? 0) == 1
                                      ? 'Please not the first day'
                                      : null,
                                  onDateSelected: (value) {
                                    print(value.runtimeType);
                                    selectDate = value;
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
                                // padding:
                                //     const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  controller: controllerProfession,
                                  // The validator receives the text that the user has entered.
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  decoration: const InputDecoration(
                                      label: Text("Profession"),
                                      hintText: "Entrer la Profession",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      border: OutlineInputBorder()),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Champ obligatoire !';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
                                // padding:
                                //     const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  controller: controllerNumID,
                                  // The validator receives the text that the user has entered.
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  decoration: const InputDecoration(
                                      label: Text("N°Pièce d'identité"),
                                      hintText: "CIxxxx",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      border: OutlineInputBorder()),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Champ obligatoire !';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
                                // padding:
                                //     const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  controller: controllerPhone,
                                  // The validator receives the text that the user has entered.

                                  decoration: const InputDecoration(
                                      label: Text("Numéro de téléphone"),
                                      hintText: "+225 00xxxxxxxx",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      border: OutlineInputBorder()),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Champ obligatoire !';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
                                // padding:
                                //     const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  controller: controllerEmail,
                                  // The validator receives the text that the user has entered.
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  decoration: const InputDecoration(
                                      label: Text("Adresse mail"),
                                      hintText: "xx@yy.zz",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      border: OutlineInputBorder()),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Champ obligatoire !';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const Flexible(
                                child: SizedBox(width: 200, child: RadioHF())),
                          ],
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10, left: 10),
                          child: const Text("Ouverture du compte")),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 200),
                                  // padding:
                                  //     const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: const DropdownButtonCpt()),
                            ),
                            Flexible(
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
                                // padding:
                                //     const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  controller: controllerMontant,
                                  // The validator receives the text that the user has entered.
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  decoration: const InputDecoration(
                                      label: Text("Montant à l'ouverture"),
                                      hintText: "xxx (XOF)",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      border: OutlineInputBorder()),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Champ obligatoire !';
                                    } else if (double.tryParse(value) == null) {
                                      return 'entrer des valeurs numeriques!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            print(drpValue);

                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              final Customer customer = Customer(
                                  id: "",
                                  nom: controllerNom.text,
                                  prenoms: controllerPrenom.text,
                                  dateNaissance: selectDate,
                                  profession: controllerProfession.text,
                                  numPce: controllerNumID.text,
                                  numTel: controllerPhone.text,
                                  solde: double.parse(controllerMontant.text),
                                  mail: controllerEmail.text,
                                  sexe: getSexe(genreCus),
                                  typeCpt: drpValue,
                                  gestionnaire: "GEST001",
                                  dateCreat: DateTime.now(),
                                  nbTransac: 0);
                              creatCustomer(customer: customer);
                              controllerNom.clear();
                              controllerPrenom.clear();
                              controllerProfession.clear();
                              controllerNumID.clear();
                              controllerPhone.clear();
                              controllerMontant.clear();
                              controllerEmail.clear();
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text('Compte créer')),
                              );
                            }
                          },
                          child: const Text('créer le compte'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Flexible(flex: 2, child: SoldeSection())
        ],
      ),
    );
  }

  Future creatCustomer({required Customer customer}) async {
    final docUserLengthRef = FirebaseFirestore.instance.collection("Customers");
    QuerySnapshot snapshot = await docUserLengthRef.get();
    int docUserLength = snapshot.size;
    nextId = "NAW001" + (docUserLength++).toString().padLeft(3, '0');
    final docUser = FirebaseFirestore.instance
        .collection("Customers")
        .doc(nextId); //"NAW001"+"v"
    final json = {
      "id": docUser.id, // later
      "nom": customer.nom,
      "prenoms": customer.prenoms,
      "dateCreat": customer.dateCreat,
      "dateNaissance": customer.dateNaissance,
      "gestionnaire": customer.gestionnaire,
      "mail": customer.mail,
      "numPce": customer.numPce,
      "numTel": customer.numTel,
      "profession": customer.profession,
      "sexe": customer.sexe,
      "solde": customer.solde,
      "typeCpt": customer.typeCpt,
      "nbTransac": customer.nbTransac,
      "transactions": []
    };
    print(nextId);
    await docUser.set(json);
  }

  String getSexe(Genre genre) => (genre == Genre.homme) ? "HOMME" : "FEMME";
}
