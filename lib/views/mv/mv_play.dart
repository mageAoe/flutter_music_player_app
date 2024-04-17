import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_music_player_app/utlis/fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_music_player_app/api/mv_api.dart';
import 'package:flutter_music_player_app/model/mv_url_model.dart';
import 'package:flutter_music_player_app/views/mv/mv_progress_bar.dart';
import 'package:auto_orientation/auto_orientation.dart';



enum VideoState { idle, loading, playing, paused }


class MvPlayView extends StatefulWidget {
  final int playId;
  const MvPlayView({super.key, required this.playId});

  @override
  State<MvPlayView> createState() => _MvPlayViewState();
}

class _MvPlayViewState extends State<MvPlayView> {

  // late ChewieController _chewieController;
  VideoPlayerController? _videoPlayerController;
  List<Widget> list = [];
  bool startedPlaying = false;


  int position = 0;
  double safeAreaTop = 0.0;
  bool isTaping = false; // 是否在手动拖动（拖动的时候进度条不要自己动
  late VideoState _playerState = VideoState.idle;
  late final VoidCallback videoListener;

  bool isNetError = false;
  bool isHide = false; // 隐藏进度条与头部
  bool isFullScreen = true;
  String playAdmin = 'https://720930786.hiecheimaetu.com:22443/qn-FfSu22hyxKSZLNho5DWYuMVYtWjsUJSk2XG0aLw4.vodkgeyttp8.vod.126.net';

  @override
  void initState() {
    super.initState();
    _play();
    // _videoPlayerController = VideoPlayerController.networkUrl(
    //   Uri.parse('http://42.80.41.235:2280/qn-FfSu22hyxKSZLNho5DWYuMVYtWjsUJSk2XG0aLw4.vodkgeyttp8.vod.126.net/cloudmusic/3793/core/de43/72e551775eb78bfc7033e98894efa881.mp4?wsSecret=f9c5b8077d6d1f65b605b5e31bcae665&wsTime=1712906993'),
    //   videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    // );
  }
  
  Future _play() async {
    // 播放一个新的视频
    if (_videoPlayerController == null) {
      setState(() {
        _playerState = VideoState.loading;
      });
      // 等待初始化
      await _initMVController();
    }
  }

  Future<MvUrlModel?> getMvExclusiveRcmd() async {
    MvUrlModel? mv = await MVApi.getMvUrl('id=${widget.playId}');
    if(mv != null){
      return mv;
    }
    return null;
  }

  // 当播放一个新的视频时，初始化Controller
  _initMVController() async {
    // 获取到视频地址
    MvUrlModel? mv = await getMvExclusiveRcmd();
    if(mv != null){
      // print('mv: ${mv.data!.url}');
      // http://vodkgeyttp8.vod.126.net/cloudmusic/5045/core/d844/6d46dec1aa3d93a1b243abaf157e8c50.mp4?wsSecret=361a65879c84584920d3647f5ff4ab0d&wsTime=1713161520

      List<String> urlArr = mv.data!.url!.split('net');
      // print(urlArr);

      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse('$playAdmin${urlArr[1]}'),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      // _videoPlayerController = VideoPlayerController.asset('assets/test.mp4',
      //   videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      // );

      started();
      _addControllerListener();
    }else{
      setState(() {
        isNetError = true;
      });
    }
  }

  void _addControllerListener() {
    videoListener = () {
      if (startedPlaying && _videoPlayerController!.value.isPlaying) {
        if(_playerState != VideoState.playing){
          setState(() {
            _playerState = VideoState.playing;
          });
        }
        setState(() {
          position = _videoPlayerController!.value.position.inMilliseconds;
        });
      }

      // bool isPlaying = _videoPlayerController!.value.isPlaying;
      // if (_playerState == VideoState.playing && !isPlaying) {
      //   setState(() {
      //     _playerState = VideoState.paused;
      //   });
      // }
    };
    _videoPlayerController!.addListener(videoListener);
  }

  _getWidgetsByState(){
    if ((_playerState == VideoState.playing ||_playerState == VideoState.paused)) {
      // print('_videoPlayerController!.value.aspectRatio: ${_videoPlayerController!.value.aspectRatio}');
      return GestureDetector(
        child: AspectRatio(
          // aspectRatio: 16/9,
          aspectRatio: _videoPlayerController!.value.aspectRatio,
          child: VideoPlayer(_videoPlayerController!),
        ),
      );
    }

    if(isNetError){
      return ElevatedButton(onPressed: (){
        _initMVController();
        setState(() {
          isNetError = false;
        });
      }, child: const Text('重新加载'));
    }

    if (_playerState == VideoState.loading) {
      return Image.asset('assets/images/placeholder.gif');
    }
  }

  Future<bool> started() async {
    await _videoPlayerController!.initialize();
    await _videoPlayerController!.play();
    await _videoPlayerController!.setLooping(true);
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // 获取屏幕信息
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    // 获取刘海屏的高度
    safeAreaTop = mediaQueryData.padding.top;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 24, 25, 1),
      body: PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: (index){
          // print(index);
        },
        children: [
            InkWell(
              onTap: (){
                setState(() {
                  isHide = !isHide;
                });
              },
              child: Stack(
                children: [
                  isHide ? const Text('') : Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: safeAreaTop),
                      child: ListTile(
                        leading: IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.arrow_back_outlined,color: Colors.white)),
                        title: const Text('MV播放',style:TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  Center(
                    child: _getWidgetsByState(),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: _buildPlayOrPause(),
                  ),
                  isHide ? const Text('') : _buildProgressBar(),
                  isHide ? const Text('') : _buildResizeButton()
                ],
              ),
            ),
        ]
      ),
    );
  }

  Widget _buildPlayOrPause(){
    if(isHide || _playerState == VideoState.loading){
      return const Text('');
    }else{
      if (_playerState == VideoState.paused) {
        return IconButton(
          onPressed: (){
            _videoPlayerController!.play();
            setState(() {
              _playerState = VideoState.playing;
            });
          },
          icon: Icon(
            Icons.play_arrow,
            color: Colors.white.withOpacity(0.5),size: 48
          )
        );
      }else{
          return  IconButton(
            onPressed: (){
              _videoPlayerController!.pause();
              setState(() {
                _playerState = VideoState.paused;
              });
            },
            icon: Icon(
              Icons.pause,
              color: Colors.white.withOpacity(0.5),size: 48
            )
          );
      }
    }
  }

  Widget _buildResizeButton() {
    return Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
          icon: Icon(
            isFullScreen
                ? YunMusicFont.fullScreenExit
                : YunMusicFont.fullScreen,
            size: 20.0,
          ),
          color: Colors.white,
          // padding: const EdgeInsets.all(8.0),
          onPressed: () {
            _toggleFullScreen();
          },
        ));
  }

  Widget _buildProgressBar() {
    int duration = 0;
    try {
      duration = _videoPlayerController!.value.duration.inMilliseconds;
      if (position > duration) {
        position = 0;
      }
    } catch (e) {
      print(e);
    }
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 100.0,
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 8),
        child: MyProgressBar(
            duration: duration,
            position: position,
            onChanged: (double value) {
            //   setState(() {
            //     position = value.toInt();
            //   });
            //   // 拖动过程中不要隐藏按钮
            //   _showButtonsAndAutoHide(autoHideTime);
            },
            onChangeStart: (double value) {
              isTaping = true;
            },
            onChangeEnd: (double value) {
              isTaping = false;
              _videoPlayerController!.seekTo(Duration(milliseconds: value.toInt()));
            }),
      ));
  }

  // 全屏切换
  // Future<void> _switchScreen(bool value) async {
  //   print('_switchScreen: $value');
  //   this.isFullScreen = value;
  //   return OrientationPlugin.forceOrientation(isFullScreen
  //           ? DeviceOrientation.landscapeRight
  //           : DeviceOrientation.portraitUp)
  //       .then((_) {
  //     // 全屏时隐藏默认的状态栏，返回时恢复
  //     SystemChrome.setEnabledSystemUIOverlays(
  //         this.isFullScreen ? [] : SystemUiOverlay.values);

  //     setState(() {});
  //   });
  // }

  void _toggleFullScreen() {
    // print('---------切换----------');
    setState(() {
      if (isFullScreen) {
        /// 如果是全屏就切换竖屏
        AutoOrientation.portraitAutoMode();

        ///显示状态栏，与底部虚拟操作按钮
        // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
        // SystemChrome.setEnabledSystemUIOverlays(
        //     [SystemUiOverlay.top, SystemUiOverlay.bottom]);
        isHide = true;
      } else {
        AutoOrientation.landscapeAutoMode();

        ///关闭状态栏，与底部虚拟操作按钮
        // SystemChrome.setEnabledSystemUIOverlays([]);
        SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
        ]);
        isHide = false;
        // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
      }
      isFullScreen = !isFullScreen;
      // _startPlayControlTimer(); // 操作完控件开始计时隐藏
    });
  }

   @override
  void dispose() {
    if(_videoPlayerController != null){
      _videoPlayerController!.dispose();
    }
    // _chewieController.dispose();
    super.dispose();
  }
}


class VideoFullPage extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoFullPage({Key? key, required this.controller}) : super(key: key);

  @override
  _VideoFullPageState createState() => _VideoFullPageState();
}

class _VideoFullPageState extends State<VideoFullPage> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
  ///页面退出时，切换为竖屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: widget.controller.value.aspectRatio,
                    child: VideoPlayer(widget.controller),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, right: 20),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
                    ///点击返回，先切换竖屏，然后退出页面
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                      ]);
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        );
  }
}