// 控制按钮
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/views/play/widget/icon_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/utlis/fonts.dart';




class ControllerBarView extends StatefulWidget {
  const ControllerBarView({super.key});

  @override
  State<ControllerBarView> createState() => _ControllerBarViewState();
}

class _ControllerBarViewState extends State<ControllerBarView> {



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
              icon: Icons.play_circle_fill,
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
              onPressed: (){},
            )
          ],
        )
    );
  }
}