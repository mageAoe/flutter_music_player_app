import 'package:flutter_music_player_app/utlis/file_util.dart';
import 'package:flutter_music_player_app/model/playlist_track_all_model.dart';
import 'package:flutter_music_player_app/api/play_api.dart';




class SongUtil{

  static String getSongUrl(int id) {
    return "https://music.163.com/song/media/outer/url?id=$id.mp3";
  }

  static Future<String> getPlayPath(Songs song) async{
    String localPath = await FileUtil.getSongLocalPath(song.id!);
    // 获取本地缓存地址
    if (await FileUtil.isFileExists(localPath)) {
      return localPath;
    } else {
      String? url = await PlayApi.getSongUrl('id=${song.id}');
      String replaceUrl = url!.replaceAll('http', 'https');
      return replaceUrl;
      // return getSongUrl(song.id!);
    }
  }

  static String getArtistImage(Map artist, {int size = 100, int width = 0, int height = 0}) {
    String imgUrl = artist['picUrl'];
    if (width > 0 && height > 0) {
      imgUrl += '?param=${width}y$height';
    } else if (size > 0) {
      imgUrl += '?param=${size}y$size';
    }
    return imgUrl;
  }

  static String getSongImage(Songs song, {int size = 100, int width = 0, int height = 0}) {
    String? imgUrl;
    try {
      if (song.al != null) {
        imgUrl = song.al!.picUrl!;
      } 
      // else if (song.containsKey('song')) { // URL_NEW_SONGS里面的数据结构
      //   imgUrl = song['song']['album']['picUrl'];
      // }
      // if (imgUrl != null) {
      //     song = imgUrl;  // 取一次之后存下来，不用后面计算。
      // }
    } catch(e) {
      print(e);
      print(song.name);
      return '';
    } 

    if (imgUrl == null || imgUrl.isEmpty) {
      return '';
    }
    if (width > 0 && height > 0) {
      imgUrl += '?param=${width}y$height';
    } else if (size > 0) {
      imgUrl += '?param=${size}y$size';
    }

    //print('imageUrl: $imgUrl');
    return imgUrl;
  }

  static String getArtistNames(Songs song) {
    // if (song.name != null) {
    //   return song.name!;
    // }

    String names = '';
    List<Ar?> arList = [];

    if (song.ar != null) {
      arList = song.ar!;
    } 
    // else if (song) {
    //   arList = song['artists'];
    // } else {
    //   arList = song['song']['artists'];
    // }

    bool isFirst = true;
    for (var ar in arList) {
      if (isFirst) {
        isFirst = false;
        names = ar!.name!;
      } else {
        names += " ${ar!.name!}";
      }
    }
      
    // 取了之后存下来，不用重复取了。
    // song.al?.name = names;

    // 测试，不要在build里面调用相同的函数，会频繁执行。
    //print("getAritistNames: $names");
    return names;
  }
}