import 'package:firebase_project/screens/transactions/transaction_Prototype.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_project/constants.dart';
import 'package:firebase_project/screens/items/headBox.dart';
import 'package:firebase_project/screens/transactions/items/trasact_summary.dart';
import 'package:firebase_project/screens/transactions/items/trasact_sumComming.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class Acceuil extends StatefulWidget {
  Acceuil({super.key});

  @override
  State<Acceuil> createState() => _AcceuilState();
}

bool onHoverMontant = false;
bool showSpinner = true;

class _AcceuilState extends State<Acceuil> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 230, 230, 230),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeadMain(mainTitle: "Acceuil"),
          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                side: MaterialStateProperty.all<BorderSide>(
                  const BorderSide(color: Colors.green),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(mySnackBar(
                      "0 Transaction échéante!",
                      "Aucune transaction échéante n'a été rétrouvée",
                      ContentType.warning));
              },
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 235),
                child: const Row(
                  children: [
                    Text(
                      "Passer les transactions ajournées",
                    ),
                    Icon(Icons.autorenew)
                  ],
                ),
              )),
          Container(margin: const EdgeInsets.only(top: 20), child: boxValue()),
          Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      children: [
                        const Text("Historique des transactions"),
                        Container(
                          color: Colors.white,
                          height: 400,
                          // padding: const EdgeInsets.symmetric(
                          //     horizontal: 2, vertical: 2),
                          child: ReadPageTranSum(),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      children: [
                        const Text("Transactions  à venir"),
                        Container(
                          color: Colors.white,
                          height: 400,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 2),
                          child: ReadPageTranSumComing(),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  var now = DateTime.now();

  var fNumb = NumberFormat('#,###');

  Widget boxValue() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: StreamBuilder<List<TransactionPrototype>>(
        stream: snapshotTransactions(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something is wron ${snapshot.error}");
          } else if (snapshot.hasData) {
            final transactions = snapshot.data!;
            var transactionsToday = transactions
                .where((element) => element.dateEffect.isAfter(
                    DateTime(now.year, now.month, now.day)
                        .subtract(const Duration(minutes: 1))))
                .toList();
            var transactionsYestDay = transactions
                .where((element) =>
                    element.dateEffect.isAfter(
                        DateTime(now.year, now.month, now.day)
                            .subtract(const Duration(days: 1, minutes: 1))) &&
                    element.dateEffect
                        .isBefore(DateTime(now.year, now.month, now.day)))
                .toList();
            //Today
            var montant =
                transactionsToday.map((transac) => transac.montant).isEmpty
                    ? [0.0]
                    : transactionsToday.map((transac) => transac.montant);
            double sum = montant.reduce((value, element) => value + element);
            //The day Before
            var montantYestDay =
                transactionsYestDay.map((transac) => transac.montant).isEmpty
                    ? [0.0]
                    : transactionsYestDay.map((transac) => transac.montant);

            double sumYestDay = (montantYestDay
                        .reduce((value, element) => value + element) ==
                    0.0)
                ? 1
                : montantYestDay.reduce((value, element) => value + element);
            double frct = (sum - sumYestDay) * 100 / sumYestDay;

            // transactions number
            int nbTransac = transactionsToday.length;
            int nbTransacDenom =
                (transactionsToday.isEmpty) ? 1 : transactionsToday.length;
            int nbTransacYest =
                (transactionsYestDay.isEmpty) ? 1 : transactionsYestDay.length;
            double frctNbTransac =
                (nbTransac - nbTransacYest) * 100 / nbTransacYest;
            // Trasanctions approuved
            var transacApproved = transactions
                .where((element) => element.dateEffect.isAfter(
                    DateTime(now.year, now.month, now.day)
                        .subtract(const Duration(minutes: 1))))
                .where((element) => element.approved == true)
                .toList();
            int nbTransacApproved = transacApproved.length;

            double frctNbTransacApproved =
                (nbTransacApproved) * 100 / nbTransacDenom;
            // Trasanctions approuved
            var transacFraud = transactions
                .where((element) => element.dateEffect.isAfter(
                    DateTime(now.year, now.month, now.day)
                        .subtract(const Duration(minutes: 1))))
                .where((element) => element.approved == false)
                .toList();
            int nbTransacFraud = transacFraud.length;

            double frctNbTransacFraud = (nbTransacFraud) * 100 / nbTransacDenom;

            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      (frct < 0) ? Colors.red : Colors.green)),
                          child: Column(
                            children: [
                              Text(
                                "Total transactions",
                                style: GoogleFonts.righteous(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '${fNumb.format(sum)}',
                                  style: GoogleFonts.rajdhani(fontSize: 40),
                                  children: const <TextSpan>[
                                    TextSpan(
                                        text: ' XOF',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20))
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "Crois. ${frct.round()}% | hier",
                                      style: GoogleFonts.rajdhani(fontSize: 17),
                                    ),
                                  ),
                                  (frct < 0)
                                      ? const Icon(
                                          Icons.arrow_downward,
                                          color: Colors.red,
                                          size: 17,
                                        )
                                      : const Icon(
                                          Icons.arrow_upward,
                                          color: Colors.green,
                                          size: 17,
                                        )
                                ],
                              )
                            ],
                          ),
                        ),
                        onHover: (value) {
                          setState(() {
                            onHoverMontant = value;
                          });
                          print(onHoverMontant);
                        },
                        onTap: () {},
                      ),
                    ],
                  ),
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: (frctNbTransac < 0)
                                  ? Colors.red
                                  : Colors.green)),
                      child: Column(
                        children: [
                          Text(
                            "Nb transactions",
                            style: GoogleFonts.righteous(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '$nbTransac',
                              style: GoogleFonts.rajdhani(fontSize: 40),
                            ),
                          ),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  "Crois. ${frctNbTransac.round()}% | hier",
                                  style: GoogleFonts.rajdhani(fontSize: 17),
                                ),
                              ),
                              (frctNbTransac < 0)
                                  ? const Icon(
                                      Icons.arrow_downward,
                                      color: Colors.red,
                                      size: 17,
                                    )
                                  : const Icon(
                                      Icons.arrow_upward,
                                      color: Colors.green,
                                      size: 17,
                                    )
                            ],
                          )
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: (frctNbTransacApproved < 1)
                                  ? Colors.red
                                  : Colors.green)),
                      child: Column(
                        children: [
                          Text(
                            "Transact° Approuv.",
                            style: GoogleFonts.righteous(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '$nbTransacApproved',
                              style: GoogleFonts.rajdhani(fontSize: 40),
                            ),
                          ),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  " Taux. | ${frctNbTransacApproved.round()}%",
                                  style: GoogleFonts.rajdhani(fontSize: 17),
                                ),
                              ),
                              (frctNbTransacApproved < 1)
                                  ? const Icon(
                                      Icons.arrow_downward,
                                      color: Colors.red,
                                      size: 17,
                                    )
                                  : const Icon(
                                      Icons.arrow_upward,
                                      color: Colors.green,
                                      size: 17,
                                    )
                            ],
                          )
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: (frctNbTransacFraud > 50)
                                  ? Colors.red
                                  : Colors.green)),
                      child: Column(
                        children: [
                          Text(
                            "transact° Ajournées",
                            style: GoogleFonts.righteous(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '$nbTransacFraud',
                              style: GoogleFonts.rajdhani(fontSize: 40),
                            ),
                          ),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  " Perc. | ${frctNbTransacFraud.round()}%",
                                  style: GoogleFonts.rajdhani(fontSize: 17),
                                ),
                              ),
                              (frctNbTransacFraud > 50)
                                  ? const Icon(
                                      Icons.arrow_downward,
                                      color: Colors.red,
                                      size: 17,
                                    )
                                  : const Icon(
                                      Icons.arrow_upward,
                                      color: Colors.green,
                                      size: 17,
                                    )
                            ],
                          )
                        ],
                      ),
                    ),
                    onTap: () {},
                  )
                ]);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Stream<List<TransactionPrototype>> snapshotLastDay() => FirebaseFirestore
      .instance
      .collectionGroup('Transactions')
      .where('dateEffect',
          isGreaterThanOrEqualTo: DateTime(now.year, now.month, now.day)
              .subtract(const Duration(days: 1)))
      .where('dateEffect',
          isLessThan: DateTime(now.year, now.month, now.day)
              .subtract(const Duration(days: 0)))
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((doc) => TransactionPrototype.fromJson(doc.data()))
          .toList());

  Stream<List<TransactionPrototype>> snapshotTransactions() =>
      FirebaseFirestore.instance.collection('Transactions').snapshots().map(
          (snapshots) => snapshots.docs
              .map((doc) => TransactionPrototype.fromJson(doc.data()))
              .toList());

  dataQueries() async {
    try {
      var snapshot =
          FirebaseFirestore.instance.collection("Transactions").snapshots();

      //Queries For today
      var snapshotToday = await FirebaseFirestore.instance
          .collectionGroup('Transactions')
          .where('dateEffect',
              isGreaterThanOrEqualTo: DateTime(now.year, now.month, now.day)
                  .subtract(const Duration(days: 0)))
          .get();
      //Queries For the lastDay
    } catch (e) {
      print(e);
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

class RaccourciBox extends StatelessWidget {
  String text;
  Icon icon;
  RaccourciBox({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.teal),
        child: Row(
          children: [
            Text(text,
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  color: Colors.white,
                )),
            icon //Icons
          ],
        ),
      ),
    );
  }
}
