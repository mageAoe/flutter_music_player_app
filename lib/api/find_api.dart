import 'package:flutter_music_player_app/services/httpClient.dart';
import 'package:flutter_music_player_app/model/banners_model.dart';
import 'package:flutter_music_player_app/services/api.dart';

class FindApi {

  static final HttpClient _httpClient = HttpClient();

  // 获取banner
  static Future<List<Banners>?> getBanner() async {
    var res = await _httpClient.getJsonData(Api.URL_BANNER_LIST,useCache: true, checkCacheTimeout: true);
    if(res != null){
      List<Banners> bannerList = BannersModel.fromJson(res).banners;
      return bannerList;
    }else{
      return null;
    }
  }

  // 每日推荐歌曲
  static Future<List<Banners>?> getRecommendSongs() async {
    var res = await _httpClient.getJsonData(Api.URL_RECMMEND_SONGS,useCache: true, checkCacheTimeout: true);
    if(res != null){
      List<Banners> bannerList = BannersModel.fromJson(res).banners;
      return bannerList;
    }else{
      return null;
    }
  }
}