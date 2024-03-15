import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter_music_player_app/utlis/file_util.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';



class CacheFile{

  // Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return directory.path;
  // }

  // Future<File> get _localFile async {
  //   final path = await _localPath;
  //   return File('$path/counter.txt');
  // }

  static Future<String> _localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File>  _localFile() async {
    final path = await _localPath();
    print('path -- $path'); // data/user/0/com.example.flutter_music_player_app/app_flutter
    // return File('$path/counter.txt');
    return File('$path/test/aaaaaaa');
  }



  // 以下是一个简单的示例，演示如何使用 File 类来创建一个新文件，并向其中写入一些文本
  static void demo1() async {
    var file = File('test.txt');
    try {
      await file.writeAsString('Hello, Dart!');
    } catch (e) {
      print('Error: $e');
    }
  }

  // 创建文件：使用 create 方法可以创建一个新的文件。如果文件已经存在，create 方法不会有任何效果。如果你希望覆盖已经存在的文件，可以给 create 方法传入一个名为 recursive 的参数，将其设为 true。
  static void demo2() async {
    // var file = File('test.txt');
    final file = await _localFile();
    try {
      await file.create(recursive: true);
    } catch (e) {
      print('Error: $e');
    }
  }

  // 读取文件：使用 readAsString 方法可以读取文件的内容，返回一个字符串。如果文件不存在，readAsString 方法会抛出一个异常
  static void demo3() async {
    // var file = File('test.txt');
    final file = await _localFile();
    print('=======$file');
    try{
      String contents = await file.readAsString();
      print(contents);
    }catch(e){
      print('文件不存在: $e');
    }
  }
  // 写入文件：使用 writeAsString 方法可以向文件中写入字符串。如果文件不存在，writeAsString 方法会创建一个新的文件。如果文件已经存在，writeAsString 方法会覆盖文件的内容。
  // 跟第一个demo一样的
  static void demo4() async {
    // var file = File('test.txt');
    final file = await _localFile();
    File? fileCached;
    try {
      fileCached = await file.writeAsString('Hello, Dart!');
    } catch (e) {
      print(e);
    }
    print('fileCached: $fileCached');
  }
  // 删除文件：使用 delete 方法可以删除一个文件。如果文件不存在，delete 方法不会有任何效果。
  static void demo5() async {
    final file = await _localFile();
    try {
      await file.delete();
    } catch (e) {
      print(e);
    }
    // var file = File('test.txt');
    // await file.delete();
  }

  // ----------------权限--------------
  // 如果我们没有权限写入 ‘/root/test.txt’ 文件，writeAsString 方法会抛出一个 FileSystemException 异常，然后我们在 catch 语句中捕获这个异常，并打印一个错误消息
  static void demo6() async {
    var file = File('/root/test.txt');
    try {
      await file.writeAsString('Hello, Dart!');
    } catch (e) {
      print('Error: $e');
    }
  }

}