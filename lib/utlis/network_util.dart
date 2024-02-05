import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtil {

  /// 单例对象的写法
  // 私有静态instance
  // static late NetworkUtil _instance;
  static late ConnectivityResult networkState;
  late var subscription;

  // 工厂构造函数
  // 对外访问点，指向私有静态方法
  // factory NetworkUtil() {
  //   // _instance ??= NetworkUtil._();
  //   return _instance;
  // }

  // 将默认构造函数私有化
  // NetworkUtil._();


  initNetworkListener(){
    // You can also listen for network state changes by subscribing to the stream exposed by connectivity plugin
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      networkState = result;
      print('当前网络状态: $networkState');
    });
  }

  ConnectivityResult getNetworkState(){
    return networkState;
  }

  bool isNetworkAvailable(){
    return networkState != ConnectivityResult.none;
  }

  void dispose() {
    //在页面销毁的时候一定要取消网络状态的监听
    subscription.cancel();
  }
}