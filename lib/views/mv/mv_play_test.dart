import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_music_player_app/api/mv_api.dart';
import 'package:flutter_music_player_app/model/mv_url_model.dart';





class MvPlayView extends StatefulWidget {
  final int playId;
  const MvPlayView({super.key, required this.playId});

  @override
  State<MvPlayView> createState() => _MvPlayViewState();
}

class _MvPlayViewState extends State<MvPlayView> {

  late ChewieController _chewieController;
  late VideoPlayerController _videoPlayerController;
  List<Widget> list = [];
  bool startedPlaying = false;

  @override
  void initState() {
    super.initState();

    // _videoPlayerController =
    //     VideoPlayerController.networkUrl(
    //       Uri.parse('https://987638364.hiecheimaetu.com:22443/qn-Z2QRZt81mKSZLNho5DWYuMVYtWjsUJSk2XG0aLw4.vodkgeyttp8.vod.126.net/cloudmusic/3793/core/de43/667c55c652dbc078566ca5b4447a6e7b.mp4?wsSecret=c80af7cef68a54ff15ae2003aae654a1&wsTime=1712557669')
    //       ,
    //       // closedCaptionFile: _loadCaptions(),
    //       videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    //     );
    // _videoPlayerController.addListener(() {
    //   if (startedPlaying && !_videoPlayerController.value.isPlaying) {
    //     Navigator.pop(context);
    //   }
    // });
  print('-------------_initVideo-------------');
    _initVideo();
  }

  _initVideo() async {
    String playAdmin = 'https://720930786.hiecheimaetu.com:22443/qn-FfSu22hyxKSZLNho5DWYuMVYtWjsUJSk2XG0aLw4.vodkgeyttp8.vod.126.net';
    // _videoPlayerController =
    //   VideoPlayerController.networkUrl(
    //     Uri.parse('http://42.80.41.235:2280/qn-FfSu22hyxKSZLNho5DWYuMVYtWjsUJSk2XG0aLw4.vodkgeyttp8.vod.126.net/cloudmusic/3793/core/de43/72e551775eb78bfc7033e98894efa881.mp4?wsSecret=f9c5b8077d6d1f65b605b5e31bcae665&wsTime=1712906993')
    //     ,
    //     videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    // );

    // _videoPlayerController = VideoPlayerController.asset('assets/images/11.mp4');
    // String url = 'https://devfs.369zhy.com/videos/2024-01-10/1724614249327906817_1704866603182247357.mp4';
    String url = 'https://720930786.hiecheimaetu.com:22443/qn-FfSu22hyxKSZLNho5DWYuMVYtWjsUJSk2XG0aLw4.vodkgeyttp8.vod.126.net/cloudmusic/3793/core/de43/72e551775eb78bfc7033e98894efa881.mp4?wsSecret=f9c5b8077d6d1f65b605b5e31bcae665&wsTime=1712906993';
    

    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));

    _videoPlayerController.setLooping(true);
    // _videoPlayerController.addListener(() {
    //   print('addListener');
    // });



    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true
    );
  }

  Future<MvUrlModel?> getMvExclusiveRcmd() async {
    MvUrlModel? mv = await MVApi.getMvUrl('id=${widget.playId}');
    if(mv != null){
      return mv;
    }
    return null;
  }

  Future<bool> started() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.play();
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: (index){
          print(index);
        },
        children: [
          Center(
            child: FutureBuilder<bool>(
              future: started(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.data ?? false) {
                  return AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  );
                } else {
                  // return const CircularProgressIndicator();
                  return const Text('loading.....');
                }
              },
            ),
            // child: SizedBox(
            //   child: AspectRatio(
            //     aspectRatio: 16 / 9,
            //     child: Chewie(
            //       controller: _chewieController,
            //     ),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }

   @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}