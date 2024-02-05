import 'package:flutter_music_player_app/services/httpClient.dart';
import 'package:flutter_music_player_app/model/banners_model.dart';

class FindApi {

  static final HttpClient _httpClient = HttpClient();


  static Future<List<Banners>?> getBanner() async {
    var res = await _httpClient.getJsonData(HttpClient.URL_BANNER_LIST,useCache: true, checkCacheTimeout: true);
    if(res != null){
      List<Banners> bannerList = BannersModel.fromJson(res).banners;
      return bannerList;
    }else{
      return null;
    }
  }
}