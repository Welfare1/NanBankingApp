import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PricingTableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/nawari1.png",
              height: 40,
              width: 40,
            ),
            Text("Grille tarifaire du 01/05 au 05/06",
                style: GoogleFonts.lato(
                    decoration: TextDecoration.underline, fontSize: 14))
          ],
        ),
        Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 249, 249, 249),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(
              12.0), // Ajoute un padding autour du container
          child: Table(
            border: TableBorder.all(), // Ajoute une bordure autour de la table
            defaultColumnWidth:
                const IntrinsicColumnWidth(), // Ajuste automatiquement la largeur des colonnes
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Center(
                        child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Text('Intervalle',
                          style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.titleLarge)),
                    )),
                  ),
                  TableCell(
                    child: Center(
                        child: Text('Frais actuels',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.titleLarge))),
                  ),
                  TableCell(
                    child: Center(
                        child: Text('Frais normaux',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.titleLarge))),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Center(
                        child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Text('1 - 10 000 XOF',
                          style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.bodyLarge)),
                    )),
                  ),
                  TableCell(
                    child: Center(
                        child: Text('Exonéré',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge))),
                  ),
                  TableCell(
                    child: Center(
                        child: Text('Exonéré',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge))),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Center(
                        child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Text('10 001 - 100 000 XOF',
                          style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.bodyLarge)),
                    )),
                  ),
                  TableCell(
                    child: Center(
                        child: Text('500 XOF',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge))),
                  ),
                  TableCell(
                    child: Center(
                        child: Text('500 XOF',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge))),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Center(
                        child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Text('100 0001 - 500 000 XOF',
                          style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.bodyLarge)),
                    )),
                  ),
                  TableCell(
                    child: Center(
                        child: Text('1000 XOF',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge))),
                  ),
                  TableCell(
                    child: Center(
                        child: Text('1000 XOF',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge))),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Center(
                        child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Text('500 001 - 1 000 000 XOF',
                          style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.bodyLarge)),
                    )),
                  ),
                  TableCell(
                    child: Center(
                        child: Text('2 000 XOF',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge))),
                  ),
                  TableCell(
                    child: Center(
                        child: Text('2 000 XOF',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge))),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Center(
                        child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Text('1 000 000 XOF ->',
                          style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.bodyLarge)),
                    )),
                  ),
                  TableCell(
                    child: Center(
                        child: Text('3 000 XOF',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge))),
                  ),
                  TableCell(
                    child: Center(
                        child: Text('3 000 XOF',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
