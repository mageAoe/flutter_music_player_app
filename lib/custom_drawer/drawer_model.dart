import 'package:flutter/material.dart';


// 公共方法
class DrawerModel with ChangeNotifier {  
  double _drawerOffset = 0.0;  
  ScrollController? _scrollController;  
  final double drawerWidth;  
  
  DrawerModel(this.drawerWidth);  
  
  double get drawerOffset => _drawerOffset;  
  
  ScrollController? get scrollController => _scrollController;  
  
  setScrollController(ScrollController controller) {  
    _scrollController = controller;  
  }  
  
  void toggleDrawer({bool value = true}) { 
    if (_drawerOffset == 0.0 && value) {  
      _scrollController?.animateTo(  
        drawerWidth,  
        duration: const Duration(milliseconds: 400),  
        curve: Curves.fastOutSlowIn,  
      );  
      _drawerOffset = drawerWidth;  
    } else {  
      _scrollController?.animateTo(  
        0.0,  
        duration: const Duration(milliseconds: 400),  
        curve: Curves.fastOutSlowIn,  
      );  
      _drawerOffset = 0.0;  
    }  
    notifyListeners();  
  }  
}