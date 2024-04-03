// 根据图片取出主要颜色
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter_music_player_app/test/file_demo.dart';
import 'package:flutter_music_player_app/test/directory_demo.dart';
import 'package:flutter_music_player_app/test/file_storage_demo.dart';



  // // 获取图片上的颜色
  // late PaletteGenerator _paletteGenerator;
  // Future<void> _generatePalette() async {
  //   // 从图片路径中获取主要颜色信息
  //   final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
  //     const NetworkImage('https://p1.music.126.net/WgBpC28cUc1Be_wwseby-w==/109951169194614473.jpg?imageView=1&thumbnail=800y800&enlarge=1%7CimageView=1&watermark&type=1&image=b2JqL3c1bkRrTUtRd3JMRGpEekNtOE9tLzMyMjc1MTQ3NjUyL2Q4NGMvMjAyMzExMjExMTM1MS94NzIyMTcwMzEyNzgzMTA0OS5wbmc=&dx=0&dy=0%7Cwatermark&type=1&image=b2JqL3dvbkRsc0tVd3JMQ2xHakNtOEt4LzI3NjEwNDk3MDYyL2VlOTMvOTIxYS82NjE4LzdhMDc5ZDg0NTYyMDAwZmVkZWJmMjVjYjE4NjhkOWEzLnBuZw==&dx=0&dy=0%7CimageView=1&thumbnail=140y140&'),
  //     size: const Size(100, 100), // 图片尺寸，可根据实际情况调整
  //   );

  //  _paletteGenerator = paletteGenerator;
  //  print(paletteGenerator.dominantColor!.color);
  //  print(paletteGenerator.lightVibrantColor);
  //  print(paletteGenerator.vibrantColor);
  // //  return paletteGenerator.dominantColor!.color;
  // }

// 主要用来测试文件操作
class ColorsThiefWidget extends StatefulWidget {
  const ColorsThiefWidget({super.key});

  @override
  State<ColorsThiefWidget> createState() => _ColorsThiefWidgetState();
}

class _ColorsThiefWidgetState extends State<ColorsThiefWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文件操作'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
            ElevatedButton(onPressed: () {
              CacheFile.demo2();
            }, child: const Text('创建文件')),
            ElevatedButton(onPressed: (){
              CacheFile.demo4();
            }, child: const Text('写入文件')),
            ElevatedButton(onPressed: (){
              CacheFile.demo3();
            }, child: const Text('读取文件')),
            ElevatedButton(onPressed: (){
              CacheFile.demo5();
            }, child: const Text('删除文件')),
            ElevatedButton(onPressed: (){
              CacheFile.demo6();
            }, child: const Text('权限')),
            const Divider(),
            ElevatedButton(onPressed: (){
              DirectoryDemo.dir1();
            }, child: const Text('创建目录')),
            ElevatedButton(onPressed: (){
              DirectoryDemo.dir2();
            }, child: const Text('列出目录')),
            ElevatedButton(onPressed: (){
              DirectoryDemo.dir3();
            }, child: const Text('删除目录')),
            const Divider(),
            ElevatedButton(onPressed: (){
              DirectoryDemo.path1();
            }, child: const Text('创建一个路径')),
            ElevatedButton(onPressed: (){
              DirectoryDemo.path2();
            }, child: const Text('连接路径')),
            ElevatedButton(onPressed: (){
              DirectoryDemo.path3();
            }, child: const Text('获取路径的基名')),
            ElevatedButton(onPressed: (){
              DirectoryDemo.path4();
            }, child: const Text('分割路径')),
            ElevatedButton(onPressed: (){
              DirectoryDemo.path5();
            }, child: const Text('获取路径的目录名')),
            ElevatedButton(onPressed: (){
              DirectoryDemo.path6();
            }, child: const Text('获取路径的扩展名')),
            ElevatedButton(onPressed: (){
              DirectoryDemo.path7();
            }, child: const Text('判断路径是否为绝对路径')),
            const Divider(),
            ElevatedButton(onPressed: (){
              FileStrageDemo.path1();
            }, child: const Text('获取临时目录')),
            ElevatedButton(onPressed: (){
              FileStrageDemo.path2();
            }, child: const Text('取应用程序目录')),
            ElevatedButton(onPressed: (){
              FileStrageDemo.path3();
            }, child: const Text('获取外部存储中为应用程序创建的目录')),
            ElevatedButton(onPressed: (){
              FileStrageDemo.path4();
            }, child: const Text('获取应用程序可以放置应用库文件的目录')),
            const Divider(),
            ElevatedButton(onPressed: (){
              FileStrageDemo.downloadMp3();
            }, child: const Text('下载音频文件')),
           ],
          )
        ),
      ),
    );
  }
}