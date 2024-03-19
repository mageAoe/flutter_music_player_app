
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './play_list_model.dart';
import 'package:flutter_music_player_app/utlis/song_util.dart';
import 'package:flutter_music_player_app/model/playlist_track_all_model.dart';
import 'package:flutter_music_player_app/services/httpClient.dart';





enum AudioPlayerState {
  /// Player is stopped. No file is loaded to the player. Calling [resume] or
  /// [pause] will result in exception.
  STOPPED,

  /// Currently playing a file. The user can [pause], [resume] or [stop] the
  /// playback.
  PLAYING,

  /// Paused. The user can [resume] the playback without providing the URL.
  PAUSED,

  /// The playback has been completed. This state is the same as [STOPPED],
  /// however we differentiate it because some clients might want to know when
  /// the playback is done versus when the user has stopped the playback.
  COMPLETED,
}

class MusicListener {
  Function getName;
  Function onLoading;
  Function onStart;
  Function onPosition;
  Function onStateChanged;
  Function onError;

  MusicListener({
    required this.getName,
    required this.onLoading,
    required this.onStart,
    required this.onPosition,
    required this.onStateChanged,
    required this.onError
  });
}


class MusicController with ChangeNotifier {
  late AudioPlayer audioPlayer;
  // final audioPlayer = AudioPlayer();
  PlayList playList = PlayList();

  PlayerState? _playerState;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  Songs? song;
  Duration? _duration;
  Duration? _position;
  String? url;
  List<MusicListener> musicListeners = [];

  MusicController() {
    print('=======开始初始化播放控制=============');
    init();
  }

  void addMusicListener(MusicListener listener) {
    print('addMusicListener');
    if (!musicListeners.contains(listener)) {
      musicListeners.add(listener);
    }
  }

  void removeMusicListener(MusicListener listener) {
    print('removeMusicListener ${listener.getName()}');
    musicListeners.remove(listener);
  }

  void notifyMusicListeners(Function event) {
    //print('notifyMusicListeners, musicListeners: ${musicListeners.length}');
    for (var listener in musicListeners) {
      event(listener);
    }
  }

  void _initStreams() {
    // 获取音频的总时长
    _durationSubscription = audioPlayer.onDurationChanged.listen((duration) {
      print('duration: $duration');
      _duration = duration;
    });

    // 获取当前播放位置
    _positionSubscription = audioPlayer.onPositionChanged.listen((p) {
      // _position = p.inMilliseconds;
      _position = p;
      notifyMusicListeners((listener) => listener.onPosition(_position));
    });

    // 获取音频播放完成
    _playerCompleteSubscription = audioPlayer.onPlayerComplete.listen((event) {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
    
    // 处理不同的状态
    _playerStateChangeSubscription = audioPlayer.onPlayerStateChanged.listen((state) {
      // _playerState = state;
      print("AudioPlayer onPlayerStateChanged, last state: $_playerState, currentState: $state");
      if (state == PlayerState.playing) {
        _playerState = PlayerState.playing;
        // _duration = audioPlayer.duration.inMilliseconds;
        audioPlayer.getDuration().then((e){
          _duration = e;
        });
        notifyMusicListeners((listener) => listener.onStart(_duration));
        print("AudioPlayer start, duration:$_duration");
      }
    });
  }

  void init() {
    audioPlayer = AudioPlayer();
    // playList = PlayList();

    // _initStreams();
  }

  Future play({String? path}) async {
    if (path == null && url == null) {
      print('Error: empty url!');
      return;
    }
    // 如果参数url为空，或者和之前一样，说明是继续播放当前url
    bool isContinue = path == null || path == url;
    if (!isContinue) {
      url = path;
      if (_playerState != PlayerState.completed) {
        await audioPlayer.stop(); // 注意这儿要用await，不然异步到后面，状态会不对。
      }
      // 不是继续播放，就进入加载状态
      _duration = Duration.zero;
      notifyMusicListeners(
          (listener) => listener.onStateChanged(PlayerState.playing));
    }

    if (path != null && path == url && _playerState == PlayerState.paused) {
      print('播放相同的歌曲，从暂停界面切换过来，继续暂停。 path: $path , url: $url ');
      // pause();
      notifyMusicListeners((listener) => listener.onStart(_duration));
      notifyMusicListeners((listener) => listener.onPosition(_position));
    } else {
      bool isLocal = !url!.startsWith('http');
      if (isLocal) {
        // 本地音乐
        await audioPlayer.play(UrlSource(url!));
      }else{
        String newUrl =  await HttpClient.getRedirectedUrl(url!);
        await audioPlayer.play(UrlSource(newUrl));
      }
    }
  }

  void setPlayList(List<Songs> list, int currentIndex) {
    playList.setPlayList(list, currentIndex);
  }

  // 设置index开始播放音乐
  void playIndex(int index) {
    playList.setCurrentIndex(index);
    startSong();
    notifyListeners();
  }

  Future startSong() async {
    Songs? newSong = getCurrentSong();
    // if (newSong == null) {
    //   return;
    // }

    // 是否将要播放的歌曲就是当前歌曲
    bool isContinue = song?.id == newSong?.id;
    if (!isContinue && newSong != null) {
      song = newSong;
    }

    print("========startSong===============");
    notifyMusicListeners((listener) => listener.onLoading());

    if (isContinue) {
      play(path: url);
    } else {  // 如果是播放新歌，就重新获取播放地址。
      SongUtil.getPlayPath(song!).then((playPath) {
        play(path: playPath);
      });
    }
  }

  Songs? getCurrentSong() {
    return playList.getCurrentSong();
  }



   @override
  void dispose() {
    super.dispose();
    // _positionSubscription.cancel();
    // _audioPlayerStateSubscription.cancel();
    // musicListeners.clear();
    audioPlayer.stop();
  }

}