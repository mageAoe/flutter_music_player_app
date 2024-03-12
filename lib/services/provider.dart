// import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

// model 类
class UserState{
  bool isMyLoading; // 是否需要展示骨架屏
  
  UserState({
    required this.isMyLoading,
  });

  bool get _isMyLoading => isMyLoading;
}


class Shop extends ChangeNotifier{
  UserState user = UserState(isMyLoading: true);

  // getter methods
  bool get isMyLoading => user._isMyLoading;
  
  void setIsMyLoading(bool value) {
    user.isMyLoading = value;
    notifyListeners();
  }
}