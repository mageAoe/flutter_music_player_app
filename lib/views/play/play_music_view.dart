import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_music_player_app/utlis/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/views/play/lyric_view.dart';
import 'package:flutter_music_player_app/views/play/widget/music_progress_bar.dart';
import 'package:flutter_music_player_app/views/play/widget/controller_bar_.dart';
import 'package:flutter_music_player_app/views/play/play_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_music_player_app/model/playlist_track_all_model.dart';
import 'package:flutter_music_player_app/utlis/song_util.dart';
import 'package:flutter_music_player_app/utlis/file_util.dart';




class PlayMusicWidget extends StatefulWidget {
  // const PlayMusicWidget({super.key});

  // @override
  // State<PlayMusicWidget> createState() => _PlayMusicWidgetState();
    //PlayerPage({Key key}) : super(key: key);
  // 将默认构造函数私有化
  const PlayMusicWidget._();

  // 外部跳转统一经过这儿
  static void gotoPlayer(BuildContext context, {List<Songs>? list, int? index}) {
    if (list != null) {
      Provider.of<MusicController>(context, listen: false).setPlayList(list, index!);
    }
    // NavigatorUtil.push(context, PlayerPage._());
    // Navigator.of(context).push(context, PlayerPage._());
    Navigator.push( 
      context,
      MaterialPageRoute(builder: (context) {
        return const PlayMusicWidget._();
      }
    ));
    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     transitionDuration: const Duration(milliseconds: 300),
    //     pageBuilder: (ctx, anim1, anim2) {
    //       return SlideTransition(
    //         position: anim1.drive(Tween<Offset>(
    //           begin: const Offset(0, 1),
    //           end: Offset.zero,
    //         )),
    //         child: const PlayMusicWidget._()
    //       );
    //     },
    //   ),
    // );
  }

  @override
  _PlayMusicWidgetState createState() => _PlayMusicWidgetState();
}

class _PlayMusicWidgetState extends State<PlayMusicWidget> with SingleTickerProviderStateMixin {

  late AnimationController _animController;

  int duration = 0;
  int position = 0; // 单位：毫秒

  Songs? song;
  String? songImage;
  late String artistNames;
  late int imageSize;
  late LyricViewView _lyricPage;
  bool isTaping = false; // 是否在手动拖动进度条（拖动的时候播放进度条不要自己动）
  late PlayerState playerState;

  late MusicController musicController; // 播放控制器
  late MusicListener musicListener; // 播放监听器

    @override
  void initState() {
    print('=============play_music_view================');
    imageSize = ScreenSize.height ~/ 3;
    if (imageSize == 0) {
      imageSize = 680.w.toInt();
    }

    _lyricPage = LyricViewView();

    _animController = AnimationController(duration: const Duration(seconds: 24), vsync: this);

    musicController = Provider.of<MusicController>(context, listen: false);
    initMusicListener();
    musicController.startSong();
    super.initState();
  }

  void initMusicListener() {
    musicListener = MusicListener(
        getName: () => "PlayerPage",
        onLoading: () => _onStartLoading(),
        onStart: (duration) {
          setState(() => this.duration = duration);
        },
        onPosition: (position) {
          //print('MusicListener in PlayerPager, position: $position, duration: $duration');
          if (!isTaping) {
            // 如果手指拖动，就不通过播放器更新状态，以免抖动。
            _lyricPage.updatePosition(position);
            _lyricPage;
            setState(() => this.position = position);
          }
        },
        onStateChanged: (state) {
          print('MusicListener onStateChanged: $state ');
          setState(() => playerState = state);
        },
        onError: (msg) => _onError(msg)
    );

    musicController.addMusicListener(musicListener);
  }

  void _onError(dynamic msg){

  }

  _onStartLoading() {
    print('================_onStartLoading===================');
    song = musicController.getCurrentSong()!;
    // 不要把函数调用放在build之中，不然每次刷新都会调用！！
    songImage = SongUtil.getSongImage(song!, size: imageSize);
    artistNames = SongUtil.getArtistNames(song!);

    print("StartSong: ${song?.name}, imageSize: $imageSize, artistNames： $artistNames");

    // if (songImage.isEmpty) {
    //   MusicDao.getSongDetail(song['id'].toString()).then((songDetail) {
    //     // 异步任务要判断mouted，可能结果返回时界面关闭了。
    //     if (mounted && songDetail != null) {
    //       setState(() {
    //         songImage = SongUtil.getSongImage(songDetail, size: imageSize);
    //       });
    //       song['imageUrl'] = SongUtil.getSongImage(songDetail, size: 0);
    //       print('getSongDetail: $songImage');
    //       FavoriteDB().updateFavorite(song);
    //     }
    //   });
    // }

    setState(() {
      position = 0;
    });

    Future.delayed(const Duration(milliseconds: 200)).then((_) {
      _lyricPage.updateSong(song!);
    });
  }

  Widget _getSongImage(BoxFit fit, {double width = 0, double height = 0}) {
    print("songImage:----------------$songImage");
  return songImage != null
      ? CachedNetworkImage(
          width: imageSize.toDouble() - width,
          height: imageSize.toDouble() - height,
          imageUrl: songImage!,
          fit: fit,
          placeholder: (context, url) => _getPlaceHolder(fit, width: width, height: height),
        )
      : _getPlaceHolder(fit);
  } 

  Widget _getPlaceHolder(BoxFit fit, {double? width, double? height}) {
    return Image.asset(
      'assets/images/music_bg.jpg',
      width: imageSize.toDouble() - width!,
      height: imageSize.toDouble() - height!,
      fit: fit,
    );
  }

  Widget _buildCDCover() {
    return IgnorePointer(
      child:Container(
        width: imageSize.toDouble() + 30.w,
        height: imageSize.toDouble() + 30.w,
        decoration: BoxDecoration(
          border: Border.all(
            width: 32.w,
            color: Colors.black.withOpacity(0.2),
          ),
          shape: BoxShape.circle
        )
      )
    );
  }

    Widget _buildBlackRecord() {
    return IgnorePointer(
      child:Container(
        width: imageSize.toDouble() - 30.w,
        height: imageSize.toDouble() - 30.w,
        decoration: BoxDecoration(
          border: Border.all(
            width: 100.w,
            color: Colors.black,
          ),
          shape: BoxShape.circle
        ),
      )
    );
  }

  Widget _buildProgressIndicator() {
    return SizedBox(
            width: imageSize.toDouble() + 10.0.w,
            height: imageSize.toDouble() + 10.0.w,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Colors.pink
              ),
              strokeWidth: 2.0,
            ));
  }

  Widget _buildMusicCover() {
    return Container(
      margin: EdgeInsets.only(top: 30.0.h, bottom: 20.0.h),
      alignment: Alignment.center,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(90.w),
            child: RotationTransition(
              //设置动画的旋转中心
              alignment: Alignment.center,
              //动画控制器
              turns: _animController,
              child: Hero(
                tag: 'FloatingPlayer',
                // 加边框的效果
                child:ClipOval(
                  child: _getSongImage(BoxFit.fill, width: 160.w, height: 160.w),
                ),
              )
            ),
          ),
          _buildCDCover(),
          Padding(
            padding: EdgeInsets.all(30.w), 
            child: _buildBlackRecord()
          ),
          // _buildProgressIndicator()
        ],
      )
    );
  }

  void _buildAnim() {
    if (!_animController.isAnimating) {
        _animController.forward();
        _animController.repeat();
    }
    if (playerState == PlayerState.playing) {
      if (!_animController.isAnimating) {
        _animController.forward();
        _animController.repeat();
      }
    } else {
      if (_animController.isAnimating) {
        _animController.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // _buildAnim();

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
          centerTitle: true,
          title: Column(
            children: <Widget>[
              song == null ? const Text(''): Text('${song?.name}', style: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.bold)),
              song == null ? const Text(''): Text(artistNames,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14.0, color: Colors.white60),
              )
            ],
          ),
          actions: <Widget>[
              IconButton(onPressed: (){
                // 下载
                print('下载==============${song?.id}');
                FileUtil.downloadMp3(song!.id!);
              }, icon: const Icon(Icons.download, color: AppTheme.allWhite)),
          ],
        ),
      ),
      body: Builder(builder: (BuildContext context) {
        return Stack(children: <Widget>[
          // 背景图片
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _getSongImage(BoxFit.fill),
          ),
          // 高斯模糊遮罩层
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
            child: Opacity(
              opacity: 0.6,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                children: <Widget>[
                  _buildMusicCover(),
                  Expanded(
                    flex: 1,
                    child: _lyricPage, // 歌词
                  ),
                  MusicProgressBar(
                    duration: duration,
                    position: position,
                    onChanged: (double value) {
                      // setState(() {
                      //   position = value.toInt();
                      // });
                      // _lyricPage.updatePosition(position, isTaping: true);
                    },
                    onChangeStart: (double value) {
                      // isTaping = true;
                    },
                    onChangeEnd: (double value) {
                      // isTaping = false;
                      // musicController.seek(value);
                    }
                  ),
                  const ControllerBarView()
                ],
              ),
            )
          )
        ]);
      })
    );
  }
}

