// 封装网络请求
import 'package:dio/dio.dart';

class HttpClient {
  static String domain = 'https://cloud-music-api-six-taupe.vercel.app';

  static Dio dio = Dio();

  static String URL_PLAY_LIST = '$domain/banner?type=1&timestamp=';

  HttpClient(){
    // dio.options.baseUrl = domain;
    dio.options.connectTimeout = const Duration(milliseconds: 10000);
    dio.options.receiveTimeout = const Duration(milliseconds: 5000);
  }

  Future get() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    try {
      var res = await dio.get('https://api.ymscq.cn/banner?type=1');
      return res;
    } catch (e) {
      print('请求超时');
      print(e);
      return null;
    }
  }

  Future post(String apiUrl, {Map? data }) async {
    try {
      var res = await dio.post(apiUrl, data: data);
      return res;
    } catch (e) {
      print('请求超时');
      return null;
    }
  }

}