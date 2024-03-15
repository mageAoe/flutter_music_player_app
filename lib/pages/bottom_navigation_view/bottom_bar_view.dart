import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_music_player_app/main.dart';
import './tabIcon_data.dart';
// import 'package:flutter_music_player_app/views/play/play_music_view.dart';



class BottomBarView extends StatefulWidget {
  final int index;
  final Function(int index)? changeIndex;
  final Function()? addClick;
  final List<TabIconData>? tabIconsList;

  const BottomBarView({super.key, required this.index, this.changeIndex, this.addClick, this.tabIconsList});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

// _BottomBarViewState 扩展 State<BottomBarView> 也可以说是  _BottomBarViewState 继承 State<BottomBarView>
// 混入 TickerProviderStateMixin
class _BottomBarViewState extends State<BottomBarView> with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationController?.forward(); // 启动动画
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        AnimatedBuilder(
          animation: animationController!,
            builder: (BuildContext context, Widget? child) {
              return Transform(
                 transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                 child: PhysicalShape(
                  color: AppTheme.white,
                  elevation: 16.0,
                  clipper: TabClipper(
                    radius: Tween<double>(begin: 0.0, end: 1.0)
                            .animate(CurvedAnimation(
                                parent: animationController!,
                                curve: Curves.fastOutSlowIn))
                            .value *
                        38.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 62,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                          child: Row(
                            children: [
                              Expanded(
                                child: TabIcons(
                                  index: widget.index,
                                  currentIndex: 0,
                                  tabIconData: widget.tabIconsList?[0],
                                  removeAllSelect: () {
                                    setRemoveAllSelection(
                                        widget.tabIconsList?[0]);
                                    widget.changeIndex!(0);
                                  },
                                )
                              ),
                              Expanded(
                                child: TabIcons(
                                  index: widget.index,
                                  currentIndex: 1,
                                  tabIconData: widget.tabIconsList?[1],
                                  removeAllSelect: () {
                                    setRemoveAllSelection(
                                        widget.tabIconsList?[1]);
                                    widget.changeIndex!(1);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: Tween<double>(begin: 0.0, end: 1.0)
                                      .animate(CurvedAnimation(
                                          parent: animationController!,
                                          curve: Curves.fastOutSlowIn))
                                      .value *
                                  64.0,
                              ),
                              Expanded(
                                child: TabIcons(
                                  index: widget.index,
                                  currentIndex: 2,
                                  tabIconData: widget.tabIconsList?[2],
                                  removeAllSelect: () {
                                    setRemoveAllSelection(
                                        widget.tabIconsList?[2]);
                                    widget.changeIndex!(2);
                                  },
                                ),
                              ),
                              Expanded(
                               child: TabIcons(
                                  index: widget.index,
                                  currentIndex: 3,
                                  tabIconData: widget.tabIconsList?[3],
                                  removeAllSelect: () {
                                    setRemoveAllSelection(
                                        widget.tabIconsList?[3]);
                                    widget.changeIndex!(3);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom,
                      )
                    ],
                  )
                 )
              );
            }
        ),
        PlayerWidget(
          animationController: animationController, 
          addClick: (){
            // Navigator.push( 
            //     context,
            //     MaterialPageRoute(builder: (context) {
            //       return const PlayMusicWidget();
            //     }),
            //   );
          }
        ),
      ]
    );
  }

  void setRemoveAllSelection(TabIconData? tabIconData) {
    if (!mounted) return;
    setState(() {
      widget.tabIconsList?.forEach((TabIconData tab) {
        tab.isSelected = false;
        if (tabIconData!.index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }
}

class TabIcons extends StatefulWidget {
  final TabIconData? tabIconData;
  final int index;
  final int currentIndex;
  final Function()? removeAllSelect;
  const TabIcons({
    super.key,
    this.tabIconData, 
    required this.index,
    required this.currentIndex,
    this.removeAllSelect
  });

  @override
  State<TabIcons> createState() => _TabIconsState();
}

class _TabIconsState extends State<TabIcons> with TickerProviderStateMixin {
  @override
  void initState() {
    widget.tabIconData?.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          widget.removeAllSelect!();
          widget.tabIconData?.animationController?.reverse();
        }
      });
    super.initState();
  }

  void setAnimation() {
    widget.tabIconData?.animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (!widget.tabIconData!.isSelected) {
              setAnimation();
            }
          },
          child: IgnorePointer(
            child: Column(
              children: [
                widget.index == widget.currentIndex ? Icon(
                    size: 28,
                    color: AppTheme.primary,
                    widget.tabIconData?.selectedImagePath,
                ): Icon(
                    size: 28,
                    widget.tabIconData?.icon,
                ),
                Text(widget.tabIconData!.text, style: TextStyle(color: widget.index == widget.currentIndex? AppTheme.primary: null))
              ],
            )
          )
        )
      ),
    );
  }
}


// 中间的播放器组件
class PlayerWidget extends StatelessWidget {
  const PlayerWidget({
    super.key,
    required this.animationController,
    this.addClick
  });

  final AnimationController? animationController;
  final Function()? addClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: SizedBox(
        width: 38 * 2.0,
        height: 38 + 62.0,
        child: Container(
          alignment: Alignment.topCenter,
          color: Colors.transparent,
          child: SizedBox(
            width: 38 * 2.0,
            height: 38 * 2.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              // app 启动时的缩放动画
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: animationController!,
                        curve: Curves.fastOutSlowIn)),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.nearlyDarkBlue,
                    gradient: LinearGradient(
                        colors: [
                          AppTheme.nearlyDarkBlue,
                          HexColor('#6A88E5'),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.nearlyDarkBlue
                              .withOpacity(0.4),
                          offset: const Offset(8.0, 16.0),
                          blurRadius: 16.0),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.white.withOpacity(0.1),
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: addClick,
                      child: const Icon(
                        Icons.add,
                        color: AppTheme.white,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class TabClipper extends CustomClipper<Path> {
  TabClipper({this.radius = 38.0});

  final double radius;

  @override
  Path getClip(Size size) {
    final Path path = Path();

    final double v = radius * 2;
    path.lineTo(0, 0);
    path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180),
        degreeToRadians(90), false);
    path.arcTo(
        Rect.fromLTWH(
            ((size.width / 2) - v / 2) - radius + v * 0.04, 0, radius, radius),
        degreeToRadians(270),
        degreeToRadians(70),
        false);

    path.arcTo(Rect.fromLTWH((size.width / 2) - v / 2, -v / 2, v, v),
        degreeToRadians(160), degreeToRadians(-140), false);

    path.arcTo(
        Rect.fromLTWH((size.width - ((size.width / 2) - v / 2)) - v * 0.04, 0,
            radius, radius),
        degreeToRadians(200),
        degreeToRadians(70),
        false);
    path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(90), false);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TabClipper oldClipper) => true;

  double degreeToRadians(double degree) {
    final double redian = (math.pi / 180) * degree;
    return redian;
  }
}