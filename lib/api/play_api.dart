import 'dart:io';
import 'dart:convert';
import 'package:flutter_music_player_app/model/Lyric_model.dart';
import 'package:flutter_music_player_app/services/httpClient.dart';
import 'package:flutter_music_player_app/utlis/file_util.dart';
import 'package:flutter_music_player_app/services/api.dart';


class PlayApi {

  static final HttpClient _httpClient = HttpClient();

  // 获取歌词
  static Future<LyricModel?> getLyric(int songId) async {
    // 获取本地下载的歌词
    File cache = File(await FileUtil.getLyricLocalPath(songId));
    var data;
    try {
      bool isCached = cache.existsSync();
      if (isCached) {
        // 歌词缓存过 读取歌词
        String strCached = await cache.readAsString();
        //print('get lyric from cache: $strCached');
        if (strCached.isNotEmpty) {
          String jsonString = json.encode(strCached);
          data = jsonDecode(jsonString);
        } else {
          cache.delete();
        }
      }

      data = await _httpClient.getJsonData(
          Api.URL_LYRIC, 
          useCache: true, 
          checkCacheTimeout: false,
          query: 'id=$songId'
      );

      if(data != null){
        LyricModel lyruc = LyricModel.fromJson(data);
        return lyruc;
      }else{
        // 无歌词
        return  null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }
  
}