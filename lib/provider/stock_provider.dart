import 'package:exp/model_classes/items_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:exp/database/local/db_helper.dart';

class StockProvider extends ChangeNotifier {
  List<item_model_class> _list = [];

  List<item_model_class> get list => _list;

  Future<void> insertingData() async {
    for (item_model_class item in _list) {
      await DbHelper.getinstance().insertdata(item);
    }
    await fetchData(); // Refresh after insert
  }

  Future<void> fetchData() async {
    _list = await DbHelper.getinstance().getdata();
    notifyListeners();
  }

  void addItem(item_model_class item) {
    _list.add(item);
    notifyListeners();
  }
  Future<void> updateItem(item_model_class item) async {
    await DbHelper.getinstance().updateItem(item);
    await fetchData(); // refresh local list
  }

  Future<void> deleteItem(int id) async {
    await DbHelper.getinstance().deleteItem(id);
    _list.removeWhere((item) => item.id == id);
    notifyListeners();
  }


  void loadInitialStock(List<item_model_class> items) {
    _list = items;
    insertingData(); // Save to DB and refresh
  }

  void clear() {
    _list.clear();
    notifyListeners();
  }
}
