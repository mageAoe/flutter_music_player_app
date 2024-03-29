// 控制按钮
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/views/play/widget/icon_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/utlis/fonts.dart';
import 'package:flutter_music_player_app/views/play/widget/current_play_list.dart';
import 'package:audioplayers/audioplayers.dart';




class ControllerBarView extends StatefulWidget {
  // final bool isGoingPlaying;
  final PlayerState? playerState;
  const ControllerBarView({super.key, this.playerState});
  // const ControllerBarView({super.key});


  @override
  State<ControllerBarView> createState() => _ControllerBarViewState();
}

class _ControllerBarViewState extends State<ControllerBarView> {

  // 将要播放和正在播放，用于播放按钮的状态控制。
  // 中途切歌会调用一下stoppted
  // bool isGoingPlaying() {
  //   return widget.playerState != PlayerState.paused;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:60.0.h, bottom:120.0.h, left: 60.0.w, right: 60.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MyIconButton(
              icons: const [
                YunMusicFont.randomXunhuan,
                YunMusicFont.xunhuan,
                YunMusicFont.listXunhuan,
              ],
              iconIndex: 1,
              size: 80.w,
              onPressed: (){},
            ),
            MyIconButton(
              icon: Icons.skip_previous,
              size: 100.w,
              onPressed: (){
                // musicController.playList.changCycleType();
                setState(() {});
              },
            ),
            MyIconButton(
              icons: const [Icons.pause, Icons.play_arrow],
              // iconIndex: isGoingPlaying() ? 0 : 1,
              size: 140.w,
              color: const Color(0xFFebebed),
              onPressed: (){},
            ),
            MyIconButton(
              icon: Icons.skip_next,
              size: 100.w,
              onPressed: (){},
            ),
            MyIconButton(
              icon: YunMusicFont.playList,
              size: 70.w,
              animEnable: false,
              onPressed: (){
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return const CurrentPlayList();
                  }
                );
              },
            )
          ],
        )
    );
  }
}