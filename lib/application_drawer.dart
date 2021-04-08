import 'package:flutter/foundation.dart';

class ApplicationDrawer with ChangeNotifier{
  int _currentDrawer = 0;
  int get getCurrentDrawer => _currentDrawer;

  void setCurrentDrawer(int drawer){
    _currentDrawer = drawer;
    notifyListeners();
  }
}