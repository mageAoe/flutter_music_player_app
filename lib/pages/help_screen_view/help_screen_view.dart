import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primary,
          title: const Text('HELP', style: TextStyle(color:AppTheme.white)),
        ),
        body: Container(
        color: AppTheme.background,
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Text('help'),
          ),
        ),
      ),
    );
  }
}