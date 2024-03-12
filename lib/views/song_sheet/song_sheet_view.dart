import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/api/song_sheet_api.dart';
import 'package:flutter_music_player_app/model/playlist_hot_model.dart';
import 'package:flutter_music_player_app/model/top_playlist_model.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter_music_player_app/views/song_sheet/refresh/refresh_page.dart';




class SongSheetView extends StatefulWidget {
  const SongSheetView({ Key? key }) : super(key: key);

  @override
  _SongSheetViewState createState() => _SongSheetViewState();
}

class _SongSheetViewState extends State<SongSheetView> with TickerProviderStateMixin {

  late TabController _tabController;
  PlaylistHotModel playlistHot = PlaylistHotModel();
  TopPlaylistModel topPlaylist = TopPlaylistModel();


  // 热门歌单分类
  void getUserPlaylist() async {
    SongSheetApi.getPlaylistHot().then((playlist){
      if(playlist != null){
        setState(() {
          playlistHot = playlist;
          _tabController = TabController(length: playlistHot.tags!.length, vsync: this);
          _tabController.addListener(() {
            if(_tabController.animation!.value == _tabController.index){
              print('tabController.index:  ${_tabController.index}');
            }
          });
        });
      }
    });
  }

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


  @override
  void initState() {
    getUserPlaylist();
    // _generatePalette();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
            elevation: 0,
            backgroundColor: AppTheme.myBg,
            title: playlistHot.tags == null || playlistHot.tags!.isEmpty ? const Text('')
            : SizedBox(
              height: 65.h,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 100.w),
                    child:TabBar(
                      isScrollable: true,
                      controller: _tabController,
                      indicatorColor: AppTheme.primary,
                      labelColor: Colors.black,
                      indicatorWeight: 2,
                      indicatorPadding: const EdgeInsets.only(left: 5, right: 5),
                      labelStyle: const TextStyle(fontSize: 14),
                      unselectedLabelColor: Colors.grey[400],
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: playlistHot.tags!.map((e) {
                        return Tab(
                          child: Text(e.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold)));
                      }).toList(),
                    )
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      onTap: (){
                        
                      },
                      child: Container(
                        width: 100.w,
                        height: 100.w,
                        color: Colors.white.withOpacity(0.5),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 5.0),
                            child: Container(
                              color: Colors.white.withOpacity(0.2), // 背景颜色及透明度
                              child: const Icon(Icons.keyboard_command_key_outlined, color: Colors.grey)
                            )
                          )
                        ),
                      ),
                    )
                  )
                ],
              ),
            )),
      ),
      body: playlistHot.tags == null || playlistHot.tags!.isEmpty ? 
        const Text('')
        : TabBarView(
          controller: _tabController,
          children: List.generate(
            playlistHot.tags!.length,
            (index) {
              return Container(
                padding: EdgeInsets.only(bottom: 120.h, left: 20.w, right: 20.w),
                color: AppTheme.myBg,
                child: RefreshPage(value:  playlistHot.tags![index].name),
              );
            },
          ),
        ),
    );
  }
}