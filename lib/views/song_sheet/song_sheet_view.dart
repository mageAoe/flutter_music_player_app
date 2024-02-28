import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SongSheetView extends StatefulWidget {
  const SongSheetView({ Key? key }) : super(key: key);

  @override
  _SongSheetViewState createState() => _SongSheetViewState();
}

class _SongSheetViewState extends State<SongSheetView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
    _tabController.addListener(() {
      if(_tabController.animation!.value == _tabController.index){
        print(_tabController.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            title: SizedBox(
              height: 30,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 100.w),
                    child: TabBar(
                      isScrollable: true,
                      controller: _tabController,
                      indicatorColor: AppTheme.primary,
                      labelColor: Colors.black,
                      indicatorWeight: 2,
                      indicatorPadding: const EdgeInsets.only(left: 5, right: 5),
                      labelStyle: const TextStyle(fontSize: 14),
                      unselectedLabelColor: Colors.grey[400],
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: const [
                        Tab(child: Text('关注', style: TextStyle(fontWeight: FontWeight.bold))),
                        Tab(child: Text('热门', style: TextStyle(fontWeight: FontWeight.bold))),
                        Tab(child: Text('视频', style: TextStyle(fontWeight: FontWeight.bold))),
                        Tab(child: Text('娱乐', style: TextStyle(fontWeight: FontWeight.bold))),
                        Tab(child: Text('篮球', style: TextStyle(fontWeight: FontWeight.bold))),
                        Tab(child: Text('唱', style: TextStyle(fontWeight: FontWeight.bold))),
                        Tab(child: Text('跳', style: TextStyle(fontWeight: FontWeight.bold))),
                        Tab(child: Text('rap', style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                  ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 100.w,
                      height: 100.w,
                      color: Colors.white.withOpacity(0.5),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 5.0),
                          child: Container(
                            color: Colors.white.withOpacity(0.1), // 背景颜色及透明度
                            child: const Icon(Icons.keyboard_command_key_outlined)
                          )
                        )
                      ),
                    )
                  )
                ],
              ),
            )),
      ),
      body: TabBarView(controller: _tabController, children: [
        ListView(
            children: const [
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....fghf')),
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....dfg')),
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....dfdg')),
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....111')),
              ListTile(title: Text('关注....222')),
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....')),
              ListTile(title: Text('关注....dfghdfh')),
              ListTile(title: Text('关注....bottom')),
            ],
        ),
        ListView(
          children: const [ListTile(title: Text('热门....'))],
        ),
        ListView(
          children: const [ListTile(title: Text('视频....'))],
        ),
        ListView(
          children: const [ListTile(title: Text('娱乐....'))],
        ),
        ListView(
          children: const [ListTile(title: Text('篮球....'))],
        ),
        ListView(
          children: const [ListTile(title: Text('唱....'))],
        ),
        ListView(
          children: const [ListTile(title: Text('跳....'))],
        ),
        ListView(
          children: const [ListTile(title: Text('rap....'))],
        )
      ]),
    );
  }
}

// class CircleTabIndicator extends Decoration {
//   final BoxPainter _painter;

//   CircleTabIndicator({required Color color, required double radius})
//       : _painter = _CirclePainter(color, radius);
      
//   @override
//   BoxPainter createBoxPainter([VoidCallback? onChanged]) {
//     return _painter;
//   }
// }

// class _CirclePainter extends BoxPainter {
//   final Paint _paint;
//   final double radius;

//   _CirclePainter(Color color, this.radius)
//       : _paint = Paint()
//           ..color = color
//           ..isAntiAlias = true;

//   @override
//   void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
//     final Rect rect = offset & configuration.size!;
//     canvas.drawCircle(rect.center, radius, _paint);
//   }
// }