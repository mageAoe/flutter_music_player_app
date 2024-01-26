import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/app_theme.dart';

class FindView extends StatefulWidget {
  const FindView({ Key? key }) : super(key: key);

  @override
  _FindViewState createState() => _FindViewState();
}

class _FindViewState extends State<FindView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // Theme.of(context).colorScheme.inversePrimary,
          backgroundColor: AppTheme.primary,
          title: const Text('发现', style: TextStyle(color:AppTheme.white)),
        ),
        body: Container(
          child: const Text('find'),
        )
    );
  }
}