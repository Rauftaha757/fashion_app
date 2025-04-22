import 'package:flutter/cupertino.dart';
import 'package:exp/model_classes/items_list.dart';
import 'package:flutter/material.dart';

class cart_provider extends ChangeNotifier {
  final List<item_model_class> _cart_items = [];

  // keep your existing getter name
  List<item_model_class> getallitems() => _cart_items;

  // keep method name and parameter exactly as you wrote them
  void addtocart(item_model_class item, BuildContext context) {

    final alreadyExists =
    _cart_items.any((cartItem) => cartItem.name == item.name);

    if (!alreadyExists) {
      // 🛒 2. Not in cart → add it.
      _cart_items.add(item);
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item is already in the cart'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }


  void clear() {
    _cart_items.clear();
    notifyListeners();
  }
}
