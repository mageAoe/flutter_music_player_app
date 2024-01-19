import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/utlis/fonts.dart';

class TabIconData {
  TabIconData({
    required this.icon,
    this.index = 0,
    required this.selectedImagePath,
    this.isSelected = false,
    this.text = '',
    this.animationController,
  });

  IconData icon;
  IconData selectedImagePath;
  bool isSelected;
  int index;
  String text;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      icon: YunMusicFont.yinle2,
      selectedImagePath: YunMusicFont.faxianxuanze,
      index: 0,
      text: '发现',
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      icon: YunMusicFont.gedan,
      selectedImagePath: YunMusicFont.faxianxuanze,
      index: 1,
      text: '歌单',
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      icon: YunMusicFont.faxian,
      selectedImagePath: YunMusicFont.faxianxuanze,
      index: 2,
      text: 'MV',
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      icon: YunMusicFont.yinle,
      selectedImagePath: YunMusicFont.faxianxuanze,
      index: 3,
      text: '我的',
      isSelected: false,
      animationController: null,
    ),
  ];
}
