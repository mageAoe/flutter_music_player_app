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
    // final ThemeData theme = Theme.of(context);

    return Row(
      children: [
        const Text('00:00',style: TextStyle(color: Colors.white, fontSize: 12)),
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
              value: 0.5,
              min: 0.0,
              // max: duration == 0 ? 1.0 : duration.toDouble(),
              max: 1,
              onChanged: (double value) {
                // setPosition(value.toInt(), byHander: true);
                // widget.onChanged(value);
              },
              onChangeStart: (double value) {
                // isTaping = true;
                // widget.onChangeStart(value);
              },
              // onChangeEnd: (double value) {
              //   isTaping = false;
              //   widget.onChangeEnd(value);
              // },
            ),
          )
        ),
        const Text( '00:00', style: TextStyle(color: Colors.white, fontSize: 12)),
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