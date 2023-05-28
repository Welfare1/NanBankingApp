import 'package:firebase_project/screens/transactions/transaction_Prototype.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_project/screens/items/solde_section.dart';
import 'package:firebase_project/screens/transactions.dart';
import 'package:firebase_project/screens/transactions/items/trasact_summary.dart';

class ConsultationBox extends StatefulWidget {
  @override
  _ConsultationBoxState createState() => _ConsultationBoxState();
}

class _ConsultationBoxState extends State<ConsultationBox> {
  TextEditingController _searchController = TextEditingController();
  String customerNum = "";
  String customerNames = "";
  String customerBirth = "";
  String customerSexe = "";
  double customerSolde = 0;
  String customerProf = "";
  int customerNbTrans = 0;
  bool customerStatut = true;
  bool showSear = false;
  bool showSpinner = false;
  var nbFormat = NumberFormat("#,###");
  List<TransactionPrototype> trasanctionsList =
      TransactionPrototype.getTrasancData();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                scale: 0.1,
                opacity: 0.3,
                image: AssetImage("images/nawari1.png"),
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 500,
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText:
                              'Entrer le numéro du compte recherché (NAW001 XX)...',
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              //
                              startLoading();
                              getCustomer(
                                idClient: _searchController.text,
                              ).then((value) {
                                if (value != -1) {
                                  setState(() {
                                    customerNum = value["id"];
                                    customerNames =
                                        "${value["nom"]} ${value["prenoms"]}";
                                    customerBirth = "10/10/1990";
                                    customerSexe = value["sexe"] ?? "";
                                    customerProf = value["profession"] ?? "";
                                    customerStatut = value["freeze"] ?? false;
                                    customerSolde = value["solde"] ?? 0.0;
                                    customerNbTrans = value["nbTransac"] ?? 0;
                                    showSear = true;

                                    List<dynamic> transactionsId =
                                        value["transactions"];
                                    print(transactionsId);

                                    if (transactionsId.isNotEmpty) {
                                      getTransactionDetails(transactionsId)
                                          .then((List<DocumentSnapshot>
                                              transactionDetails) {
                                        print(
                                            "taille liste : ${transactionDetails.length}");
                                        setState(() {
                                          trasanctionsList = transactionDetails
                                              .map((snapshot) =>
                                                  TransactionPrototype.fromJson(
                                                      snapshot.data() as Map<
                                                          String, dynamic>))
                                              .toList()
                                              .reversed
                                              .toList();
                                        });
                                      }).catchError((error) {
                                        // Gérez les erreurs éventuelles
                                        print(
                                            'Erreur lors de la récupération des détails des transactions : $error');
                                      });
                                      stopLoading();
                                    } else {
                                      trasanctionsList =
                                          TransactionPrototype.getTrasancData();
                                    }
                                  });
                                } else {
                                  stopLoading();
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(mySnackBar(
                                        "N°Client incorrecte!",
                                        " Oops!!! Numéro cherché non rétrouvé",
                                        ContentType.warning));
                                }
                              });
                              //
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onChanged: (value) {
                          // Faites quelque chose avec la valeur de recherche
                          // Par exemple, vous pouvez filtrer une liste d'employés en fonction de cette valeur
                          print('Recherche en cours : $value');
                        },
                      ),
                    ),
                  ),
                  if (showSear)
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'NUMERO DE CARTE : ',
                                  style: GoogleFonts.lato(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: customerNum,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'NOM ET PRENOM : ',
                                  style: GoogleFonts.lato(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: customerNames,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'DATE DE NAISSANCE : ',
                                  style: GoogleFonts.lato(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: customerBirth,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'SEXE : ',
                                  style: GoogleFonts.lato(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: customerSexe,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'PROFESSION : ',
                                  style: GoogleFonts.lato(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: customerProf,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'SOLDE : ',
                                  style: GoogleFonts.lato(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: nbFormat
                                                .format(customerSolde)
                                                .toString() +
                                            ' XOF',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'NOMBRE DE TRANSACTIONS : ',
                                  style: GoogleFonts.lato(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: customerNbTrans.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'STATUT DU COMPTE : ',
                                  style: GoogleFonts.lato(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            customerStatut ? "GELER" : "ACTIF",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              customerStatut
                                  ? ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.green),
                                      ),
                                      onPressed: () {
                                        myAlertDialog(
                                                "Vous êtes sur le point de DEBLOQUER le compte $customerNames \nLe confimer-vous ?",
                                                context)
                                            .then((vx) {
                                          if (vx == "CONFIRMER") {
                                            updateFreeze(
                                                idClient: customerNum,
                                                freeze: false);
                                            setState(() {
                                              customerStatut = false;
                                            });
                                          }
                                        });
                                      },
                                      child: const Text("Débloquer"))
                                  : ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red),
                                      ),
                                      onPressed: () {
                                        myAlertDialog(
                                                "Vous êtes sur le point de GELER le compte de $customerNames \nl'empêchant d'éffectuer toutes transactions \nLe confimer-vous ?",
                                                context)
                                            .then((vx) {
                                          if (vx == "CONFIRMER") {
                                            updateFreeze(
                                                idClient: customerNum,
                                                freeze: true);
                                            setState(() {
                                              customerStatut = true;
                                            });
                                          }
                                        });
                                      },
                                      child: const Text("Bloquer")),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 180),
                              height: 260,
                              child: dataTableTransaction(trasanctionsList))
                        ],
                      ),
                    ),
                  if (showSpinner)
                    Center(
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/nawari1.png"))),
                        child: const SpinKitWave(
                          color: Colors.orange,
                          size: 30,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> getCustomer({required String idClient}) async {
    dynamic dataSender;
    try {
      //Sender's instance
      final docTransacSend =
          FirebaseFirestore.instance.collection("Customers").doc(idClient);
      var collectionSender = await docTransacSend.get();

      if (collectionSender.exists) {
        dataSender = collectionSender.data()!;
        // var balanceSender = dataSender[wishValue] ?? 0;
      } else {
        dataSender = -1;
      }
      return dataSender;
    } catch (e) {
      //Response when any call is empty
      return [-2];
    }
  }

  updateFreeze({required String idClient, required bool freeze}) async {
    final docTransacSend =
        FirebaseFirestore.instance.collection("Customers").doc(idClient);

    docTransacSend.update({"freeze": freeze});
  }

  Future<List<DocumentSnapshot>> getTransactionDetails(
      List<dynamic> transactionIds) async {
    List<String> transactionIdsConv =
        transactionIds.map((e) => e.toString()).toList().take(10).toList();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Transactions')
        .where(FieldPath.documentId, whereIn: transactionIdsConv)
        .get();

    return snapshot.docs;
  }

  List<String> transactionIds = [
    'TR5646357001',
    'TR5646357002',
  ];

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

  Future myAlertDialog(String content, BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('CONFIRMATION'),
        content: Text(
          content,
          maxLines: 5,
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

  Widget dataTableTransaction(List<TransactionPrototype> trasanctionsList) {
    final _TransacSumDataSource = TransacSumDataSource(trasanctionsList);
    return ListTransactionSum(transacSumDataSource: _TransacSumDataSource);
  }

  void startLoading() {
    setState(() {
      showSpinner = true;
    });
  }

  void stopLoading() {
    setState(() {
      showSpinner = false;
    });
  }
}
