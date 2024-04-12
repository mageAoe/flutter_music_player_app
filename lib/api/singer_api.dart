import 'package:flutter_music_player_app/services/httpClient.dart';
import 'package:flutter_music_player_app/services/api.dart';
import 'package:flutter_music_player_app/model/singer_model.dart';



class SingerApi {
  static final HttpClient _httpClient = HttpClient();

  // 歌手信息
  static Future<SingerModel?> getSingerList(String query) async {
    var res = await _httpClient.getJsonData(
      Api.URL_ARTIST_LIST, 
      useCache: true, 
      checkCacheTimeout: true,
      query: query
    );
    if(res != null){
      SingerModel singerList = SingerModel.fromJson(res);
      return singerList;
    }else{
      return null;
    }
  }
}