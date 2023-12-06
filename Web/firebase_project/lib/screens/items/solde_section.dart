import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SoldeSection extends StatelessWidget {
  const SoldeSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 5),
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const SweepGradient(
            center: AlignmentDirectional(1, -1),
            startAngle: 1.7,
            endAngle: 3,
            colors: <Color>[
              // Color(0xFF21899C),
              // Color(0xFF21899C),
              Color.fromARGB(255, 233, 233, 233),
              Color.fromARGB(255, 233, 233, 233),
              Color.fromARGB(255, 209, 209, 209),
              Color.fromARGB(255, 209, 209, 209),
              Color.fromARGB(255, 233, 233, 233),
              Color.fromARGB(255, 233, 233, 233),
              // Colors.white,
              // Colors.white
            ],
            stops: <double>[0.0, 0.3, 0.3, 0.7, 0.7, 1.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "MasterCard",
                  style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.titleMedium),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Image.asset(
                        "images/nawari1.png",
                        width: 20,
                      ),
                    ),
                    Text(
                      "NAWARII",
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.titleMedium),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Image.asset(
                  "images/bandeM.jpg",
                  width: 70,
                  height: 50,
                ),
                Text(
                  "RIB    NAW 001 XXX XXX XXX",
                  style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 127, 110, 1),
                      fontSize: 13),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "propiétaire",
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Welfare",
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Expiries",
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.bodyMedium),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "10\t/\t24",
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("images/MasterCard.png"))),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ));
  }
}
