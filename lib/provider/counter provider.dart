import 'package:flutter/cupertino.dart';

class counter_provider extends ChangeNotifier {
  final Map<String, int> _itemCounts = {};

  int getItemCount(String itemName) {
    return _itemCounts[itemName] ?? 0;
  }

  void increment(String itemName) {
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
}
