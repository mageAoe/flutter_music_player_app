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

    _initVideo();
  }

  _initVideo() async {
    _videoPlayerController =
      VideoPlayerController.networkUrl(
        Uri.parse('http://[240e:324:9c02:dda7:384e:fd93:3062:47f]:2280/qn-wYSHdC8tcKSZLNho5DWYuMVYtWjsUJSk2XG0aLw4.vodkgeyttp8.vod.126.net/cloudmusic/JSJiMiQgIiQkYCIiMDAwIQ==/mv/142002/5e87dc1537cf8805e20906a1b388431d.mp4?wsSecret=d6c3160b89972b32910d0d3459257f57&wsTime=1712655772')
        ,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

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
            // child: FutureBuilder<bool>(
            //   future: started(),
            //   builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            //     if (snapshot.data ?? false) {
            //       return AspectRatio(
            //         aspectRatio: _videoPlayerController.value.aspectRatio,
            //         child: VideoPlayer(_videoPlayerController),
            //       );
            //     } else {
            //       return const CircularProgressIndicator();
            //     }
            //   },
            // ),
            child: SizedBox(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
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