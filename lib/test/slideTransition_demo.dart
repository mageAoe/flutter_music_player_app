import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // 让程序和手机的刷新频率统一
      duration: const Duration(seconds: 8),
    );
    _controller.animateTo(0.0);
    _controller.addListener(() { });
  }

  @override
  Widget build(BuildContext context) {
    // final introductionanimation =
    //   Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 2))
    //   .chain(CurveTween(curve: Curves.bounceInOut))
    //   .chain(CurveTween(curve: const Interval(0.2, 0.8, curve: Curves.bounceInOut)))  // 当前时间点的百分之二十开始，运动到时间点的百分之八十结束
    //   .animate(_controller);
    // final introductionanimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0.0))
    // .animate(
    //   CurvedAnimation(
    //       parent: _controller,
    //       curve: const Interval(
    //         0.0,
    //         0.2,
    //         curve: Curves.fastOutSlowIn,
    //       ),
    //     )
    // );

    

    final redAnimation =
      Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -1)).animate(CurvedAnimation(
          parent: _controller,
          curve: const Interval(
            0.0,
            0.2,
            curve: Curves.fastOutSlowIn,
          ),
        )
      );

    final blueAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-4, 0)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.2,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('flutter App 动画')),
      body: Stack(
          children: [
            SlideTransition(
              position: redAnimation,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/introduction_animation/introduction_image.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
              ),
            ),
           SlideTransition(
                position: blueAnimation,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 350, maxHeight: 250),
                  child: Image.asset(
                    'assets/introduction_animation/relax_image.png',
                    fit: BoxFit.contain,
                  ),
                ),
            ),
            //   position: introductionanimation,
            //     child:  SingleChildScrollView(
            //       child: Column(
            //         children: [
            //           // SizedBox 里面的图片会影响下面文字的排版
            //           SizedBox(
            //             width: MediaQuery.of(context).size.width,
            //             child: Image.asset(
            //               'assets/introduction_animation/introduction_image.png',
            //               fit: BoxFit.cover,
            //             ),
            //           ),
            //           const SizedBox(
            //             height: 48,
            //           ),
            //          Wrap(
            //           children: [
            //             ElevatedButton(onPressed: (){_controller.forward();}, child: const Text('forward')), // 运动一次
            //             ElevatedButton(onPressed: (){_controller.reverse();}, child: const Text('reverse')), // 逆时针运动一次
            //             ElevatedButton(onPressed: (){_controller.stop();}, child: const Text('stop')),
            //             ElevatedButton(onPressed: (){_controller.reset();}, child: const Text('reset')),
            //             ElevatedButton(onPressed: (){_controller.animateTo(0.2);}, child: const Text('animateTo')),
            //           ],
            //         )
            //         ],
            //       ),
            //     ),
            // ),
                    //  Wrap(
                    //   children: [
                    //     ElevatedButton(onPressed: (){_controller.forward();}, child: const Text('forward')), // 运动一次
                    //     ElevatedButton(onPressed: (){_controller.reverse();}, child: const Text('reverse')), // 逆时针运动一次
                    //     ElevatedButton(onPressed: (){_controller.stop();}, child: const Text('stop')),
                    //     ElevatedButton(onPressed: (){_controller.reset();}, child: const Text('reset')),
                    //     ElevatedButton(onPressed: (){_controller.animateTo(0.2);}, child: const Text('animateTo')),
                    //   ],
                    // )
          ],
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _controller.forward();
          },
          child: const Icon(Icons.add)),
    );
  }
}