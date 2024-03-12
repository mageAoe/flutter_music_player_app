import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_music_player_app/theme/public_style.dart';
import 'package:flutter_music_player_app/utlis/fonts.dart';
import 'package:flutter_music_player_app/api/my_api.dart';
import 'package:flutter_music_player_app/model/playlist_track_all_model.dart';


class SongDetailView extends StatefulWidget {
  final int id;
  final String coverImgUrl;
  final String name;
  final String? nickname;
  final String? avatar;

  const SongDetailView({
    super.key, 
    required this.id, 
    required this.coverImgUrl,
    required this.name,
    required this.nickname,
    required this.avatar
  });

  @override
  State<SongDetailView> createState() => _SongDetailViewState();
}

class _SongDetailViewState extends State<SongDetailView> {
  
  PlaylistTrackAllModel userPlaylistData = PlaylistTrackAllModel();
  int offset = 0;
  int limit = 20;
  double safeAreaTop = 0.0;
  ScrollController scrollController = ScrollController();

  List btnList = [
    {'name': '分享', 'icon': Icons.share },
    {'name': '评论', 'icon': YunMusicFont.message },
    {'name': '收藏', 'icon': Icons.collections_bookmark_outlined },
  ];

  // 获取歌单里面的歌曲
  checkLoginStatus() async {
    MyApi.getPlaylistTrackAll('id=${widget.id}&limit=$limit&offset=$offset').then((playlist){
      if(playlist != null){
        print('playlist: $playlist');
          setState(() {
            userPlaylistData = playlist;
          });
        }
    });
  }

  String getTns(List<String>? tns){
    if(tns != null){
      return '(${tns[0]})';
    }else{
      return '';
    }
  }


  @override
  void initState() {
    print('widget.id:  ${widget.id}');
    checkLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 获取屏幕信息
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    // 获取刘海屏的高度
    safeAreaTop = mediaQueryData.padding.top;

    return Scaffold(
      extendBodyBehindAppBar: true, // 扩展body区域到AppBar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.h),
        child: AppBar(
          backgroundColor:  Colors.white.withOpacity(0.0),
          elevation: 0,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back,color: AppTheme.allWhite)),
          title: Text('歌单', style: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.bold)),
          actions: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: AppTheme.allWhite)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_outlined,color: AppTheme.allWhite))
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 890.h,
              padding: EdgeInsets.fromLTRB(40.w, safeAreaTop + 120.h , 40.w, 40.w),
              decoration: const BoxDecoration(
                gradient: mySongDetailHeadLinearGradientStyle
              ),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 330.w,
                        height: 330.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(widget.coverImgUrl, fit: BoxFit.cover)
                        ),
                      ),
                      SizedBox(width: 30.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 480.w, // 80 + 30 + 330 = 480
                            child: Text(
                              widget.name, 
                              softWrap: true,
                              style: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.bold, color: AppTheme.allWhite)
                          ),
                          ),
                          
                          SizedBox(height: 30.h),
                          Row(
                            children: [
                              SizedBox(
                                width: 80.w,
                                height: 80.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.network("${widget.avatar}", fit: BoxFit.cover)
                                ),
                              ),
                              SizedBox(width: 30.h),
                              Row(
                                children: [
                                  Text(widget.nickname!, style: TextStyle(fontSize: 35.sp, color: AppTheme.mySongDeatilSamllSize)),
                                  Icon(Icons.arrow_forward_ios_outlined, size: 35.sp, color: AppTheme.mySongDeatilSamllSize)
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: btnList.map((e){
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(60.w, 20.w, 60.w, 20.w),
                          decoration: BoxDecoration(
                            color: AppTheme.mySongDeatilBtnBg,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              Icon(e['icon'], color: AppTheme.allWhite),
                              SizedBox(width: 20.w),
                              Text('${e['name']}', style: const TextStyle(color: AppTheme.allWhite, fontWeight: FontWeight.w700))
                            ],
                          ),
                        )
                      );
                    }).toList()
                  )
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0.0, -30.0),
              child: Container(
                // width: double.infinity,
                padding: EdgeInsets.only(top: 40.h, bottom: 120.h),
                decoration: const BoxDecoration(
                  color: AppTheme.myBg,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.play_circle_rounded, color: AppTheme.primary),
                      title: Row(
                        children: [
                          const Text('播放全部'),
                          Text('${userPlaylistData.songs?.length}首')
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(YunMusicFont.yinle, color: Colors.black),
                          SizedBox(width: 40.w),
                          const Icon(Icons.download, color: Colors.black),
                          SizedBox(width: 40.w),
                          const Icon(Icons.menu_open_sharp, color: Colors.black)
                        ],
                      ),
                    ),
                    if (userPlaylistData.songs != null && userPlaylistData.songs!.isNotEmpty)
                      ...List.generate(
                        userPlaylistData.songs!.length,
                        (index) => ListTile(
                          leading: Text('${index + 1}'), // 递增的数字
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                textDirection: TextDirection.ltr,
                                textBaseline: TextBaseline.alphabetic,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${userPlaylistData.songs![index].name} ${getTns(userPlaylistData.songs![index].tns)}', 
                                      overflow: TextOverflow.ellipsis, maxLines: 1
                                    )
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.h),
                              Row(
                                textBaseline: TextBaseline.alphabetic,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(YunMusicFont.love, size: 32.w, color: AppTheme.primary),
                                  SizedBox(width: 15.w),
                                  ...List.generate(
                                    userPlaylistData.songs![index].ar!.length,
                                    (arIndex) {
                                      if(arIndex == userPlaylistData.songs![index].ar!.length - 1){
                                        return Text('${userPlaylistData.songs![index].ar![arIndex].name}', style: TextStyle(fontSize: 36.sp,color: AppTheme.myLoveSingSubtext));
                                      }else{
                                        return Text('${userPlaylistData.songs![index].ar![arIndex].name} / ', style: TextStyle(fontSize: 36.sp,color: AppTheme.myLoveSingSubtext));
                                      }
                                    }
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                                    child: Text('-', style: TextStyle(fontSize: 36.sp))
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${userPlaylistData.songs![index].al!.name}', 
                                      style: TextStyle(fontSize: 36.sp,color: AppTheme.myLoveSingSubtext), overflow: TextOverflow.ellipsis)
                                  )
                                ],
                              )
                            ],
                          ),
                          trailing: const Icon(Icons.more_vert_outlined),
                        ),
                      )
                    else
                      Container(
                        margin: EdgeInsets.only(top: 120.h),
                        child: Center(
                          child: Text(
                            '暂无歌曲',
                            style: TextStyle(fontSize: 44.sp, fontWeight: FontWeight.bold, color: AppTheme.myLoveSingText),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}