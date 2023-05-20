import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_project/constants.dart';
import 'package:firebase_project/screens/items/headBox.dart';
import 'package:firebase_project/screens/transactions/items/trasact_summary.dart';
import 'package:firebase_project/screens/transactions/items/trasact_sumComming.dart';

class Acceuil extends StatelessWidget {
  const Acceuil({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 230, 230, 230),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadMain(mainTitle: "Acceuil"),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text("Mes raccourcis",
                style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaccourciBox(
                  text: "Faire\nun virement",
                  icon: const Icon(
                    Icons.abc,
                    color: Colors.white,
                  ),
                ),
                RaccourciBox(
                  text: "Valider\ndes virements",
                  icon: const Icon(
                    Icons.abc,
                    color: Colors.white,
                  ),
                ),
                RaccourciBox(
                  text: "Créer\ndes tiers",
                  icon: const Icon(
                    Icons.abc,
                    color: Colors.white,
                  ),
                ),
                RaccourciBox(
                  text: "Opérations\ninhabituels",
                  icon: const Icon(
                    Icons.abc,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
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
