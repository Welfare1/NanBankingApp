import 'package:firebase_project/screens/transactions/items/dropButtonBnk.dart';
import 'package:flutter/material.dart';
import 'package:firebase_project/screens/Customer/items/radioHF.dart';

Color kBackgroundColor = Colors.white;
Color kPrimaryColor = Colors.blue;

String drpValue = list.first; // For getting dropDown customer value
String drpValueBank = listBank.first;

Genre genreCus = Genre.homme;
const List<String> list = <String>[
  "Compte courant",
  "Compte d'epargne",
  "Compte à terme",
  "Compte bancaire offshore",
  "Compte professionnel",
  "Compte joint"
];
