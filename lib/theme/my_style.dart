import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 登录名称
TextStyle nicknameTextStyle = TextStyle(fontSize: 62.sp, color: AppTheme.allWhite, fontWeight: FontWeight.bold);
// 登录签名
TextStyle signatureTextStyle = TextStyle(fontSize: 34.sp, color: const Color.fromARGB(255, 228, 225, 225), fontWeight: FontWeight.bold);
// 关注、粉丝、等级 - 数
TextStyle newFollowsTextStyle = TextStyle(fontSize: 48.sp, color: AppTheme.allWhite, fontWeight: FontWeight.bold);
// 关注、粉丝、等级
TextStyle newFollowsSubTextStyle = TextStyle(fontSize: 34.sp, color: const Color.fromARGB(255, 228, 225, 225), fontWeight: FontWeight.bold);
// 歌单列表 名称
TextStyle playlistNameTextStyle = TextStyle(fontSize: 44.sp, fontWeight: FontWeight.bold, color: AppTheme.myLoveSingText);
//歌单列表 副名称
TextStyle playlistNameSubTextStyle = TextStyle(color: AppTheme.myLoveSingSubtext, fontSize: 34.sp);