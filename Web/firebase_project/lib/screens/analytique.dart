import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_project/constants.dart';
import 'package:firebase_project/screens/items/headBox.dart';

class Analytique extends StatelessWidget {
  const Analytique({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [HeadMain(mainTitle: "Analytique")],
      ),
    );
  }
}
