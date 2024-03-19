// 封装网络请求
import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_music_player_app/api/api_cache.dart';

class HttpClient {
  // static String domain = 'https://service-krafzgxu-1257851434.gz.tencentapigw.com.cn/release/';
  static String domain = 'https://api.ymscq.cn/';

  static Dio dio = Dio();

  HttpClient(){
    dio.options.baseUrl = domain;
    dio.options.connectTimeout = const Duration(milliseconds: 20000); // 设置连接超时时间为5秒
    dio.options.receiveTimeout = const Duration(milliseconds: 5000); // 设置接收超时时间为5秒
  }

  /// 获取api接口json数据
  /// useCache：是否使用缓存，默认使用。但对于经常变化和容易过期的资源，例如视频播放地址，不要使用。
  /// checkCacheTimeout：是否检查缓存过期，默认检查，如果过期重新获取。对于不变的资源例如歌词，可以设置false，减少不必要的请求。
  /// query 请求的参数
  Future getJsonData(String url, {bool useCache = true, checkCacheTimeout = true, String query = '',bool isLoginCache = true, int? id}) async{
    var data;
    String responseUrl = query == '' ? url : '$url?$query';
    if (useCache) {
      // 有些资源是动态的,如播放地址，会过期不能使用缓存。
      String cache = await APICache.getCache(responseUrl, checkCacheTimeout: checkCacheTimeout, isLoginCache: isLoginCache);
      if (cache != '') {
        try {
          data = jsonDecode(cache);
        } catch (e) {
          APICache.deleteCache(responseUrl);
        }
      }
    }
    // APICache.deleteCache('top/playlist'); // 缓存错误的数据删除
    // 缓存没取到，就请求网络。
    if (data == null) {
      /// 这儿文本要缓存处理，所以ResponseType不用默认的json格式
      /// 或者使用 jsonEncode将Map对象转为json字符串，不要用toString，会丢掉符号信息。
      try {
        print('responseUrl: $responseUrl');
        Response response = await dio.get(responseUrl);
        if (response.statusCode == HttpStatus.ok) {
          Map text = response.data;
          String jsonString = json.encode(text);
          data = jsonDecode(jsonString);
          if (useCache) {
            // 缓存到本地
            String cacheUrl = id == null? responseUrl : '$url/$id'; // 为了缓存歌单
            bool re = await APICache.saveCache(cacheUrl, jsonString);
            print('saveCache $cacheUrl result: $re');
          }
        } else {
          throw Exception('Request failed, errorCode: ${response.statusCode}');
        }
      } catch (e) {
        /// 如果网络超时，会报 DioErrorType.CONNECT_TIMEOUT
        print(e);
        print('网络请求超时');
      }
    }
    return data;
  }

  // 下载mp3到本地
  /// [url] 要下载的资源地址
  /// [savePath] 要保存的本地路径
  static void download(String url, String savePath) {
    print('download $url to $savePath');
    File localFile = File(savePath);
    localFile.exists().then((exists) {
      if (!exists) {
        localFile.createSync(recursive: true);
      }
      return Dio().download(url, savePath);
    }).then((response) {
      if (response.statusCode == 200) {
        print('下载成功');
      } else {
        print('下载失败：${response.statusCode}');
      }
    });
  }

  // 获取重定向之后的地址
  static Future<String> getRedirectedUrl(String path) async {
    try {
      Response response = await dio.head(path);
      if (response.isRedirect == true) {
        String redirectedUrl = response.realUri.toString();
        print("重定向后的地址：$redirectedUrl");
        String replaceUrl = redirectedUrl.replaceAll('http', 'https');
        print("替换后的地址：$replaceUrl");
        return replaceUrl;
      } else {
        print("没有发生重定向");
        return path;
      }
    } catch (e) {
      print("发生错误：$e");
      return path;
    }
  }

}