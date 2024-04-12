import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/navigation_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_music_player_app/services/provider.dart';

import 'package:flutter_music_player_app/pages/introduction_view/introduction_view.dart';

import 'package:flutter_music_player_app/test/slideTransition_demo.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_music_player_app/views/play/play_music_view.dart';
import 'package:flutter_music_player_app/utlis/color_thief.dart';
import 'package:flutter_music_player_app/views/play/play_controller.dart';
// import 'package:flutter_music_player_app/views/play/play_controller_demo.dart';


void main() {
  // 设置为透明
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  // 初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 图片缓存
  PaintingBinding.instance.imageCache.maximumSize = 10000;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 300 << 20;
  runApp(_buildProvider());
}


_buildProvider() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<Shop>.value(value: Shop()),
      ChangeNotifierProvider<MusicController>.value(value: MusicController()),
    ],
    child: const MyApp(),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2400),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appMusicTheme,
          routes: {
            '/MainPage': (ctx) => const NavigationHomeScreen(),
          },
          home: const NavigationHomeScreen(),
          // home:  const PlayMusicWidget(),
          // home: const ColorsThiefWidget(),
          // home: const IntroductionAnimationScreen(),
          // home: const MyHomePage(),
        );
      }
    );
  }
}
