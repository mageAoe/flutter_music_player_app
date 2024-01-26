import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/app_theme.dart';

class MyView extends StatefulWidget {
  const MyView({ Key? key }) : super(key: key);

  @override
  _MyViewState createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // Theme.of(context).colorScheme.inversePrimary,
          backgroundColor: AppTheme.primary,
          title: const Text('MyView', style: TextStyle(color:AppTheme.white)),
        ),
        body: Container(
          child: const Text('MyView'),
        )
    );
  }
}