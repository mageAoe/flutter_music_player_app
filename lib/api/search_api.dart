import 'package:flutter_music_player_app/services/httpClient.dart';
import 'package:flutter_music_player_app/services/api.dart';
import 'package:flutter_music_player_app/model/search_hot_model.dart';
import 'package:flutter_music_player_app/model/search_model.dart';


class SearchApi {
  static final HttpClient _httpClient = HttpClient();

  // 搜索
  static Future<SearchModel?> getSearch(String query) async {
    var res = await _httpClient.getJsonData(
      Api.URL_SEARCH, 
      useCache: true, 
      checkCacheTimeout: true,
      query: query
    );
    if(res != null){
      SearchModel search = SearchModel.fromJson(res);
      return search;
    }else{
      return null;
    }
  }

  // 热搜榜
    static Future<SearchHotModel?> getSearchHot() async {
    var res = await _httpClient.getJsonData(
      Api.URL_SEARCH_HOT_DETAIL, 
      useCache: true, 
      checkCacheTimeout: true,
    );
    if(res != null){
      SearchHotModel searchHot = SearchHotModel.fromJson(res);
      return searchHot;
    }else{
      return null;
    }
  }
}