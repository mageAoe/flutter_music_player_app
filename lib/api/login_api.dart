import 'package:flutter_music_player_app/services/httpClient.dart';
import 'package:flutter_music_player_app/model/login_model.dart';
import 'package:flutter_music_player_app/services/api.dart';
import 'package:flutter_music_player_app/model/user_detail_model.dart';

class LoginApi {
  static final HttpClient _httpClient = HttpClient();

  // 获取验证码
  // 验证码不做缓存
  static Future getCode(String query) async {
    await _httpClient.getJsonData(
      Api.URL_CAPTCHA_SENT, 
      useCache: false, 
      checkCacheTimeout: false,
      query: query
    );
  }

  // 手机号 + 验证码登录
  static Future<UserInfo?> getUserInfo(String query) async {
    var res = await _httpClient.getJsonData(
      Api.URL_LOGIN_CELLPHONE, 
      useCache: true, 
      checkCacheTimeout: true,
      query: query
    );
    if(res != null){
      UserInfo userInfo = UserInfo.fromJson(res);
      return userInfo;
    }else{
      return null;
    }
  }

  // 获取用户详情
  static Future<UserDetailModel?> getUserDetail(String query) async {
    var res = await _httpClient.getJsonData(
      Api.URL_USER_DETAIL, 
      useCache: true, 
      checkCacheTimeout: true,
      query: query
    );
    print(Api.URL_USER_DETAIL);
    print(query);
    print(res);
    if(res != null){
      UserDetailModel userDetail = UserDetailModel.fromJson(res);
      return userDetail;
    }else{
      return null;
    }
  }
}