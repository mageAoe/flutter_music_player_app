import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';

// 发现 - 头部渐变色样式
const LinearGradient headLinearGradientStyle = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.center,
  colors: [
    Color(0xFFeeaeca),
    Color(0xFF94bbe9), 
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 255, 255, 255)
  ],
);


// 我的 歌单详情 - 头部渐变色样式
const LinearGradient mySongDetailHeadLinearGradientStyle = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.center,
  colors: [
    AppTheme.mySongDetailBg,
    AppTheme.mySongDetailBg2, 
  ],
);


// 歌单导航 歌单详情 - 头部渐变色样式
const LinearGradient songDetailHeadLinearGradientStyle = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.center,
  colors: [
    AppTheme.songDetailBg,
    AppTheme.songDetailBg2, 
  ],
);

// 封面页 展示
const LinearGradient coverHeadLinearGradientStyle = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.center,
  colors: [
    AppTheme.songDetailCoverBg,
    AppTheme.songDetailCoverBg2, 
  ],
);