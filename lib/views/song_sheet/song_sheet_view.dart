import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/api/song_sheet_api.dart';
import 'package:flutter_music_player_app/model/playlist_hot_model.dart';
import 'package:flutter_music_player_app/model/top_playlist_model.dart';
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
            title: playlistHot.tags == null || playlistHot.tags!.isEmpty 
            ? const Center(
              child: Text('1211')
              )
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
      body: playlistHot.tags == null || playlistHot.tags!.isEmpty 
      ? const Center(
          child: Text('重新加载')
        )
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