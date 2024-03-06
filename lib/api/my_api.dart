import 'package:flutter_music_player_app/services/httpClient.dart';
import 'package:flutter_music_player_app/services/api.dart';
import 'package:flutter_music_player_app/model/user_detail_model.dart';
import 'package:flutter_music_player_app/model/user_playlist_model.dart';
import 'package:flutter_music_player_app/model/playlist_track_all_model.dart';

class MyApi {

  static final HttpClient _httpClient = HttpClient();

  // 获取用户详情
  static Future<UserDetailModel?> getUserDetail(String query) async {
    var res = await _httpClient.getJsonData(
      Api.URL_USER_DETAIL, 
      useCache: true, 
      checkCacheTimeout: true,
      query: query
    );
    if(res != null){
      UserDetailModel userDetail = UserDetailModel.fromJson(res);
      return userDetail;
    }else{
      return null;
    }
  }

  // 获取用户歌单
  static Future<UserPlaylistModel?> getUserPlaylist(String query) async {
    var res = await _httpClient.getJsonData(
      Api.URL_USER_PLAYLIST, 
      useCache: true, 
      checkCacheTimeout: true,
      query: query
    );
    if(res != null){
      UserPlaylistModel userPlaylist = UserPlaylistModel.fromJson(res);
      return userPlaylist;
    }else{
      return null;
    }
  }

    // 获取歌单所有歌曲
  static Future<PlaylistTrackAllModel?> getPlaylistTrackAll(String query) async {
    var res = await _httpClient.getJsonData(
      Api.URL_PLAYLIST_TRACK_ALL, 
      useCache: true, 
      checkCacheTimeout: true,
      query: query,
    );
    print('======================');
    print(query);
    print(Api.URL_PLAYLIST_TRACK_ALL);
    if(res != null){
      PlaylistTrackAllModel playlistTrack = PlaylistTrackAllModel.fromJson(res);
      return playlistTrack;
    }else{
      return null;
    }
  }
}
