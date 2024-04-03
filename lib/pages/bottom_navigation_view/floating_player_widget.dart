// 中间的播放器组件
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/model/playlist_track_all_model.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_music_player_app/utlis/fonts.dart';
import 'package:flutter_music_player_app/views/play/play_controller.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_music_player_app/views/play/play_music_view.dart';






class FloatingPlayerWidget extends StatefulWidget {
  const FloatingPlayerWidget({super.key});

  @override
  State<FloatingPlayerWidget> createState() => _FloatingPlayerWidgetState();
}


class _FloatingPlayerWidgetState extends State<FloatingPlayerWidget> with TickerProviderStateMixin {

  // 播放器相关
  late AnimationController _animController;
  late MusicController musicController;
  MusicListener? musicListener;
  PlayerState playerState = PlayerState.playing;

  // 进入动画
  AnimationController? animationController;


  @override
  void initState() {
    super.initState();

    _animController = AnimationController(duration: const Duration(seconds: 16), vsync: this);

    animationController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    animationController?.forward(); // 启动动画
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// listen: true，当Provider中notifyListeners时，自动触发更新。
    /// 默认为true，所以在不需要自动触发更新的地方要设为false。
    initMusicListener();
  }

    void initMusicListener() {
    musicListener ??= MusicListener(
          getName: () => "FloatingPlayer",
          onLoading: () {},
          onStart: (duration) {},
          onPosition: (position) {},
          onStateChanged: (state) {
            setState(() => playerState = state);
          },
          onError: (msg) => {});
    musicController = Provider.of<MusicController>(context, listen: true);
    musicController.addMusicListener(musicListener!);
  }

  @override
  void dispose() {
    /// 这儿有个问题，要在后面调用super.dispose
    /// at the time dispose() was called on the mixin, 
    /// that Ticker was still active. 
    /// The Ticker must be disposed before calling super.dispose().
    print('FloatingPlayer dispose');
    _animController.dispose();
    musicController.removeMusicListener(musicListener!);
    super.dispose();
  }

  void _buildAnim() {
    playerState = musicController.getCurrentState();
    if (playerState == PlayerState.playing) {
      if (!_animController.isAnimating) {
        print('开始动画');
        _animController.forward();
        _animController.repeat();
      }
    } else {
      if (_animController.isAnimating) {
        print('结束动画');
        _animController.stop();
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    print('FloatingPlayer build');

    Songs? song = musicController.getCurrentSong();

    _buildAnim();

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: SizedBox(
        width: 38 * 2.0,
        height: 38 + 62.0,
        child: InkWell(
          onTap: () {
            if (song != null) {
              PlayMusicWidget.gotoPlayer(context);
            }
          },
          child: Container(
            alignment: Alignment.topCenter,
            color: Colors.transparent,
            child: SizedBox(
              width: 38 * 2.0,
              height: 38 * 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                // app 启动时的缩放动画
                child: ScaleTransition(
                  alignment: Alignment.center,
                  scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animationController!,curve: Curves.fastOutSlowIn)),
                  child: Container(
                    child: RotationTransition(
                      //设置动画的旋转中心
                      alignment: Alignment.center,
                      //动画控制器
                      turns: _animController,
                      child: Hero(
                        tag: 'FloatingPlayer',
                        child: ClipOval(
                          child: song == null
                            // ? Image.asset(
                            //   'assets/images/music_bg.jpg',
                            // )
                            ? Icon(YunMusicFont.wangyiyunActive, size: 140.sp, color: AppTheme.primary)
                            : CachedNetworkImage(
                              imageUrl: song.al!.picUrl!,
                              placeholder: (context, url) => Image.asset('assets/images/music_bg.jpg'),
                            ) 
                        )
                      )
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}