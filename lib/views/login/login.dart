import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_music_player_app/utlis/fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/widgets/login_widget.dart';
import 'package:flutter_music_player_app/api/login_api.dart';
import 'package:flutter_music_player_app/utlis/show_snack_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({ Key? key }) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController phoneController = TextEditingController(); // 手机号码
  TextEditingController codeController = TextEditingController(); // 验证码

  // 获取验证码
  getVerificationCode() {
    if(phoneController.text == '' || phoneController.text.isEmpty) {
      ShowSnackBar.showSnackBar(context: context, text: '请输入手机号');
      return;
    }
    String pattern = r'^(?:(?:\+|00)86)?1(?:(?:3[\d])|(?:4[5-79])|(?:5[0-35-9])|(?:6[5-7])|(?:7[0-8])|(?:8[\d])|(?:9[1589]))\d{8}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(phoneController.text)) {
      ShowSnackBar.showSnackBarIcon(context: context, text: '请输入正确的手机号');
      return;
    }
    LoginApi.getCode('phone=${phoneController.text}');
  }

  // 登录
  login(){
    // if(codeController.text == '' || codeController.text.isEmpty) {
    //   ShowSnackBar.showSnackBar(context: context, text: '请输入验证码');
    //   return;
    // }
    print('================');
    // LoginApi.getUserInfo('phone=${phoneController.text}&captcha=${codeController.text}');
    LoginApi.getUserInfo('phone=17608454514&captcha=4186');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              Color.fromRGBO(255,237,235, 1), 
              Color.fromARGB(255, 255, 255, 255),
            ],
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 50.h),
                child: const Icon(YunMusicFont.wangyiyunActive, color: AppTheme.primary, size: 75),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(40.w),
                child: Column(
                  children: [
                    Text('网易云音乐', style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.bold, color: const Color.fromRGBO(67,70,84,1))),
                    SizedBox(height: 80.h),
                     PhoneInputWidget(
                      hintText: '请输入手机号',
                      isPrefixIcon: true,
                      isSuffixIcon: true,
                      inputFormatter:  [
                        LengthLimitingTextInputFormatter(11),
                      ],
                      textController: phoneController,
                      onPressed: getVerificationCode,
                    ),
                    SizedBox(height: 40.h),
                    PhoneInputWidget(
                      hintText: '请输入验证码',
                      isPrefixIcon: false,
                      isSuffixIcon: false,
                      inputFormatter:  [
                        LengthLimitingTextInputFormatter(4),
                      ],
                      textController: codeController,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 80.h),
                      width: 680.w,
                      height: 140.h,
                      child: ElevatedButton(
                        onPressed: login,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(AppTheme.primary),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(70.w)
                          ))
                        ),
                        child: Text('登录', style: TextStyle(fontSize: 46.sp))),
                    )
                  ],
                ),
              )
            ),
          ],
        ),
      )
    );
  }
}

