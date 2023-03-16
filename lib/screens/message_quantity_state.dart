import 'package:flutter/cupertino.dart';

class MessageQuantityState with ChangeNotifier {
  int quantity = 0;

  void changeQuantity(int quantity) {
    this.quantity = quantity;
    notifyListeners();
  }
}