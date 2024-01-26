import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/app_theme.dart';

class MvView extends StatefulWidget {
  const MvView({ Key? key }) : super(key: key);

  @override
  _MvViewState createState() => _MvViewState();
}

class _MvViewState extends State<MvView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // Theme.of(context).colorScheme.inversePrimary,
          backgroundColor: AppTheme.primary,
          title: const Text('MvView', style: TextStyle(color:AppTheme.white)),
        ),
        body: Container(
          child: const Text('MvView'),
        )
    );
  }
}