import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_music_player_app/services/httpClient.dart';
import 'package:flutter_music_player_app/utlis/song_util.dart';


/// 本地文件工具类
class FileUtil{
  static const String songsDir = "songs";
  static const String lyricDir = "lyrics";
  static const String music = ".mp3";

  /// 获取子目录路径
  static Future<String> getSubDirPath(String subDirPath) async {
    // get the path to the document directory.
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    // print('appDocumentsDir: ${appDocumentsDir.path}'); //  /data/user/0/com.example.flutter_music_player_app/app_flutter
    return '${appDocumentsDir.path}/$subDirPath';
  }


  /// 相对app目录之下创建子目录
  static Future<Directory> createLocalDir(String subDirPath) async {
    String dirPath = await getSubDirPath(subDirPath);
    // print('dirPath: $dirPath'); // '/data/user/0/com.example.flutter_music_player_app/app_flutter'/cache
    Directory dir = Directory(dirPath);
    if (await dir.exists()) {
      return dir;
    } else {
      // 如果目录不存在，就创建
      return dir.create(recursive: true);
    }
  }

  /// 判断文件是否存在
  static Future<bool> isFileExists(String filePath) async {
    return File(filePath).exists();
  }

  /// 获取歌曲本地路径
  static Future<String> getSongLocalPath(int songId) async {
    String dir = await getSubDirPath(songsDir);
    String fileName = '$songId.mp3';
    String filePath = '$dir/$fileName';
    return filePath;
  }

    /// 获取收藏歌曲歌词
  static Future<String> getLyricLocalPath(int songId) async {
    String dir = await getSubDirPath(lyricDir);
    String fileName = '$songId.lyric';
    String filePath = '$dir/$fileName';
    return filePath;
  }


  /// 删除文件
  static Future<bool> deleteLocalSong(Map song) async {
    int songId = song['id'];
    deleteFile(await getSongLocalPath(songId));
    deleteFile(await getLyricLocalPath(songId));
    return true;
  }

  /// 删除文件
  static Future<bool> deleteFile(String path) async {
    File file = File(path);
    if (await file.exists()) {
      await file.delete(recursive: true);
    }
    return true;
  }


  /// 判断文件是否超时
  static bool isFileTimeout(File file, Duration duration) {
    DateTime lastModified = file.lastModifiedSync();
    return isTimeOut(lastModified, duration);
  }

  /// 判断上一次事件是否超过
  static bool isTimeOut(DateTime lastTime, Duration duration) {
    DateTime now = DateTime.now();
    return now.isAfter(lastTime.add(duration));
  }

  // 下载音频文件
  static Future<void> downloadMp3(int songId) async {
    String savePath = await FileUtil.getSongLocalPath(songId);
    String url = SongUtil.getSongUrl(songId);
    HttpClient.download(url, savePath);
    print('download: $url');
  }

}