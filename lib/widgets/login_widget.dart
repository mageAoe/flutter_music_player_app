import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneInputWidget extends StatelessWidget {
  final String hintText;
  final bool isSuffixIcon;
  final bool isPrefixIcon;
  final List<TextInputFormatter>? inputFormatter;
  final TextEditingController? textController;
  final void Function()? onPressed;

  const PhoneInputWidget({
    super.key,
    required this.hintText,
    required this.isSuffixIcon,
    required this.isPrefixIcon,
    this.inputFormatter,
    this.textController,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 680.w,
      height: 140.h,
      child: TextField(
        controller: textController,
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: inputFormatter,
        style: TextStyle(
          fontSize: 50.sp, 
          color: const Color.fromRGBO(67,70,84,1), 
          fontWeight: FontWeight.bold
        ),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
          hintStyle: TextStyle(color: const Color.fromRGBO(135,137,147,1), fontSize: 40.sp),
          border: InputBorder.none,
          filled: true,
          fillColor: const Color.fromRGBO(243,244,246,1),
          // suffixIcon: const Icon(
          //   Icons.clear,
          // ),
          suffixIcon: isSuffixIcon? Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(AppTheme.primary)
              ),
              onPressed: onPressed,
              child: const Text('获取验证码', style: TextStyle(color: AppTheme.allWhite)),
            ),
          ): const Text(''),
          suffixIconColor: Colors.grey,
          // counterText: "0/11",
          enabledBorder: const OutlineInputBorder(
            /*边角*/
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: Color.fromRGBO(243,244,246,1), //边线颜色为黄色
              width: 2, //边线宽度为2
            ),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Color.fromRGBO(243,244,246,1),
            width: 2, 
          )),
          prefixIconColor: Colors.grey,
          // prefixIcon: const Icon(Icons.phone),
          prefixIcon:  isPrefixIcon ? 
          Container(
              padding: EdgeInsets.only(top: 43.h, left:30.w),
              child: Text('+86', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 42.sp))
          ): const Icon(Icons.verified_user_outlined),
        ),
        keyboardType: TextInputType.phone
      ),
    );
  }
}