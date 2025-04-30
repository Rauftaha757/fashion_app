import 'package:exp/database/local/db_helper.dart';
import 'package:flutter/foundation.dart';

class oder_provider extends ChangeNotifier {
  List _oderlist = [];

  // Getter for orders list
  List getalloder() => _oderlist;

  // Fetch orders from the database asynchronously and update the list
  Future<void> getoderfromdb() async {
    _oderlist = await DbHelper.getinstance().gettalloder();
    notifyListeners(); // Notify listeners after updating the data
  }

  Future<void> getoderbyid(userid)async{
    _oderlist=await DbHelper.getinstance().getOrdersByUserId(userid);

  }
}
