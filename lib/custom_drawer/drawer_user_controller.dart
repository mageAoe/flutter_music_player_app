import 'package:flutter/material.dart';
import './home_drawer.dart';
import 'package:flutter_music_player_app/app_theme.dart';

class DrawerUserController extends StatefulWidget {
  final double drawerWidth;
  final Widget? screenView;
  const DrawerUserController({
    super.key,
    this.drawerWidth = 280,
    this.screenView,
  });

  @override
  State<DrawerUserController> createState() => _DrawerUserControllerState();
}

/*
* 关联State子类的实例
* 继承State：StatefulWidget（有状态的控件）逻辑和内部状态
* 继承TickerProviderStateMixin，提供Ticker对象
* TickerProviderStateMixin 初始化 animation 和 Controller的时候需要一个Ticke类型的参数Vsync
*/
class _DrawerUserControllerState extends State<DrawerUserController> with TickerProviderStateMixin {

  ScrollController? scrollController;
  AnimationController? iconAnimationController;
  AnimationController? animationController;

  double scrolloffset = 0.0;

  @override
  void initState() {
    // 创建AnimationController 时间是2000毫秒
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    iconAnimationController = AnimationController(duration: const Duration(milliseconds: 0), vsync: this);
    iconAnimationController ?.animateTo(1.0,duration: const Duration(milliseconds: 0),curve: Curves.fastOutSlowIn);

    scrollController = ScrollController(initialScrollOffset: widget.drawerWidth);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width + widget.drawerWidth,
          child: Row(
            children: [
              SizedBox(
                width: widget.drawerWidth,
                height: MediaQuery.of(context).size.height,
                // AnimatedBuilder 来避免整个小部件树的重建，从而提高性能。它是通过将动画的部分包装在一个独立的小部件中，并在每次动画帧发生时进行重建
                // child: const Text('data'),
                child: AnimatedBuilder(
                  animation: iconAnimationController!,
                  builder: (BuildContext context, Widget? child) {
                    return Transform(
                      transform: Matrix4.translationValues(scrollController!.offset, 0.0, 0.0),
                      child: const HomeDrawer(
                        // screenIndex: widget.screenIndex == null
                        //     ? DrawerIndex.HOME
                        //     : widget.screenIndex,
                        // iconAnimationController: iconAnimationController,
                        // callBackIndex: (DrawerIndex indexType) {
                        //   onDrawerClick();
                        //   try {
                        //     widget.onDrawerCall!(indexType);
                        //   } catch (e) {}
                        // },
                      ),
                    );
                  }
                )
              ),
              SizedBox(
                 width: MediaQuery.of(context).size.width, // 获取与给定BuildContext相关联的屏幕宽度
                 height: MediaQuery.of(context).size.height,
                 child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.6),
                          blurRadius: 24),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      //this IgnorePointer we use as touch(user Interface) widget.screen View, for example scrolloffset == 1 means drawer is close we just allow touching all widget.screen View
                      IgnorePointer(
                        ignoring: scrolloffset == 1 || false,
                        child: widget.screenView,
                      ),
                    ]
                  ),
                 )
              )
            ],
          ),
        )
      ),
    );
  }
}