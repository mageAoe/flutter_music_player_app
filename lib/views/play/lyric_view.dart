import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/model/Lyric_model.dart';
import 'package:flutter_music_player_app/api/play_api.dart';
import 'package:flutter_music_player_app/model/playlist_track_all_model.dart';
import './lyric_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/views/play/widget/gradient_text.dart';




class LyricViewView extends StatefulWidget {
  bool loading = false;
  late _LyricViewViewState? _state;
  LyricViewView({Key? key}) : super(key: key);

  @override
  _LyricViewViewState createState() {
    print('----------createState------------------');
    _state = _LyricViewViewState();
    loading = true;
    return _state!;
  }

  int updatePositionCount = 0;
  void updatePosition(int position, {isTaping = false}) {
    //print('updatePosition: $position');
    if (_state == null) {
      if (updatePositionCount > 5) {
        return;
      }
      print('_LyricPageState is null, retryCount: $updatePositionCount');
      Future.delayed(const Duration(milliseconds: 200)).then((_) {
        updatePositionCount++;
        updatePosition(position, isTaping: isTaping);
      });
    } else {
      updatePositionCount = 0;
      _state?.updatePosition(position, isTaping: isTaping);
    }
  }

  int updateSongCount = 0;
  void updateSong(Songs song) {
    print('开始请求歌词--------------');
    if (_state == null) {
      if (updateSongCount > 5) {
        return;
      }
      print('_LyricPageState is null, retryCount: $updateSongCount');
        Future.delayed(const Duration(milliseconds: 200)).then((_) {
          updateSongCount++;
          updateSong(song);
        });
      } else {
        updateSongCount = 0;
        _state?.updateSong(song);
    }
  }
}

class _LyricViewViewState extends State<LyricViewView> {

  Songs? song;
  LyricModel? lyric; // 接口请求回来的歌词数据
  late Lyric lyricData; // 处理后的歌词数据 
  final double itemHeight = 100.0.h;
  int visibleItemSize = 7;
  bool success = true;
  bool isItemsEmpty = false;
  bool islyricMask = true;
  /// 在手动拖动时，控制滚动的频率。不然多次动画叠在一起界面卡顿。
  bool isScrolling = false;
  int lastScrollPosition = -1;
  int position = 0;
  int _currentIndex = -1;
  bool isFirst = true;
  late GradientText currentLyricItem;

  late ScrollController _controller;

  @override
  void initState() {

    _controller = ScrollController();
    // _getLyric();
    super.initState();
  }

  // 请求歌词
  void _getLyric(){
    // 开始加载
    setState(() {
      lyric = null;
    });
    print("song!.id!${song!.id!}");
    // 获取歌词
    PlayApi.getLyric(song!.id!).then((value){
      // print(value);
      lyric = value;
      setState(() {
        lyricData = Lyric(lyric!.lrc!.lyric!);
      });
      // print('lyricData: ${lyricData.items}');

    }).catchError((e) {
      setState(() {
        success = false;
      });
    });
  }
  
  void scrollTo(int index) {
    int itemSize = lyricData.items.length;
    // 选中的Index是否超出边界
    /* if (index < 0 || index >= itemSize) {
      return;
    } */

    int offset = (visibleItemSize - 1) ~/ 2;
    int topIndex = index - offset; // 选中元素居中时,top的Index
    int bottomIndex = index + offset;

    setState(() {
      _currentIndex = index;
    });

    // 是否需要滚动(top和bottom到边界时不滚动了)
    if (topIndex < 0 && _controller.offset <= 0) {
      return;
    }
    if (bottomIndex >= itemSize &&
        _controller.offset >= (itemSize - visibleItemSize) * itemHeight) {
      return;
    }

    if (isFirst) {
      // 第一次进入时不用滚动。
      isFirst = false;
      _controller.jumpTo(topIndex * itemHeight);
    } else {
      _controller.animateTo(topIndex * itemHeight,
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  void updateCurrentLyricItem() {
    if (islyricMask &&
        _currentIndex >= 0 &&
        _currentIndex < lyricData.items.length) {
      LyricItem item = lyricData.items[_currentIndex];
      double offsetX; // 遮住的比例
      if (item.duration > 0) {
        offsetX = (position - item.position) / item.duration;
      } else {
        offsetX = 1.0;
      }
      currentLyricItem.setOffsetX(offsetX);
    }
  }

  

  // 根据歌曲播放的位置确定滚动的位置
  void updatePosition(int milliseconds, {isTaping = false}) {
    if (isItemsEmpty) {
      return;
    }

    if (isScrolling) {
      lastScrollPosition = milliseconds;
      return;
    }

    position = milliseconds;

    // 更新单条歌词进度
    updateCurrentLyricItem();

    int index = getIndexByTime(position);
    //print("update index : $_index, currentIndex: $_currentIndex");
    if (index != _currentIndex) {
      _currentIndex = index;
      scrollTo(_currentIndex);

      if (isTaping) {
        // 如果是手动拖动，就要控制滚动的频率。
        delayNextScroll();
      }
    }
  }

  /// 比较播放位置和歌词时间戳，获取当前是哪条歌词。
  /// milliseconds 当前播放位置，单位：毫秒
  int getIndexByTime(int milliseconds) {
    if (lyric == null ||
        lyricData.items.isEmpty ||
        lyricData.items[0].position > milliseconds) {
      // 刚开始未选中的情况。
      return -1;
    }

    // 选取比较的范围，不用每次都从头遍历。
    int start;
    int end;
    if (_currentIndex <= 1 || _currentIndex >= lyricData.items.length) {
      start = 0;
      end = lyricData.items.length;
    } else if (milliseconds >= lyricData.items[_currentIndex - 1].position) {
      start = _currentIndex;
      end = lyricData.items.length;
    } else {
      start = 0;
      end = _currentIndex;
    }

    int index = start;
    for (; index < end - 1; index++) {
      if (lyricData.items[index + 1].position >= milliseconds) {
        break;
      }
    }
    return index;
  }

  Widget _buildInfo(String msg){
    isItemsEmpty = true;
    return Center(
      child: Text(msg, style: TextStyle(color: Colors.white30, fontSize: 45.0.sp))
    );
  }

  @override
  Widget build(BuildContext context) {

    if (!success) {
      return _buildInfo('歌词加载失败');
    } else if (lyric == null) {
      return _buildInfo('歌词加载中...');
    } else if (lyricData.items.isEmpty) {
      return _buildInfo('...纯音乐，无歌词...');
    } else {
      isItemsEmpty = false;
    }

    return Container(
      alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: itemHeight * visibleItemSize),
          child: CustomScrollView(
            controller: _controller, 
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      alignment: Alignment.center,
                      height: itemHeight,
                      child: Text(lyricData.items[index].content, style: const TextStyle(color: Colors.white))
                    );
                  },
                  childCount: lyricData.items.length,
                )
              ),
            ]
          )
        )
    );
  }

  void delayNextScroll() {
    isScrolling = true;
    Future.delayed(const Duration(milliseconds: 200)).then((re) {
      isScrolling = false;
      if (lastScrollPosition != -1) {
        updatePosition(lastScrollPosition, isTaping: true);
        lastScrollPosition = -1;
      }
    });
  }

  void updateSong(Songs value) {
    if (song != value) {
      song = value;
      _getLyric();
    }
  }
}