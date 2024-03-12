import 'package:flutter_music_player_app/services/httpClient.dart';
import 'package:flutter_music_player_app/services/api.dart';
import 'package:flutter_music_player_app/model/playlist_hot_model.dart';
import 'package:flutter_music_player_app/model/top_playlist_model.dart';


class SongSheetApi {
  static final HttpClient _httpClient = HttpClient();

  // 热门歌单分类
  static Future<PlaylistHotModel?> getPlaylistHot() async {
    var res = await _httpClient.getJsonData(
      Api.URL_PLAYLIST_HOT, 
      useCache: true, 
      checkCacheTimeout: true,
    );
    if(res != null){
      PlaylistHotModel playlistHot = PlaylistHotModel.fromJson(res);
      return playlistHot;
    }else{
      return null;
    }
  }

  // 获取歌单
  static Future<TopPlaylistModel?> getTopPlaylist(String query) async {
    var res = await _httpClient.getJsonData(
      Api.URL_TOP_PLAYLIST, 
      useCache: true,
      checkCacheTimeout: true,
      query: query
    );
    print(query);
    if(res != null){
      TopPlaylistModel topPlaylistH = TopPlaylistModel.fromJson(res);
      return topPlaylistH;
    }else{
      return null;
    }
  }

}