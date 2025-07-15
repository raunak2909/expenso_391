import 'package:flutter/widgets.dart';

class NavigationProvider extends ChangeNotifier{

  int _currPageIndex = 0;

  int getCurrPageIndex() => _currPageIndex;

  void updatePageIndex({required int index}){
    _currPageIndex = index;
    notifyListeners();
  }

}