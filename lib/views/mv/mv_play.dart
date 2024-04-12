import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
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

  late ChewieController _chewieController;
  VideoPlayerController? _videoPlayerController;
  List<Widget> list = [];
  bool startedPlaying = false;


  int position = 0;
  bool isTaping = false; // 是否在手动拖动（拖动的时候进度条不要自己动
  late VideoState _playerState = VideoState.idle;
  late final VoidCallback videoListener;

  bool isFullScreen = true;

  @override
  void initState() {
    super.initState();
    // _play();
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse('http://59.48.102.3:2280/qn-HtkSySDcbKSZLNho5DWYuMVYtWjsUJSk2XG0aLw4.vodkgeyttp8.vod.126.net/cloudmusic/3793/core/de43/667c55c652dbc078566ca5b4447a6e7b.mp4?wsSecret=9edce025f15e66bb97a04c7e23ebf4e9&wsTime=1712654259'),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
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
    print('mv: ${mv!.data!.url}');
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(mv.data!.url!),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    started();
    setState(() {
      _playerState = VideoState.playing;
    });
    // _addControllerListener();
  }

  void _addControllerListener() {
    // videoListener = () {
    //   print('--------------开始播放------------------');
    //   if (!isTaping) {
    //     setState(() {
    //       position = _videoPlayerController!.value.position.inMilliseconds;
    //     });
    //   }

    //   bool isPlaying = _videoPlayerController!.value.isPlaying;
    //   if (_playerState == VideoState.playing && !isPlaying) {
    //     setState(() {
    //       _playerState = VideoState.paused;
    //     });
    //   }
    // };

    setState(() {
      _playerState = VideoState.playing;
    });

    _videoPlayerController!.addListener(() {
      if (startedPlaying && !_videoPlayerController!.value.isPlaying) {
        print('--------------开始播放了---------');
      }
    });
  }

  _getWidgetsByState(){
    List<Widget> children = [];
    if ((_playerState == VideoState.playing ||_playerState == VideoState.paused)) {
      print('VideoState.playing');
      children.add(GestureDetector(
        // onTap: () {
        //   if (isShowButton) {
        //     _showButtons(false);
        //   } else {
        //     _showButtonsAndAutoHide(autoHideTime, clearTimer: true);
        //   }
        // },
        child: Container(
          color: Colors.pink,
          child: AspectRatio(
                  aspectRatio: _videoPlayerController!.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController!),
               )),
      ));

      // if (isShowButton) {
      //   // 全屏按钮
      //   children.add(_buildResizeButton());

      //   // 进度条
      //   children.add(_buildProgressBar());

      //   if (widget.isFullScreen) {}
      // }
    }

    if (_playerState == VideoState.loading) {
      children.add(const Center(child: CircularProgressIndicator()));
    } 
    // else if (isShowButton) {
    //   // 播放按钮
    //   children.add(_bulidPlayButton());
    // }

    return children;
  }

  Future<bool> started() async {
    await _videoPlayerController!.initialize();
    await _videoPlayerController!.play();
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: (index){
          print(index);
        },
        children: [
            Stack(
              // children: [
              //   Center(
              //     child: _getWidgetsByState(),
              //   ),
              //   _buildProgressBar(),
              //   _buildResizeButton()
              // ],
              // children: _getWidgetsByState(),
              children: [
                Center(
                  child: FutureBuilder<bool>(
                    future: started(),
                    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.data ?? false) {
                        return AspectRatio(
                          aspectRatio: _videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController!),
                        );
                      } else {
                        return const Text('waiting for video to load');
                      }
                    },
                  ),
                )
              ]
            ),
        ]
      ),
    );
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
            // widget.onResizePressed(_controller);
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
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        // padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 32.0),
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
    print('---------切换----------');
    setState(() {
      if (isFullScreen) {
        /// 如果是全屏就切换竖屏
        AutoOrientation.portraitAutoMode();

        ///显示状态栏，与底部虚拟操作按钮
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        // SystemChrome.setEnabledSystemUIOverlays(
        //     [SystemUiOverlay.top, SystemUiOverlay.bottom]);
      } else {
        AutoOrientation.landscapeAutoMode();

        ///关闭状态栏，与底部虚拟操作按钮
        // SystemChrome.setEnabledSystemUIOverlays([]);
        // SystemChrome.setPreferredOrientations([
        //     DeviceOrientation.portraitUp,
        // ]);
        SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
      }
      // _startPlayControlTimer(); // 操作完控件开始计时隐藏
    });
  }

   @override
  void dispose() {
    _videoPlayerController!.dispose();
    _chewieController.dispose();
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