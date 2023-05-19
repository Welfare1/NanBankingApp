import 'package:flutter/material.dart';
import 'package:firebase_project/screens/transactions/items/dropButtonBnk.dart';

class AppState with ChangeNotifier {
  // String myVariable = "Initial Value";

  void updateVariable(String newValue) {
    notifyListeners();
  }
}
