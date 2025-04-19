import 'package:flutter/cupertino.dart';

class counter_provider extends ChangeNotifier{
  int _count=0;
  int getcount()=> _count;
  void increament(){

    _count++;
    notifyListeners();
  }
  void decrement(){
    if(_count>0)
    _count--;
    notifyListeners();
  }
}