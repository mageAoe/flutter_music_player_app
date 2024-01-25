import 'package:flutter/material.dart';
import './home_drawer.dart';
import 'package:flutter_music_player_app/app_theme.dart';
import 'package:flutter_music_player_app/utlis/enum_setting.dart';

class DrawerUserController extends StatefulWidget {
  final double drawerWidth;
  final Widget? screenView;
  final DrawerIndex? screenIndex;
  final Function(bool)? drawerIsOpen;
  final Function(DrawerIndex)? onDrawerCall;

  const DrawerUserController({
    super.key,
    this.drawerWidth = 280,
    this.screenView,
    this.onDrawerCall,
    this.screenIndex,
    this.drawerIsOpen,
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
    scrollController!
      .addListener(() {
        if (scrollController!.offset <= 0) {
          if (scrolloffset != 1.0) {
            setState(() {
              scrolloffset = 1.0;
              try {
                widget.drawerIsOpen!(true);
              } catch (_) {}
            });
          }
          iconAnimationController?.animateTo(0.0,
              duration: const Duration(milliseconds: 0),
              curve: Curves.fastOutSlowIn);
        } else if (scrollController!.offset > 0 &&
            scrollController!.offset < widget.drawerWidth.floor()) {
          iconAnimationController?.animateTo(
              (scrollController!.offset * 100 / (widget.drawerWidth)) / 100,
              duration: const Duration(milliseconds: 0),
              curve: Curves.fastOutSlowIn);
        } else {
          if (scrolloffset != 0.0) {
            setState(() {
              scrolloffset = 0.0;
              try {
                widget.drawerIsOpen!(false);
              } catch (_) {}
            });
          }
          iconAnimationController?.animateTo(1.0,
              duration: const Duration(milliseconds: 0),
              curve: Curves.fastOutSlowIn);
        }
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        // physics 能够增加类似物理惯性的效果
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width + widget.drawerWidth,
          child: Row(
            children: [
              // 侧边栏部分
              SizedBox(
                width: widget.drawerWidth,
                height: MediaQuery.of(context).size.height,
                // AnimatedBuilder 来避免整个小部件树的重建，从而提高性能。它是通过将动画的部分包装在一个独立的小部件中，并在每次动画帧发生时进行重建
                child: AnimatedBuilder(
                  animation: iconAnimationController!,
                  builder: (BuildContext context, Widget? child) {
                    return Transform(
                      transform: Matrix4.translationValues(scrollController!.offset, 0.0, 0.0),
                      // child: SizedBox(
                      //   width: widget.drawerWidth,
                      //   height: MediaQuery.of(context).size.height,
                      //   child: const Center(
                      //     child: Text('dada'),
                      //   ),
                      // ),
                      child: HomeDrawer(
                        iconAnimationController: iconAnimationController,
                        screenIndex: widget.screenIndex,
                        callBackIndex: (DrawerIndex indexType) {
                          onDrawerClick();
                          try {
                            widget.onDrawerCall!(indexType);
                          } catch (e) {}
                        }
                      ),
                    );
                  }
                )
              ),
              // 右边首页部分
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

  void onDrawerClick() {
    //if scrollcontroller.offset != 0.0 then we set to closed the drawer(with animation to offset zero position) if is not 1 then open the drawer
    if (scrollController!.offset != 0.0) {
      scrollController?.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      scrollController?.animateTo(
        widget.drawerWidth,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}