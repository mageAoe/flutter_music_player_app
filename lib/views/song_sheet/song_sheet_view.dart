import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/app_theme.dart';

class SongSheetView extends StatefulWidget {
  const SongSheetView({ Key? key }) : super(key: key);

  @override
  _SongSheetViewState createState() => _SongSheetViewState();
}

class _SongSheetViewState extends State<SongSheetView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // Theme.of(context).colorScheme.inversePrimary,
          backgroundColor: AppTheme.primary,
          title: const Text('SongSheetView', style: TextStyle(color:AppTheme.white)),
        ),
        body: Container(
          child: const Text('SongSheetView'),
        )
    );
  }
}