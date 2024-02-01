import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/app_theme.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_music_player_app/utlis/show_snack_bar.dart';
import 'package:flutter_music_player_app/widgets/find_widget.dart';
import 'package:flutter_music_player_app/api/find_api.dart';
import 'package:flutter_music_player_app/model/banners_model.dart';

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
        print('=============');
        print(bannerList);
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
          centerTitle: true,
          title: const SearchWidget(),
        ),
        body: ListView(
          children: [
            SwiperWidget(banner: banner)
          ],
        )
    );
  }
}

