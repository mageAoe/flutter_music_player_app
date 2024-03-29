import 'package:flutter/material.dart';

class GradientText extends StatefulWidget {
  late final Widget text;
  late final double offsetX;
  late final Color colorBg;
  late _GradientTextState _state;
  GradientText({super.key, required this.text, this.offsetX = 0.0, this.colorBg = Colors.white});

  @override
  _GradientTextState createState() {
    _state = _GradientTextState();
    return _state;
  }
  // _GradientTextState createState() => _GradientTextState();

  int retryCount = 0;
  void setOffsetX(double offsetX) {
    if (_state == null) {
      print('_LyricPageState is null, retryCount: $retryCount');
      Future.delayed(const Duration(milliseconds: 200)).then((_) {
        retryCount++;
        if (retryCount < 5) {
          setOffsetX(offsetX);
        }
      });
    } else {
      retryCount = 0;
      _state.setOffsetX(offsetX);
    }
  }
}

class _GradientTextState extends State<GradientText> {
  double offsetX = 0.0;

  @override
  void initState() {
    super.initState();
    offsetX = widget.offsetX;
  }

  setOffsetX(offsetX) {
    if (!mounted) return;
    //print('setOffset: $offsetX');
    setState(() {
      this.offsetX = offsetX;
    });
  }

  @override
  Widget build(BuildContext context) {

    const Gradient gradient = LinearGradient(
        colors: [
          Color(0xFFeeaeca),
          Color(0xFF94bbe9), 
        ],
        stops: [0.5, 0.65]); // 设置渐变的起始位置

    /// 参考：https://juejin.im/post/5c860c0a6fb9a049e702ef39
    return ShaderMask(
      // 遮罩层src，通过不同的BlendMode(混合模式)叠在dst上，产生不同的效果。
      shaderCallback: (bounds) {
        //print('bounds: ${bounds.width}');
        return gradient.createShader(
            Offset(-bounds.width / 2 + bounds.width * offsetX, 0.0) &
                bounds.size);
      },
      blendMode: BlendMode.srcIn,
      child: widget.text,
    );
  }
}
