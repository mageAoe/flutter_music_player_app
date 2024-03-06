import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_music_player_app/utlis/network_util.dart';
import 'pages/bottom_navigation_view/bottom_bar_view.dart';
import 'package:flutter_music_player_app/pages/bottom_navigation_view/tabIcon_data.dart';
import 'package:flutter_music_player_app/views/find/find_view.dart';
import 'package:flutter_music_player_app/views/song_sheet/song_sheet_view.dart';
import 'package:flutter_music_player_app/views/mv/mv_view.dart';
import 'package:flutter_music_player_app/views/my/my_view.dart';
import 'package:flutter_music_player_app/services/KeepAliveWrapper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int pageIndex = 0;
  List<Widget> pages = [];
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  final NetworkUtil networkUtil = NetworkUtil();

  final PageController _controller = PageController(initialPage: 0);

   @override
  void initState() {
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;
    // 监听网络变化
    networkUtil.initNetworkListener();
    pages..add(const KeepAliveWrapper(keepAlive: true, child: FindView()))
          ..add(const KeepAliveWrapper(keepAlive: true, child: SongSheetView()))
          ..add(const KeepAliveWrapper(keepAlive: true, child: MvView()))
          ..add(const KeepAliveWrapper(keepAlive: true, child: MyView()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    PageView(
                      controller: _controller,
                      physics: const NeverScrollableScrollPhysics(),
                      children: pages,
                    ),
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
            _controller.jumpToPage(index);
            setState(() {
              pageIndex = index;
            });
          },
        ),
      ],
    );
  }
}