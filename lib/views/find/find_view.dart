import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/app_theme.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_music_player_app/utlis/show_snack_bar.dart';
import 'package:flutter_music_player_app/widgets/find_widget.dart';
import 'package:flutter_music_player_app/api/find_api.dart';
import 'package:flutter_music_player_app/model/banners_model.dart';

// import 'dart:io';
// import 'package:flutter_music_player_app/utlis/file_util.dart';

class FindView extends StatefulWidget {
  const FindView({ super.key });

  @override
  _FindViewState createState() => _FindViewState();
}

class _FindViewState extends State<FindView> with SingleTickerProviderStateMixin {
  List<Banners> banner = <Banners>[];

   @override
  void initState() {
    FindApi.getBanner().then((bannerList) {
        if(bannerList != null){
          setState(() {
            banner = bannerList;
          });
        }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const Icon(Icons.menu, color: Colors.white),
          elevation: 0,
          backgroundColor: AppTheme.primary,
          // backgroundColor: Colors.transparent,
          centerTitle: true,
          title:const SearchWidget(),
          // title: Container(
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [Color(0xFFeeaeca), Color(0xFF94bbe9)],
          //     )
          //   ),
          //   child: const SearchWidget(),
          // ),
      ),
      body: ListView(
          children: [
            SwiperWidget(banner: banner)
          ],
      )
    );
  }
}

