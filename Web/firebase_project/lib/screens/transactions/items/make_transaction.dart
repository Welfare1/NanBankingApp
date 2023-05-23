import 'package:firebase_project/screens/transactions/transaction_Prototype.dart';
import 'package:flutter/material.dart';

import 'package:firebase_project/constants.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:firebase_project/screens/transactions/items/dropButtonBnk.dart';

import 'package:firebase_project/screens/Customer/items/radioHF.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  State<TransactionForm> createState() => _TransactionForm();
}

class _TransactionForm extends State<TransactionForm> {
  // List of controller's itmes for text formField
  final _formKey = GlobalKey<FormState>();
  final contrNumCliDeb = TextEditingController();
  final contrNumCliCred = TextEditingController();
  final contrNomClientCred = TextEditingController();
  final contrBanque = TextEditingController();
  final contrMontant = TextEditingController();
  final contrTypeOper = TextEditingController();

  //For the dateFormField value
  DateTime selectDate = DateTime.now();
  DateTime selectDateEFF = DateTime.now();
  String nextId = "";

  //for the DropButton of the transactions
  static List<String> list = <String>["Versement", "Virement"];
  Map<String, dynamic> listIcon = {
    "Versement": const Icon(Icons.trending_down),
    "Virement": const Icon(Icons.trending_up)
  };
  bool active = false;
  String dropdownValueTrans = list.first;
  //---end--- dropButton items

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset("images/bat.jpeg"),
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset("images/bni.png"),
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset("images/boa.jpg"),
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset("images/bpop.jpeg"),
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset("images/eco.jpg"),
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset("images/nsia.jpeg"),
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset("images/versus.png"),
                          ),
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text("Informations relatives")),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: SizedBox(
                                  width: 250,
                                  // padding:
                                  //     const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: dropButtonTrans()),
                            ),
                            Flexible(
                              child: SizedBox(
                                width: 250,
                                // padding:
                                //     const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  controller: contrMontant,
                                  // The validator receives the text that the user has entered.
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  decoration: const InputDecoration(
                                      label: Text("Montant de la transaction"),
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
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: const Text("Informations des requerants")),
                      if (!active)
                        //Here this a condition to hide the not necessary part |Virement|Versement|
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: SizedBox(
                                  width: 250,
                                  // padding:
                                  //     const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: TextFormField(
                                    // The validator receives the text that the user has entered.
                                    controller: contrNumCliCred,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    decoration: const InputDecoration(
                                        label: Text(
                                          "N°Compte du bénéficiaire",
                                        ),
                                        hintText: "NAWARXXXX",
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
                                child: SizedBox(
                                  width: 250,
                                  child: DateTimeFormField(
                                    dateFormat: DateFormat.yMd('en_US'),
                                    mode: DateTimeFieldPickerMode.date,
                                    decoration: const InputDecoration(
                                      hintStyle:
                                          TextStyle(color: Colors.black45),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.event_note),
                                      labelText: 'Date effective',
                                    ),
                                    firstDate: DateTime.now(),
                                    // .add(const Duration(days: 10)),
                                    initialDate: DateTime.now(),
                                    autovalidateMode: AutovalidateMode.always,
                                    validator: (DateTime? e) =>
                                        (e?.day ?? 0) == -1
                                            ? 'Veuillez choisir une date'
                                            : null,
                                    onDateSelected: (value) {
                                      print(value.runtimeType);
                                      selectDateEFF = value;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (active)
                        // This part is about |Virement Form|
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    child: SizedBox(
                                      width: 250,
                                      // padding:
                                      //     const EdgeInsets.symmetric(horizontal: 15.0),
                                      child: TextFormField(
                                        controller: contrNumCliDeb,
                                        // The validator receives the text that the user has entered.
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        decoration: const InputDecoration(
                                            label:
                                                Text("N°Compte de l'émeteur"),
                                            hintText: "NAWARIxx",
                                            contentPadding:
                                                EdgeInsets.symmetric(
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
                                      child: SizedBox(
                                    width: 250,
                                  )),
                                ],
                              ),
                            ),
                            const Text("Infomation du bénéficiare"),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    child: SizedBox(
                                      width: 250,
                                      child: TextFormField(
                                        // The validator receives the text that the user has entered.
                                        controller: contrNumCliCred,
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        decoration: const InputDecoration(
                                            label: Text(
                                              "N°Compte du bénéficiaire",
                                            ),
                                            hintText: "NAWARXXXX",
                                            contentPadding:
                                                EdgeInsets.symmetric(
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
                                    child: SizedBox(
                                        width: 250,
                                        // padding:
                                        //    I call the dropButton for the choice of the different kind of bank |NAWARI|BNI|ECOBANK|...
                                        child: DropdownButtonTypBnk()),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    child: SizedBox(
                                      width: 250,
                                      // padding:
                                      //     const EdgeInsets.symmetric(horizontal: 15.0),
                                      child: TextFormField(
                                        controller: contrNomClientCred,
                                        // The validator receives the text that the user has entered.

                                        decoration: const InputDecoration(
                                            label: Text("Nom et prénoms"),
                                            hintText: "KOUXXX JEAXX FELXXX",
                                            contentPadding:
                                                EdgeInsets.symmetric(
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
                                    child: SizedBox(
                                      width: 250,
                                      // padding:
                                      //     const EdgeInsets.symmetric(horizontal: 15.0),
                                      child: DateTimeFormField(
                                        dateFormat: DateFormat.yMd('en_US'),
                                        mode: DateTimeFieldPickerMode.date,
                                        decoration: const InputDecoration(
                                          hintStyle:
                                              TextStyle(color: Colors.black45),
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent),
                                          border: OutlineInputBorder(),
                                          suffixIcon: Icon(Icons.event_note),
                                          labelText: 'Date effective',
                                        ),
                                        firstDate: DateTime.now(),
                                        // .add(const Duration(days: 10)),
                                        initialDate: DateTime.now(),
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        validator: (DateTime? e) =>
                                            (e?.day ?? 0) == 1
                                                ? 'Veuillez choisir une date'
                                                : null,
                                        onDateSelected: (value) {
                                          print(value.runtimeType);
                                          selectDateEFF = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // this is the firebase instance calling | To have the differents response for the following cases..
                              getValueTrans(
                                      idTrans: "Customers",
                                      keyDocSender:
                                          (contrNumCliDeb.text.isNotEmpty)
                                              ? contrNumCliDeb.text
                                              : "NAWARI_00",
                                      keyDocReceiv: (drpValueBank == "NAWARI")
                                          ? contrNumCliCred.text
                                          : "NAWARI_00")
                                  .then((value) {
                                if (value[0] != -1 && value[1] != -1) {
                                  //Instructions transfert solde débiteur
                                  if (double.parse(contrMontant.text) >
                                      ((value[0]["solde"]) ?? 0)) {
                                    //Snackbar pour le solde insuffisant
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(mySnackBar(
                                          "Solde insuffisant!",
                                          "Veuillez vérifier le solde du client: ${contrNumCliDeb.text}",
                                          ContentType.failure));
                                  } else {
                                    //Instructions pour le transfert possible
                                    var receivName = (drpValueBank == "NAWARI")
                                        ? "${value[1]["nom"] ?? ""} ${value[1]["prenoms"] ?? ""}"
                                        : contrNomClientCred.text;
                                    myAlertDialog(
                                            "Vous allez effectué un ${dropdownValueTrans.toLowerCase()} de ${contrMontant.text} XOF \nde ${value[0]["nom"]} ${value[0]["prenoms"] ?? ""},\nvers le client $receivName de la banque $drpValueBank \nVoulez-vous confirmer ?",
                                            context)
                                        .then((vx) {
                                      if (vx == "CONFIRMER") {
                                        if (selectDateEFF
                                            .isBefore(DateTime.now())) {
                                          final TransactionPrototype trans =
                                              TransactionPrototype(
                                                  ref: "",
                                                  numCliCred: contrNumCliCred
                                                      .text,
                                                  nomClientCred:
                                                      (contrNomClientCred
                                                              .text.isEmpty)
                                                          ? contrNumCliCred.text
                                                          : contrNomClientCred
                                                              .text,
                                                  numCliDeb: (contrNumCliDeb
                                                          .text.isEmpty)
                                                      ? "NAWARI_00"
                                                      : contrNumCliDeb.text,
                                                  banque: drpValueBank,
                                                  dateTransac: DateTime.now(),
                                                  dateEffect: selectDateEFF,
                                                  gestionnaire: "GEST001",
                                                  montant: double.parse(
                                                      contrMontant.text),
                                                  typeOperat:
                                                      dropdownValueTrans,
                                                  guichet: "Guichet-00");

                                          creatTrans(
                                                  transactionPrototype: trans)
                                              .then((nextIdd) {
                                            transfert(
                                                value: value,
                                                idTransac: nextIdd);
                                            contrNumCliCred.clear();
                                            contrNomClientCred.clear();
                                            contrNumCliDeb.clear();
                                            contrBanque.clear();
                                            contrMontant.clear();
                                            // final docTransac = FirebaseFirestore.instance
                                            //     .collection("Transactions")
                                            //     .doc(nextId);
                                            ScaffoldMessenger.of(context)
                                              ..hideCurrentSnackBar()
                                              ..showSnackBar(mySnackBar(
                                                  "Succès",
                                                  "Transaction a été effectué avec succès",
                                                  ContentType.success));
                                          });
                                        } else {
                                          //Transfert ajournée
                                          final TransactionPrototype trans =
                                              TransactionPrototype(
                                                  ref: "",
                                                  numCliCred: contrNumCliCred
                                                      .text,
                                                  nomClientCred:
                                                      (contrNomClientCred
                                                              .text.isEmpty)
                                                          ? contrNumCliCred.text
                                                          : contrNomClientCred
                                                              .text,
                                                  numCliDeb: (contrNumCliDeb
                                                          .text.isEmpty)
                                                      ? "NAWARI_00"
                                                      : contrNumCliDeb.text,
                                                  banque: drpValueBank,
                                                  dateTransac: DateTime.now(),
                                                  dateEffect: selectDateEFF,
                                                  gestionnaire: "GEST001",
                                                  montant: double.parse(
                                                      contrMontant.text),
                                                  typeOperat:
                                                      dropdownValueTrans,
                                                  guichet: "Guichet-00",
                                                  approved: false);

                                          creatTrans(
                                                  transactionPrototype: trans)
                                              .then((nextIdd) {
                                            creatTransComing(
                                                transactionPrototype: trans);
                                            contrNumCliCred.clear();
                                            contrNomClientCred.clear();
                                            contrNumCliDeb.clear();
                                            contrBanque.clear();
                                            contrMontant.clear();
                                            // final docTransac = FirebaseFirestore.instance
                                            //     .collection("Transactions")
                                            //     .doc(nextId);
                                            ScaffoldMessenger.of(context)
                                              ..hideCurrentSnackBar()
                                              ..showSnackBar(mySnackBar(
                                                  "Transaction ajournée !",
                                                  "La tractions à été programé avec succès pous le ${DateFormat.yMd('en_US').format(selectDateEFF)} ",
                                                  ContentType.help));
                                          });
                                        }
                                      }
                                    });

                                    //Instruction pour le numéro de compte
                                  }
                                }
                                //Cas d'erreur des comptes.
                                else if (value[0] == -1 || value[1] == -1) {
                                  if (value[0] == -1) {
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(mySnackBar(
                                          "N°Client débité incorrecte!",
                                          "le numero client débité: ${contrNumCliDeb.text} n'est pas un numéro client valide ",
                                          ContentType.warning));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(mySnackBar(
                                          "N°Compte Crédité incorrect!",
                                          "Vérifier que le numéro client à credité: ${contrNumCliCred.text} est bien un client NAWARI ",
                                          ContentType.warning));
                                  }
                                }
                              });
                            }

                            // Validate returns true if the form is valid, or false otherwise.
                          },
                          child: const Text('Lancer la transaction'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Flexible(
              flex: 2,
              child: Container(
                color: Colors.blueAccent,
              ))
        ],
      ),
    );
  }

  //The following question allow us to creat an transaction
  Future creatTrans(
      {required TransactionPrototype transactionPrototype}) async {
    final docTransacLengthReff =
        FirebaseFirestore.instance.collection("Transactions");

    QuerySnapshot snapshotss = await docTransacLengthReff.get();
    int docTransacLength = snapshotss.size;
    docTransacLength += 1;

    int documentCount = await countDocumentsInCollection('Transactions');
    documentCount++;
    setState(() {
      nextId = "TR5646357${(docTransacLength).toString().padLeft(3, '0')}";
    });
    print("Id créer:$documentCount");
    final docTransac = FirebaseFirestore.instance
        .collection("Transactions")
        .doc(nextId); //"NAW001"+"v"
    final json = {
      "ref": docTransac.id, // later
      "numCliDeb": transactionPrototype.numCliDeb,
      "numCliCred": transactionPrototype.numCliCred,
      "nomCliCred": transactionPrototype.nomClientCred,
      "banque": transactionPrototype.banque,
      "dateTransac": transactionPrototype.dateTransac,
      "dateEffect": transactionPrototype.dateEffect,
      "gestionnaire": transactionPrototype.gestionnaire,
      "montant": transactionPrototype.montant,
      "typeOperat": transactionPrototype.typeOperat,
      "guichet": transactionPrototype.guichet,
      "approved": transactionPrototype.approved,
      "fraud": transactionPrototype.fraud,
    };
    await docTransac.set(json);
    print(nextId);
    return nextId;
  }

  Future<int> countDocumentsInCollection(String collectionName) async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collectionName).get();

    return snapshot.docs.length;
  }

  //The following question allow us to creat an coming transaction
  Future creatTransComing(
      {required TransactionPrototype transactionPrototype}) async {
    //The difference between these two collections is the approuved mention.
    final docTransacLengthReff =
        FirebaseFirestore.instance.collection("Transactions_coming");
    QuerySnapshot snapshotss = await docTransacLengthReff.get();
    int docTransacLength = snapshotss.size;
    docTransacLength += 1;
    setState(() {
      nextId = "TC5646357${(docTransacLength).toString().padLeft(3, '0')}";
    });

    final docTransac = FirebaseFirestore.instance
        .collection("Transactions_coming")
        .doc(nextId); //"NAW001"+"v"
    final json = {
      "ref": docTransac.id, // later
      "numCliDeb": transactionPrototype.numCliDeb,
      "numCliCred": transactionPrototype.numCliCred,
      "nomCliCred": transactionPrototype.nomClientCred,
      "banque": transactionPrototype.banque,
      "dateTransac": transactionPrototype.dateTransac,
      "dateEffect": transactionPrototype.dateEffect,
      "gestionnaire": transactionPrototype.gestionnaire,
      "montant": transactionPrototype.montant,
      "typeOperat": transactionPrototype.typeOperat,
      "guichet": transactionPrototype.guichet,
      "approved": transactionPrototype.approved,
      "fraud": transactionPrototype.fraud,
    };
    await docTransac.set(json);
    return nextId;
  }

//This is the Enum for the gender
  String getSexe(Genre genre) => (genre == Genre.homme) ? "HOMME" : "FEMME";
  selectedOp() {
    setState(() {
      // active = (drpValueTrans == "Virement") ? true : false;
      active = !active;
    });
  }

  //This function call the dataBase and return a respnses with for two cases : error case or succes case
  Future<List<dynamic>> getValueTrans(
      {required String idTrans,
      required String keyDocSender,
      required String keyDocReceiv}) async {
    dynamic dataReceiv;
    dynamic dataSender;
    try {
      //Sender's instance
      final docTransacSend =
          FirebaseFirestore.instance.collection(idTrans).doc(keyDocSender);
      var collectionSender = await docTransacSend.get();
      //Receiver's instance
      final docTransacReceiv =
          FirebaseFirestore.instance.collection(idTrans).doc(keyDocReceiv);
      var collectionReceiv = await docTransacReceiv.get();

      if (collectionSender.exists) {
        dataSender = collectionSender.data()!;
        // var balanceSender = dataSender[wishValue] ?? 0;
      } else {
        dataSender = -1;
      }
      if (collectionReceiv.exists) {
        dataReceiv = collectionReceiv.data()!;
      } else {
        dataReceiv = -1;
      }
      return [dataSender, dataReceiv];
    } catch (e) {
      //Response when any call is empty
      return [-2];
    }
  }

  SnackBar mySnackBar(String title, String message, ContentType contentType) {
    return SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: contentType,
      ),
    );
  }

  //DropButton for the kinds of transaction |Virement|Versement
  Widget dropButtonTrans() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<String>(
        value: dropdownValueTrans,
        underline: null,
        style: const TextStyle(color: Colors.blue),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValueTrans = value!;
            active = value == "Virement";
            drpValueBank = listBank.first;
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 190),
              child: ListTile(
                title: Text(value),
                leading: listIcon[value],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Alerte dialogue for confirming the transaction
  Future myAlertDialog(String content, BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('CONFIRMATION'),
        content: Text(
          content,
          maxLines: 4,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop("ANNULER"),
            child: const Text('ANNULER'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop("CONFIRMER"),
            child: const Text('CONFIRMER'),
          ),
        ],
      ),
    );
  }

  //For transaction impact
  transfert({required var value, required String idTransac}) async {
    final docTransacSend = FirebaseFirestore.instance
        .collection("Customers")
        .doc((contrNumCliDeb.text.isNotEmpty)
            ? contrNumCliDeb.text
            : "NAWARI_00");
    final docTransacReceiv = FirebaseFirestore.instance
        .collection("Customers")
        .doc((drpValueBank == "NAWARI") ? contrNumCliCred.text : "NAWARI_00");

    var transacSender = value[0]["transactions"] ?? [""];
    transacSender.add(idTransac);
    var transacReceiv = value[1]["transactions"] ?? [""];
    transacReceiv.add(idTransac);

    docTransacSend.update({
      "solde": value[0]["solde"] - double.parse(contrMontant.text),
      "transactions": transacSender
    });
    docTransacReceiv.update({
      "solde": value[1]["solde"] + double.parse(contrMontant.text),
      "transactions": transacReceiv
    });
  }
}
