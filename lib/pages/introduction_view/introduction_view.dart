/// 引导功能页面

import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/pages/introduction_view/top_back_skip_view.dart';
import 'package:flutter_music_player_app/pages/introduction_view/center_next_button.dart';
import 'package:flutter_music_player_app/pages/introduction_view/components/splash_view.dart';
import 'package:flutter_music_player_app/pages/introduction_view/components/relax_view.dart';
import 'package:flutter_music_player_app/pages/introduction_view/components/care_view.dart';
import 'package:flutter_music_player_app/pages/introduction_view/components/mood_diary_vew.dart';
import 'package:flutter_music_player_app/pages/introduction_view/components/welcome_view.dart';

class IntroductionAnimationScreen extends StatefulWidget {
  const IntroductionAnimationScreen({super.key});

  @override
  State<IntroductionAnimationScreen> createState() => _IntroductionAnimationScreenState();
}


class _IntroductionAnimationScreenState extends State<IntroductionAnimationScreen> with TickerProviderStateMixin {

  AnimationController? _animationController;

  @override
  void initState() {
    // microseconds 微妙   milliseconds 毫秒
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 8));
    // 动画控制器将动画值过渡到 0.0
    _animationController!.animateTo(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      body: ClipRect(
        child: Stack(
          children: [
            SplashView(
              animationController: _animationController!,
            ),
            RelaxView(
              animationController: _animationController!,
            ),
            CareView(
              animationController: _animationController!,
            ),
            MoodDiaryVew(
              animationController: _animationController!,
            ),
            WelcomeView(
              animationController: _animationController!,
            ),
            TopBackSkipView(
              onBackClick: _onBackClick,
              onSkipClick: _onSkipClick,
              animationController: _animationController!,
            ),
            CenterNextButton(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),
          ],
        ),
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: const Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 &&
        _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _signUpClick();
    }
  }

  // 跳转路由
  void _signUpClick() {
    // Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed('/MainPage');
  }
}