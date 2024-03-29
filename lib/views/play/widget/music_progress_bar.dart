import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_music_player_app/views/play/play_controller.dart';




class MusicProgressBar extends StatefulWidget {

  final int duration;
  final int position;

  final Function onChanged;
  final Function onChangeStart;
  final Function onChangeEnd;

  const MusicProgressBar({
    super.key,
    required this.duration,
    required this.position,
    required this.onChangeEnd,
    required this.onChangeStart,
    required this.onChanged
  });

  @override
  State<MusicProgressBar> createState() => _MusicProgressBarState();
}

class _MusicProgressBarState extends State<MusicProgressBar> {

  String get _durationText => widget.duration.toString().split('.').first;
  String get _positionText => widget.position.toString().split('.').first;

  @override
  Widget build(BuildContext context) {
    // 坑很多：Slider注意范围越界的问题，而且duration不能为0.0
    // 歌曲切换的时候duration可能返回0。
    // 播放出错的时候，可能返回负数。
    double position = widget.position < 0 ? 0.0 : widget.position.toDouble();
    double duration = widget.duration <= 0 ? 1.0 : widget.duration.toDouble();
    if (position > duration) {
      position = 0;
    }

    return Row(
      children: [
        Text(_getFormatTime(position.toInt()),style: const TextStyle(color: Colors.white, fontSize: 12)),
        Expanded(
          child: SliderTheme(
            data:  const SliderThemeData(
              trackHeight: 1,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4.0),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
              activeTrackColor: AppTheme.activeTrackColor,
              inactiveTrackColor: AppTheme.inactiveTrackColor,
              thumbColor: AppTheme.thumbColor,
            ), 
            child: Slider.adaptive(
              // value: position.toDouble(),
              value: position,
              min: 0.0,
              // max: duration == 0 ? 1.0 : duration.toDouble(),
              max: duration,
              onChanged: (double value) {
                // setPosition(value.toInt(), byHander: true);
                widget.onChanged(value);
              },
              onChangeStart: (double value) {
                // isTaping = true;
                widget.onChangeStart(value);
              },
              onChangeEnd: (double value) {
              //   isTaping = false;
                widget.onChangeEnd(value);
              },
            ),
          )
        ),
        Text(_getFormatTime(duration.toInt()), style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  String _getFormatTime(int seconds) {
    int minute = seconds ~/ 60;
    int hour = minute ~/ 60;
    String strHour = hour == 0 ? '' : '$hour:';
    return "$strHour${_getTimeString(minute % 60)}:${_getTimeString(seconds % 60)}";
  }

  String _getTimeString(int value) {
    return value > 9 ? "$value" : "0$value";
  }
}