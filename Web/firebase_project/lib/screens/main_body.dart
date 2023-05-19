import 'package:firebase_project/screens/analytique.dart';
import 'package:firebase_project/screens/Customer/clients.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'acceuil.dart';
import 'package:firebase_project/constants.dart';
import 'package:firebase_project/screens/transactions.dart';

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  var currentPage = Page.acceuil;

  @override
  Widget build(BuildContext context) {
    Widget SecondBox;
    if (currentPage == Page.acceuil) {
      SecondBox = const Acceuil();
    } else if (currentPage == Page.messagerie) {
      SecondBox = Container(
        color: Colors.orange,
      );
    } else if (currentPage == Page.transactions) {
      SecondBox = SecondBox = const Transactions();
    } else if (currentPage == Page.clients) {
      SecondBox = const Clients();
    } else if (currentPage == Page.analytique) {
      SecondBox = const Analytique();
    } else {
      SecondBox = Container(color: Colors.blue);
    }
    return Scaffold(
      body: Row(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.black,
                  child: menuBar())),
          Flexible(flex: 5, child: SecondBox)
        ],
      ),
    );
  }

  Widget menuBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nawari/Gestionnaire",
          style: GoogleFonts.poppins(fontSize: 16.0, color: Colors.white),
        ),
        const SizedBox(height: 60),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Menu principal",
              style:
                  GoogleFonts.poppins(fontSize: 10.0, color: Colors.lightBlue),
            ),
            const SizedBox(height: 3),
            itemBar(1, "Acceuil", Icons.home,
                currentPage == (Page.acceuil) ? true : false),
            itemBar(2, "Messagerie", Icons.mail_outline,
                currentPage == (Page.messagerie) ? true : false),
            const SizedBox(height: 3),
            Text(
              "Espace de travail",
              style:
                  GoogleFonts.poppins(fontSize: 10.0, color: Colors.lightBlue),
            ),
            itemBar(3, "Transactions", Icons.account_balance_outlined,
                currentPage == (Page.transactions) ? true : false),
            // const SizedBox(height: 3),
            itemBar(4, "Opérations", Icons.swap_horiz_outlined,
                currentPage == (Page.operations) ? true : false),
            // const SizedBox(height: 3),
            itemBar(5, "Clients", Icons.people_outline,
                currentPage == (Page.clients) ? true : false),
            // const SizedBox(height: 3),
            itemBar(6, "Analytique", Icons.trending_up_outlined,
                currentPage == (Page.analytique) ? true : false),
            const SizedBox(height: 60),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.grey.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  const Icon(
                    Icons.exit_to_app_sharp,
                    color: Colors.white,
                  ),
                  TextButton(
                    child: const Text("Se deconnecter"),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        )
        // const SizedBox(height: 3),
      ],
    );
  }

  Widget itemBar(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey : Colors.transparent,
      child: InkWell(
        onTap: () {
          //Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = Page.acceuil;
            } else if (id == 2) {
              currentPage = Page.messagerie;
            } else if (id == 3) {
              currentPage = Page.transactions;
            } else if (id == 4) {
              currentPage = Page.operations;
            } else if (id == 5) {
              currentPage = Page.clients;
            } else if (id == 6) {
              currentPage = Page.analytique;
            }
          });
        },
        child: Container(
          margin: const EdgeInsets.only(top: 3),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Expanded(
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        icon,
                        color: Colors.black,
                      ))),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style:
                      GoogleFonts.poppins(fontSize: 16.0, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum Page { acceuil, messagerie, transactions, operations, clients, analytique }
