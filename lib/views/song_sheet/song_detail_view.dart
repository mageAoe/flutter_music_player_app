// 歌单 - 详情

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_music_player_app/theme/public_style.dart';
import 'package:flutter_music_player_app/utlis/fonts.dart';
import 'package:flutter_music_player_app/api/my_api.dart';
import 'package:flutter_music_player_app/model/playlist_track_all_model.dart';
import 'package:flutter_music_player_app/views/song_sheet/cover_view.dart';


class SongDetailView extends StatefulWidget {
  final int id;
  final String coverImgUrl;
  final String name;
  final String nickname;
  final String avatar;
  final int subscribedCount; // 收藏
  final int commentCount; // 评论
  final int shareCount; //分享
  final String type;
  final String description; // 描述
  final int playCount;
  final String coverName;

  const SongDetailView({
    super.key, 
    required this.id, 
    required this.coverImgUrl,
    required this.name,
    required this.nickname,
    required this.avatar,
    required this.subscribedCount,
    required this.commentCount,
    required this.shareCount,
    required this.type,
    required this.description,
    required this.playCount,
    required this.coverName,
  });

  @override
  State<SongDetailView> createState() => _SongDetailViewState();
}

class _SongDetailViewState extends State<SongDetailView> {
  
  List<Songs> songLists = [];
  bool isLoading = false;
  int offset = 0;
  int limit = 20;
  double safeAreaTop = 0.0;
  ScrollController scrollController = ScrollController();

  // 获取歌单里面的歌曲
  getPlaylistTrackAll() async {
    isLoading = true;
    MyApi.getPlaylistTrackAll('id=${widget.id}&limit=$limit&offset=$offset').then((playlist){
      if(playlist != null){
        // print('playlist: $playlist');
        setState(() {
          // userPlaylistData = playlist;
          songLists.addAll(playlist.songs as Iterable<Songs>);
        });
      }
      isLoading = false;
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
    getPlaylistTrackAll();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        offset++;
        getPlaylistTrackAll();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 获取屏幕信息
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    // 获取刘海屏的高度
    safeAreaTop = mediaQueryData.padding.top;

    return Scaffold(
      extendBodyBehindAppBar: true,
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
              height: 980.h,
              padding: EdgeInsets.fromLTRB(40.w, safeAreaTop + 120.h , 40.w, 40.w),
              decoration: const BoxDecoration(
                gradient: songDetailHeadLinearGradientStyle
              ),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 280.w,
                        height: 280.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: widget.coverImgUrl == '' ? const Text('') : Image.network(widget.coverImgUrl, fit: BoxFit.cover)
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
                                width: 70.w,
                                height: 70.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.network(widget.avatar, fit: BoxFit.cover)
                                ),
                              ),
                              SizedBox(width: 20.w),
                              Row(
                                children: [
                                  Text(widget.nickname, style: TextStyle(fontSize: 35.sp, color: AppTheme.songDetailSubText)),
                                  SizedBox(width: 20.w),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 8.w),
                                    decoration: BoxDecoration(
                                      color: AppTheme.songDetailBtn,
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Row(
                                      children: [
                                       Icon(Icons.add, color: AppTheme.allWhite, size: 28.sp),
                                        SizedBox(width: 10.w),
                                        Text('关注', style: TextStyle(color: AppTheme.allWhite, fontWeight: FontWeight.w700, fontSize: 22.sp))
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 30.h),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 8.w),
                                  decoration: BoxDecoration(
                                    color: AppTheme.songDetailBtnCat,
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Row(
                                  children: [
                                    Text('4.9分', style: TextStyle(fontSize: 28.sp, color: AppTheme.allWhite)),
                                    Icon(Icons.arrow_forward_ios_outlined, size: 28.sp, color: AppTheme.allWhite)
                                  ],
                                )
                              ),
                              SizedBox(width: 20.w),
                              Container(
                                padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 8.w),
                                  decoration: BoxDecoration(
                                    color: AppTheme.songDetailBtnCat,
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Row(
                                  children: [
                                    Text(widget.type, style: TextStyle(fontSize: 28.sp, color: AppTheme.allWhite)),
                                    Icon(Icons.arrow_forward_ios_outlined, size: 28.sp, color: AppTheme.allWhite)
                                  ],
                                )
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30.h),
                    child: InkWell(
                      onTap: (){
                        Navigator.push( 
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const CoverView();
                          }),
                        );
                      },
                      child:  Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(widget.description, style: const TextStyle(color: AppTheme.allWhite), overflow: TextOverflow.ellipsis)
                          ),
                          SizedBox(width: 40.w),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                const Text('封面:周杰伦', style: TextStyle(color: AppTheme.allWhite)),
                                SizedBox(width: 10.w),
                                Icon(Icons.arrow_forward_ios_outlined,size: 34.sp, color: AppTheme.allWhite)
                              ],
                            )
                          )
                          // 封面:周杰伦>
                        ],
                      )
                      ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BtnCatWidget(
                        color: AppTheme.songDetailBtnCat,
                        icon: const Icon(Icons.share, color: AppTheme.allWhite),
                        name: widget.shareCount,
                      ),
                      BtnCatWidget(
                        color: AppTheme.songDetailBtnCat,
                        icon: const Icon(YunMusicFont.message, color: AppTheme.allWhite),
                        name: widget.commentCount,
                      ),
                      BtnCatWidget(
                        color: AppTheme.primary,
                        icon: const Icon(Icons.collections_bookmark_outlined, color: AppTheme.allWhite),
                        name: widget.subscribedCount,
                      ),
                    ]
                  )
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0.0, -30.0),
              child: Container(
                padding: EdgeInsets.only(top: 40.h, bottom: 140.h),
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
                          Text('${songLists.length}首')
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
                    if (songLists.isNotEmpty)
                      ...List.generate(
                        songLists.length,
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
                                      '${songLists[index].name} ${getTns(songLists[index].tns)}', 
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
                                  SizedBox(width: 15.w),
                                  ...List.generate(
                                    songLists[index].ar!.length,
                                    (arIndex) {
                                      if(arIndex == songLists[index].ar!.length - 1){
                                        return Text('${songLists[index].ar![arIndex].name}', style: TextStyle(fontSize: 36.sp,color: AppTheme.myLoveSingSubtext));
                                      }else{
                                        return Text('${songLists[index].ar![arIndex].name} / ', style: TextStyle(fontSize: 36.sp,color: AppTheme.myLoveSingSubtext));
                                      }
                                    }
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                                    child: Text('-', style: TextStyle(fontSize: 36.sp))
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${songLists[index].al!.name}', 
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
                    isLoading ? const Center(child: CircularProgressIndicator(color: AppTheme.primary)) : const Text(''),
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


class BtnCatWidget extends StatelessWidget {
  final Color color;
  final Icon icon;
  final int name;

  const BtnCatWidget({
    required this.color,
    required this.icon,
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(45),
      child: Container(
        padding: EdgeInsets.fromLTRB(70.w, 16.w, 70.w, 16.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          children: [
            // Icon(icon, color: AppTheme.allWhite),
            icon,
            SizedBox(width: 20.w),
            Text('$name', style: const TextStyle(color: AppTheme.allWhite, fontWeight: FontWeight.w700))
          ],
        ),
      )
    );
  }
}