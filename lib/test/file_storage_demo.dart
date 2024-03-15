// 字节流
// 文件权限
// 文件存储

// ignore_for_file: slash_for_doc_comments
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_music_player_app/utlis/file_util.dart';
import 'package:flutter_music_player_app/utlis/song_util.dart';
import 'package:flutter_music_player_app/services/httpClient.dart';



class FileStrageDemo {

  static Future<String> _localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

// ------------------字节流--------------------
// 字节流是一种低级的输入输出流，它以字节为单位进行读写操作。字节流通常用于处理二进制数据，如图片、音频和视频等。

// 在Dart中，我们可以使用File类的openRead和openWrite方法来创建字节流。

// 以下是一些使用字节流进行文件读写的示例：

/**
 为此文件的内容创建一个新的独立 [Stream]。
 
 如果 [start] 存在，将从字节偏移量 [start] 读取文件。否则从开始（索引0）。
 
 如果 [end] 存在，只读取到字节索引 [end] 的字节。否则，直到文件结束。
 
 为确保系统资源被释放，必须读取流到完成，或者取消对流的订阅。
 
 如果 [File] 是一个 [命名管道](https://en.wikipedia.org/wiki/Named_pipe)
 那么返回的 [Stream] 将等待管道的写入端关闭后才会发出 "done" 信号。如果在打开时管道没有连接的写入器，
 那么 [Stream.listen] 将等待写入器打开管道。
 Stream<List<int>> openRead([int? start, int? end]);
*/
  // 使用 openRead 方法可以创建一个字节流，用于读取文件的内容。openRead 方法返回一个 Stream<List<int>> 对象，我们可以使用 Stream 的各种方法来处理字节流
  // 在这个示例中，我们首先创建了一个字节流，然后使用await for循环来处理字节流中的数据。
  static void file1() async{
    var file = File('test.txt');
    Stream<List<int>> inputStream = file.openRead();
    await for (var data in inputStream) {
      // 处理数据...
    }
  }
  
  // 使用 openWrite 方法可以创建一个字节流，用于向文件中写入数据。openWrite 方法返回一个 IOSink 对象，我们可以使用IOSink 的 add 或 write 方法来写入数据
  // 在这个示例中，我们首先创建了一个字节流，然后使用 write 方法向字节流中写入数据。最后，我们使用 close 方法关闭字节流
  void file2() async{
    var file = File('test.txt');
    var outputStream = file.openWrite();
    outputStream.write('Hello, Dart!');
    await outputStream.close();
  }

// ------------------字符流--------------------
// 以字节流读取文件
// 字符流是一种高级的输入输出流，它以字符为单位进行读写操作。字符流通常用于处理文本数据。
// 在 Dart 中，我们可以使用 File 类的 readAsString 和 writeAsString 方法来进行字符流的读写操作。

  // 在这个示例中，我们使用 readAsString 方法读取了文件的内容，并将其打印出来
  void file3() async{
    var file = File('test.txt');
    String contents = await file.readAsString();
    print(contents);
  }

  // 使用 writeAsString 方法可以向文件中写入字符串。如果文件不存在，writeAsString 方法会创建一个新的文件。如果文件已经存在，writeAsString 方法会覆盖文件的内容
  /**
   * 将字节列表写入文件。
   * 打开文件，将字节列表写入文件，然后关闭文件。返回一个 `Future<File>`，当整个操作完成后，该Future将完成并返回此 [File] 对象。
   * 认情况下，[writeAsBytes] 会创建文件并进行写入，如果文件已存在，将会截断文件。如果要将字节追加到现有文件，可以将 [FileMode.append] 作为可选的mode参数传入。
   * 如果参数 [flush] 设置为 `true`，在返回的Future完成之前，写入的数据将被刷新到文件系统。
   */
  // 在这个示例中，我们使用 writeAsString 方法向文件中写入了一些文本
  void file4() async{
    var file = File('test.txt');
    await file.writeAsString('Hello, Dart!');
  }

  // 使用流优化文件读写
  // 在读取或写入大文件时，我们通常使用流来处理数据。流可以让我们以块的形式处理数据，而不是一次性加载整个文件到内存中。这样可以显著减少内存使用，并提高程序的响应性
  // 在这个示例中，我们首先打开了一个文件的读取流，然后使用 transform 方法将字节流转换为字符串流，再将字符串流转换为行流。最后，我们使用 listen 方法处理每一行数据。
  void file5() async{
    var file = File('large_file.txt');
    var inputStream = file.openRead();

    inputStream
      .transform(utf8.decoder)  // 将字节解码为UTF-8
      .transform(const LineSplitter())  // 将流转换为单独的行
      .listen((String line) {  // 处理结果
        print('从流中获得 ${line.length} 个字符');
      }, onDone: () {
        print('文件现已关闭');
      }, onError: (e) {
        print(e.toString());
    });
  }


  // ------------------文件权限-------------------- 

  // 在进行文件操作时，我们需要考虑到平台权限问题。不同的操作系统和设备可能有不同的权限要求。以下是一些可能需要处理的权限问题

  // 使用 permission_handler 请求权限
  // 为了方便的获取相应的用户授权，在进行文件操作前，我们需要检查并请求必要的运行时权限，这可以使用 permission_handler 库来完成。我们可以使用来处理运行时权限。
  // 请求存储权限
  // 以下是一个请求权限的示例
  /**
   * import 'package:permission_handler/permission_handler.dart';

      void main() async {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
        }

        if (status.isGranted) {
          // 你可以开始文件操作
        } else {
          // 不能启动文件操作
        }
      }
   */

  // 处理权限拒绝
  // 如果用户拒绝了我们的权限请求，我们需要处理这种情况。我们可以显示一个解释为什么我们需要这个权限的对话框，或者引导用户到系统设置中开启权限
  /**
    import 'package:permission_handler/permission_handler.dart';

    void handler_storage_permission() async {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }

      if (status.isGranted) {
        // 你可以开始文件操作
        // ...
      } else if (status.isPermanentlyDenied) {
        // 用户选择永久拒绝权限
        // 你可以在这里打开应用设置
        // ...
        openAppSettings();
      } else {
        // 用户选择拒绝权限
        // 你可以在这里显示一个对话框
        // ...
      }
    }
   */



  // ------------------文件存储-------------------- 

  // path_provider 库及其用法
  // api: https://pub-web.flutter-io.cn/documentation/path_provider/latest/path_provider/path_provider-library.html
  // path_provider 是一个Flutter插件，用于查找iOS和Android上的常用位置的路径。这个库可以帮助我们找到存储应用数据的正确位置。

  // 获取临时目录
  // 我们可以使用getTemporaryDirectory方法来获取临时目录的路径。临时目录是一个可以用来存储临时数据的目录。系统可能会随时清理这个目录，因此不应将重要数据保存在这里。
  static void path1() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    print(tempPath);
  }
  // 取应用程序目录
  // 我们可以使用getApplicationDocumentsDirectory方法来获取应用程序目录的路径。应用程序目录是一个可以用来存储应用需要持久化的数据的目录。
  // 系统不会清理这个目录，因此可以安全地将重要数据保存在这里。
  static void path2() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    print(appDocPath);
  }
  // 获取外部存储中为应用程序创建的目录
  // 我们可以使用 getExternalStorageDirectory 方法来获取外部存储中为应用程序创建的目录的路径。
  // 这个目录通常用来存储可以由用户在其他应用中访问的文件，如图片、音乐等
  static void path3() async {
    Directory? externalStorageDir = await getExternalStorageDirectory();
    String externalStoragePath = externalStorageDir!.path;
    print(externalStoragePath);
  }
  // 获取应用程序可以放置应用库文件的目录
  // 我们可以使用getApplicationSupportDirectory方法来获取应用程序可以放置应用库文件的目录的路径。这个目录用来存储应用的支持文件，这些文件只有应用本身可以访问。
  static void path4() async {
    Directory supportDir = await getApplicationSupportDirectory();
    String supportPath = supportDir.path;
    print(supportPath);
  }


// 读写特殊类型的文件示例
// 在Flutter中，我们可以使用File类来读写各种类型的文件，包括图片、音频等特殊类型的文件。
// 然而，由于这些特殊类型的文件通常是二进制格式的，因此我们需要使用readAsBytes和writeAsBytes方法来读写这些文件。

// 图片文件
// 读取图片文件
// 我们可以使用 readAsBytes 方法来读取图片文件，然后使用 Image.memory 构造函数来创建一个图片控件。
  Future<Widget> file6() async {
    // File file = File('image.png');
    // Uint8List bytes = await file.readAsBytes();
    // Image image = Image.memory(bytes);
    // print(image);
    var path =  await _localPath();
    var file = File('$path/test/abc.jpeg');
    var bytes = await file.readAsBytes();
    Widget image = Image.memory(bytes);
    return image;
    // Center(child: image),
  }

  // 写入图片文件
  // 我们可以使用writeAsBytes方法来写入图片文件。首先，我们需要获取图片的字节数据，然后将这些字节数据写入文件。
  static void file7() async {
    var path =  await _localPath();
    var bytes = await rootBundle.load('assets/images/avatar.jpg');
    var file = File('$path/test');
    await file.writeAsBytes(bytes.buffer.asUint8List());

    // var bytes = await rootBundle.load('assets/image.png');
    // var file = File('path_to_your_image_file');
    // await file.writeAsBytes(bytes.buffer.asUint8List());
  }

  // 音频文件
  // 读取音频文件
  // 读取音频文件的方法与读取图片文件类似，我们可以使用 readAsBytes 方法来读取音频文件。
  // 然而，由于Flutter的核心库并不支持音频播放，因此我们需要使用一个第三方库，如audioplayers，来播放音频。
  void videoRead() async {
    var file = File('path_to_your_audio_file');
    var bytes = await file.readAsBytes();
    // var player = AudioPlayer();
    // await player.playBytes(bytes);
  }
  // 写入音频文件
  // 写入音频文件的方法与写入图片文件类似，我们可以使用writeAsBytes方法来写入音频文件。
  void videoWrite() async {
    var bytes = await rootBundle.load('assets/audio.mp3');
    var file = File('path_to_your_audio_file');
    await file.writeAsBytes(bytes.buffer.asUint8List());
  }


  // 下载音频文件
  static Future<void> downloadMp3() async {
    String savePath = await FileUtil.getSongLocalPath(2116253260);
    String url = SongUtil.getSongUrl(2116253260);
    HttpClient.download(url, savePath);
    print('download: $url');
  }

}