import 'package:exp/database/local/db_helper.dart';
import 'package:exp/model_classes/user_modelclass.dart';
import 'package:flutter/cupertino.dart';
class UserProvider extends ChangeNotifier {
  List<usermodel> _userList = [];

  List<usermodel> get userList => _userList;

  Future<List<usermodel>> getUsers() async {
    try {
      _userList = await DbHelper.getinstance().getallUsers();
      notifyListeners();
      return _userList;
    } catch (e) {
      print("Error fetching users: $e");
      return [];
    }
  }

  int? getUserId({int index = 0}) {
    if (_userList.isNotEmpty && index < _userList.length) {
      return _userList[index].id;
    } else {
      return null;
    }
  }
}


