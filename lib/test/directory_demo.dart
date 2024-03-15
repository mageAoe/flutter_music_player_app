import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';



class DirectoryDemo{

  static Future<String> _localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }


  //-------------目录-------------------
  // 使用 create 方法可以创建一个新的目录。如果目录已经存在，create 方法不会有任何效果。如果你希望创建的目录的父目录不存在，可以给 create 方法传入一个名为 recursive 的参数，将其设为 true
  static void dir1() async {
    String dirPath = await _localPath();
    var directory = Directory('$dirPath/test');
    print('directory: $directory');
    await directory.create();
    // var directory = Directory('test');
    // await directory.create();
  }

  //使用list方法可以列出目录的内容，包括文件和子目录。list 方法返回一个 Stream 对象，我们可以使用 await for 语句来遍历这个 Stream
  static void dir2() async {
    String dirPath = await _localPath();
    var directory = Directory('$dirPath/test');
    print('directory: $directory');
    await for (var entity in directory.list()) {
      print(entity.path);
    }

    // var directory = Directory('test');
    // await for (var entity in directory.list()) {
    //   print(entity.path);
    // }
  }

  // 使用 delete 方法可以删除一个目录。如果目录不存在，delete 方法不会有任何效果。如果你希望删除的目录包含文件或子目录，可以给 delete 方法传入一个名为 recursive 的参数，将其设为true
  static void dir3() async {
    String dirPath = await _localPath();
    var directory = Directory('$dirPath/test');
    try {
      await directory.delete();
    } catch (e) {
      print(e);
    }

    // var directory = Directory('test');
    // await directory.delete();
  }

  //-------------链接-------------------

  // 使用 create 方法可以创建一个新的链接。如果链接已经存在，create方法会覆盖已经存在的链接。在这个示例中，我们创建了一个新的链接，该链接指向名为 ‘test.txt’ 的文件
  void link1() async {
    var link = Link('link');
    await link.create('test.txt');
  }

  // 使用update方法可以更新链接的目标。
  void link2() async {
    var link = Link('link');
    await link.update('test2.txt');
  }

  // 使用 delete 方法可以删除一个链接。如果链接不存在，delete 方法不会有任何效果。
  void link3() async {
    var link = Link('link');
    await link.delete();
  }

  //----------------------------------路径---------------------------------
  // 在 Dart 中，我们可以使用字符串来表示路径。例如，我们可以创建一个表示文件路径的字符串，然后使用这个字符串来创建一个 File 对象
  static void path1() async {
    var path = '/data/user/0/com.example.flutter_music_player_app/app_flutter/test/aaaaaaa';
    var file = File(path);
    print(file);

    // var path = '/home/user/documents/report.txt';
    // var file = File(path);
  }
  
  // 连接路径（join） join 函数可以连接两个或多个路径。它会自动处理路径中的分隔符，使得你的代码可以在不同的操作系统上正确运行
  static void path2() async {
    var p = path.join('/home/user', 'documents', 'report.txt');
    print(p);  // Outputs: /home/user/documents/report.txt
  }

  // 获取路径的基名（basename）
  // basename 函数可以获取路径的基名，即路径的最后一部分。
  static void path3() async {
    var name = path.basename('/home/user/documents/report.txt');
    print(name);  // Outputs: report.txt
  }

  // 分割路径（split）
  // split函数可以分割路径，将路径分解为它的各个部分。
  static void path4() async {
    var parts = path.split('/home/user/documents/report.txt');
    print(parts);  // Outputs: ['/', 'home', 'user', 'documents', 'report.txt']
  }

  // 获取路径的目录名（dirname）
  // dirname 函数可以获取路径的目录名，即除去最后一部分的路径。
  static void path5() async {
    var dir = path.dirname('/home/user/documents/report.txt');
    print(dir);  // Outputs: /home/user/documents
  }

  // 获取路径的扩展名（extension）
  // extension函数可以获取路径的扩展名，即最后一部分中的点（.）之后的部分。
  static void path6() async {
    var ext = path.extension('/home/user/documents/report.txt');
    print(ext);  // Outputs: .txt
  }

  // 判断路径是否为绝对路径（isAbsolute）
  // isAbsolute 函数可以判断路径是否为绝对路径。绝对路径是从文件系统的根目录开始的路径，而相对路径是从当前目录开始的路径。
  static void path7() async {
    var absolute = path.isAbsolute('/home/user/documents/report.txt');
    var relative = path.isAbsolute('report.txt');
    print(absolute);  // Outputs: true
    print(relative);  // Outputs: false
  }
}