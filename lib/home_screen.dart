import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/app_theme.dart';
import 'pages/bottom_navigation_view/bottom_bar_view.dart';
import 'package:flutter_music_player_app/pages/bottom_navigation_view/tabIcon_data.dart';

import 'package:flutter_music_player_app/views/find/find_view.dart';
import 'package:flutter_music_player_app/views/song_sheet/song_sheet_view.dart';
import 'package:flutter_music_player_app/views/mv/mv_view.dart';
import 'package:flutter_music_player_app/views/my/my_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(color: AppTheme.background);
  int pageIndex = 0;

  final List<Widget> _pages = [
    const FindView(),
    const SongSheetView(),
    const MvView(),
    const MyView()
  ];

   @override
  void initState() {
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   // Theme.of(context).colorScheme.inversePrimary,
        //   backgroundColor: AppTheme.primary,
        //   title: Text(widget.title, style: const TextStyle(color:AppTheme.white)),
        // ),
        body: Container(
        color: AppTheme.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Stack(
                  children: <Widget>[
                    _pages[pageIndex],
                    bottomBar(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        // 顶部页面内容
        const Expanded(
          child: SizedBox(),
        ),
        // 下面的导航栏
        BottomBarView(
          tabIconsList: tabIconsList,
          index: pageIndex,
          addClick: () {},
          changeIndex: (int index) {
            setState(() {
              pageIndex = index;
            });
            // if (index == 0 || index == 2) {
            //   animationController?.reverse().then<dynamic>((data) {
            //     if (!mounted) {
            //       return;
            //     }
            //     // setState(() {
            //     //   tabBody =
            //     //       MyDiaryScreen(animationController: animationController);
            //     // });
            //   });
            // } else if (index == 1 || index == 3) {
            //   animationController?.reverse().then<dynamic>((data) {
            //     if (!mounted) {
            //       return;
            //     }
            //     // setState(() {
            //     //   tabBody =
            //     //       TrainingScreen(animationController: animationController);
            //     // });
            //   });
            // }
          },
        ),
      ],
    );
  }
}