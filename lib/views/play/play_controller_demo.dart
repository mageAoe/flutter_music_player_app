import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';



class PlayMusicWidget extends StatefulWidget {
  const PlayMusicWidget({super.key});

  @override
  State<PlayMusicWidget> createState() => _PlayMusicWidgetState();
}

class _PlayMusicWidgetState extends State<PlayMusicWidget> {

  // audioPlayer.setVolume(0.5); // 设置音量
  // audioPlayer.setPlaybackRate(playbackRate: 1.5); // 设置速度
  // audioPlayer.setReleaseMode(ReleaseMode.LOOP); // 设置循环模式

  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  final audioPlayer = AudioPlayer();
  bool get _isPlaying => _playerState == PlayerState.playing;
  bool get _isPaused => _playerState == PlayerState.paused;

  String get _durationText => _duration?.toString().split('.').first ?? '';
  String get _positionText => _position?.toString().split('.').first ?? '';

  bool loading = false;

  // 开始播放
  Future<void> _play() async {
    // 预加载音频
    // AudioCache audioCache = AudioCache();

    // await audioCache.load("https://luan.xyz/files/audio/ambient_c_motion.mp3");

    // 将http替换成https
    // String url = "http://m701.music.126.net/20240312154836/b4bd2137ae3666890e8e670";
    // // String url2 = url.replaceRange(0, 4, 'https');
    // String url2 = url.replaceAll('http', 'https');
    // print(url2);

    // 恢复播放
    // await player.resume();
    // setState(() => _playerState = PlayerState.playing);
    // audioPlayer.play(AssetSource("Chipi Chipi Chapa Chapa.mp3"));
    // https://luan.xyz/files/audio/nasa_on_a_mission.mp3
    // https://luan.xyz/files/audio/ambient_c_motion.mp3
    // http://m801.music.126.net/20240312145139/210b76821d2785ec9900e419fcdafdee/jdymusic/obj/wo3DlMOGwrbDjj7DisKw/32712176702/f143/05e6/0754/4c6dbf4bd258b6653ceec125e5903bc0.mp3
    // 需要将http 替换成https

    await audioPlayer.play(UrlSource("https://luan.xyz/files/audio/ambient_c_motion.mp3"));
    setState(() => _playerState = PlayerState.playing );

    // audioPlayer.setAudioContext(ctx)
  }

  // 暂停播放
  Future<void> _pause() async {
    // audioPlayer.pause();
    await audioPlayer.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  // 停止播放
  Future<void> _stop() async {
    // audioPlayer.stop();
    await audioPlayer.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }

  void _initStreams() {
    // 获取音频的总时长
    _durationSubscription = audioPlayer.onDurationChanged.listen((duration) {
      print('duration: $duration');
      setState(() => _duration = duration);
    });

    // 获取当前播放位置
    _positionSubscription = audioPlayer.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );

    // 获取音频播放完成
    _playerCompleteSubscription = audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });
    
    // 处理不同的状态
    _playerStateChangeSubscription = audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  // @override
  // void dispose() {
  //   // audioPlayer.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    // Use initial values from player
    _playerState = audioPlayer.state;
    audioPlayer.getDuration().then(
          (value) => setState(() {
            _duration = value;
          }),
    );
    audioPlayer.getCurrentPosition().then(
          (value) => setState(() {
            _position = value;
          }),
        );
    _initStreams();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text("AudioPlayers Sample"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                key: const Key('play_button'),
                onPressed: _isPlaying ? null : _play,
                iconSize: 48.0,
                icon: const Icon(Icons.play_arrow),
                color: color,
              ),
              IconButton(
                key: const Key('pause_button'),
                onPressed: _isPlaying ? _pause : null,
                iconSize: 48.0,
                icon: const Icon(Icons.pause),
                color: color,
              ),
              IconButton(
                key: const Key('stop_button'),
                onPressed: _isPlaying || _isPaused ? _stop : null,
                iconSize: 48.0,
                icon: const Icon(Icons.stop),
                color: color,
              ),
            ],
          ),
          Slider(
            onChanged: (value) {
              final duration = _duration;
              if (duration == null) {
                return;
              }
              final position = value * duration.inMilliseconds;
              // 跳转到指定位置
              audioPlayer.seek(Duration(milliseconds: position.round()));
            },
            value: (_position != null &&
                    _duration != null &&
                    _position!.inMilliseconds > 0 &&
                    _position!.inMilliseconds < _duration!.inMilliseconds)
                ? _position!.inMilliseconds / _duration!.inMilliseconds
                : 0.0,
          ),
          Text(
            _position != null
                ? '$_positionText / $_durationText'
                : _duration != null
                    ? _durationText
                    : '',
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}