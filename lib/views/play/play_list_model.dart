import 'dart:math';
import 'package:flutter_music_player_app/model/playlist_track_all_model.dart';



enum CycleType { queue, one, random }

class PlayList {
  List<Songs> songList = [];
  int index = 0;
  CycleType cycleType = CycleType.queue;

  setPlayList(List<Songs> list, int currentIndex) {
    songList = list;
    index = currentIndex;
  }

  setCurrentIndex(int index) {
    this.index = index;
  }

  Songs? getCurrentSong() {
    if (index < 0 || index >= songList.length) {
      return null;
    }
    return songList[index];
  }

  Songs? next() {
    if (songList.isEmpty) {
      return null;
    }
    index++;
    if (index >= songList.length) {
      index = 0;
    }
    return songList[index];
  }

  Songs? previous() {
    if (songList.isEmpty) {
      return null;
    }
    index--;
    if (index < 0) {
      index = songList.length - 1;
    }
    return songList[index];
  }

  Songs? randomNext() {
    if (songList.isEmpty) {
      return null;
    }
    int rdmIndex = 0;
    if (songList.length > 1) {
      rdmIndex = Random().nextInt(songList.length);
      if (rdmIndex == index) {
        // 如果和当前index相同，就+1。
        rdmIndex++;
        if (rdmIndex >= songList.length) {
          rdmIndex = 0;
        }
      }
    }
    index = rdmIndex;
    return songList[index];
  }

  int getCurrentIndex() {
    return index;
  }

  void changCycleType() {
    if (cycleType == CycleType.queue) {
      cycleType = CycleType.one;
    } else if (cycleType == CycleType.one) {
      cycleType = CycleType.random;
    } else {
      cycleType = CycleType.queue;
    }
  }

  String getCycleName() {
    String cycleName;
    switch(cycleType) {
      case CycleType.queue: cycleName = '顺序播放';break;
      case CycleType.one: cycleName = '单曲循环';break;
      case CycleType.random: cycleName = '随机播放';break;
    }
    return cycleName;
  }
}
