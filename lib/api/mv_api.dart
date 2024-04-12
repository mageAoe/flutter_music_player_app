import 'package:flutter_music_player_app/services/httpClient.dart';
import 'package:flutter_music_player_app/services/api.dart';
import 'package:flutter_music_player_app/model/mv_exclusive_rcmd_model.dart';
import 'package:flutter_music_player_app/model/mv_url_model.dart';




class MVApi {
  static final HttpClient _httpClient = HttpClient();

  // 官方MV
  static Future<MvExclusiveRcmdModel?> getMvExclusiveRcmd(String query) async {
    var res = await _httpClient.getJsonData(
      Api.URL_MV_EXCLUSIVE_RCMD, 
      useCache: true, 
      checkCacheTimeout: true,
      query: query
    );
    if(res != null){
      MvExclusiveRcmdModel mvList = MvExclusiveRcmdModel.fromJson(res);
      return mvList;
    }else{
      return null;
    }
  }

  // 最新
  static Future<MvExclusiveRcmdModel?> getMvFirst(String query) async {
    var res = await _httpClient.getJsonData(
      Api.URL_MV_FIRST, 
      useCache: true,
      checkCacheTimeout: true,
      query: query
    );
    if(res != null){
      MvExclusiveRcmdModel mvList = MvExclusiveRcmdModel.fromJson(res);
      return mvList;
    }else{
      return null;
    }
  }

  // 排行
  static Future<MvExclusiveRcmdModel?> getTopMv(String query) async {
    var res = await _httpClient.getJsonData(
      Api.URL_TOP_MV, 
      useCache: true,
      checkCacheTimeout: true,
      query: query
    );
    if(res != null){
      MvExclusiveRcmdModel mvList = MvExclusiveRcmdModel.fromJson(res);
      return mvList;
    }else{
      return null;
    }
  }

  // 分类
  static Future<MvExclusiveRcmdModel?> getMvAll(String query) async {
    var res = await _httpClient.getJsonData(
      Api.URL_MV_All, 
      useCache: true,
      checkCacheTimeout: true,
      query: query
    );
    if(res != null){
      MvExclusiveRcmdModel mvList = MvExclusiveRcmdModel.fromJson(res);
      return mvList;
    }else{
      return null;
    }
  }

  // 请求地址
    static Future<MvUrlModel?> getMvUrl(String query) async {
    var res = await _httpClient.getJsonData(
      Api.URL_MV_URL, 
      useCache: true,
      checkCacheTimeout: true,
      query: query
    );
    if(res != null){
      MvUrlModel mv = MvUrlModel.fromJson(res);
      return mv;
    }else{
      return null;
    }
  }

}