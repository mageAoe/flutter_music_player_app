// 缓存音频文件
// https://bbs.huaweicloud.com/blogs/415705
// https://www.jianshu.com/p/54d6966fa3aa
// https://bbs.huaweicloud.com/blogs/415704
// https://bbs.huaweicloud.com/community/usersnew/id_1614553929114902

import 'dart:io';

class CacheFile{

  // 以下是一个简单的示例，演示如何使用 File 类来创建一个新文件，并向其中写入一些文本
  void demo1() async {
    var file = File('test.txt');
    await file.writeAsString('Hello, Dart!');
  }
  // 创建文件：使用 create 方法可以创建一个新的文件。如果文件已经存在，create 方法不会有任何效果。如果你希望覆盖已经存在的文件，可以给 create 方法传入一个名为 recursive 的参数，将其设为 true。
  void demo2() async {
    var file = File('test.txt');
    await file.create();
  }

  // 读取文件：使用 readAsString 方法可以读取文件的内容，返回一个字符串。如果文件不存在，readAsString 方法会抛出一个异常
  void demo3() async {
    var file = File('test.txt');
    try{
      String contents = await file.readAsString();
      print(contents);
    }catch(e){
      print('文件不存在: $e');
    }
  }
  // 写入文件：使用 writeAsString 方法可以向文件中写入字符串。如果文件不存在，writeAsString 方法会创建一个新的文件。如果文件已经存在，writeAsString 方法会覆盖文件的内容。
  // 跟第一个demo一样的
  void demo4() async {
    var file = File('test.txt');
    await file.writeAsString('Hello, Dart!');
  }
  // 删除文件：使用 delete 方法可以删除一个文件。如果文件不存在，delete 方法不会有任何效果。
  void demo5() async {
    var file = File('test.txt');
    await file.delete();
  }

  // ----------------权限--------------
  // 如果我们没有权限写入 ‘/root/test.txt’ 文件，writeAsString 方法会抛出一个 FileSystemException 异常，然后我们在 catch 语句中捕获这个异常，并打印一个错误消息
  void demo6() async {
    var file = File('/root/test.txt');
    try {
      await file.writeAsString('Hello, Dart!');
    } catch (e) {
      print('Error: $e');
    }
  }

  //-------------目录-------------------
  // 使用 create 方法可以创建一个新的目录。如果目录已经存在，create 方法不会有任何效果。如果你希望创建的目录的父目录不存在，可以给 create 方法传入一个名为 recursive 的参数，将其设为 true
  void dir1() async {
    var directory = Directory('test');
    await directory.create();
  }

  //使用list方法可以列出目录的内容，包括文件和子目录。list 方法返回一个 Stream 对象，我们可以使用 await for 语句来遍历这个 Stream
  void dir2() async {
    var directory = Directory('test');
    await for (var entity in directory.list()) {
      print(entity.path);
    }
  }

  // 使用 delete 方法可以删除一个目录。如果目录不存在，delete 方法不会有任何效果。如果你希望删除的目录包含文件或子目录，可以给 delete 方法传入一个名为 recursive 的参数，将其设为true
  void dir3() async {
    var directory = Directory('test');
    await directory.delete();
  }

}