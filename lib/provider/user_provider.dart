import 'package:exp/database/local/db_helper.dart';
import 'package:exp/model_classes/user_modelclass.dart';
import 'package:flutter/cupertino.dart';
class UserProvider extends ChangeNotifier {
  List<usermodel> _userList = [];


  List<usermodel> get userList => _userList;
  Future<List<usermodel>> getUsers() async {
    _userList = await DbHelper.getinstance().getallUsers();
    notifyListeners();
    return _userList;
  }

  int? getUserId() {
    if (_userList.isNotEmpty) {
      return _userList[0].id;
    } else {
      return null;
    }
  }
}

