import 'package:flutter/cupertino.dart';

class counter_provider extends ChangeNotifier {
  final Map<String, int> _itemCounts = {};
  final Map<String, double> _itemPrices = {}; // New: to store item prices

  int getItemCount(String itemName) {
    return _itemCounts[itemName] ?? 0;
  }

  double getItemPrice(String itemName) {
    return _itemPrices[itemName] ?? 0.0;
  }

  void setItemPrice(String itemName, double price) {
    _itemPrices[itemName] = price;
  }

  void increment(String itemName, {double? price}) {
    if (price != null) {
      _itemPrices[itemName] = price;
    }
    _itemCounts[itemName] = getItemCount(itemName) + 1;
    notifyListeners();
  }

  void decrement(String itemName) {
    final currentCount = getItemCount(itemName);
    if (currentCount > 0) {
      _itemCounts[itemName] = currentCount - 1;
      notifyListeners();
    }
  }

  double getTotalPrice() {
    double total = 0.0;
    _itemCounts.forEach((itemName, count) {
      final price = _itemPrices[itemName] ?? 0.0;
      total += price * count;
    });
    return total;
  }
  void clearcounter() {
    _itemCounts.clear();
    _itemPrices.clear();
    notifyListeners();
  }

}
