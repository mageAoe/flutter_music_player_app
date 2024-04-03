import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'dart:math' as math;



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



// 中间的播放器组件
class PlayerWidget extends StatelessWidget {
  const PlayerWidget({
    super.key,
    required this.animationController,
    this.ontap
  });

  final AnimationController? animationController;
  final Function()? ontap;

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
                      onTap: ontap,
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