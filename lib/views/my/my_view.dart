import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/utlis/fonts.dart';
import 'package:flutter_music_player_app/widgets/my_widget.dart';
import 'package:flutter_music_player_app/views/login/login.dart';
import 'package:flutter_music_player_app/api/login_api.dart';
import 'package:flutter_music_player_app/model/login_model.dart';
import 'package:flutter_music_player_app/model/user_detail_model.dart';


class MyView extends StatefulWidget {
  const MyView({ Key? key }) : super(key: key);

  @override
  _MyViewState createState() => _MyViewState();
}

class _MyViewState extends State<MyView> with SingleTickerProviderStateMixin {
  UserInfo userInfoData = UserInfo();
  UserDetailModel userDetailData = UserDetailModel();
  List iconsList = [
    {'title': '最近', 'icon': Icons.access_time_outlined},
    {'title': '本地', 'icon': YunMusicFont.xiazaibendi},
    {'title': '云盘', 'icon': YunMusicFont.yunpan},
    {'title': '已购', 'icon': Icons.shopping_bag_outlined},
    {'title': '', 'icon': YunMusicFont.gongnengguanli}
  ];

  // 检查当前的登录状态
  checkLoginStatus() async {
    LoginApi.getUserInfo('').then((userInfo){
      if(userInfo != null){
          userInfoData = userInfo;
          getUserInfo();
        }
    });
  }

  // 获取用户的详情信息
  getUserInfo() async {
    LoginApi.getUserDetail('uid=${userInfoData.account?.id}').then((deatil){
      if(deatil != null){
        print(deatil);
          setState(() {
            userDetailData = deatil;
          });
        }
    });
  }

  @override
  void initState() {
    checkLoginStatus();
    // getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: const Icon(Icons.menu,color: AppTheme.allWhite),
      //   backgroundColor: AppTheme.myLogoBg,
      //   actions: [
      //     IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: AppTheme.allWhite)),
      //     IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_outlined,color: AppTheme.allWhite))
      //   ],
      //   elevation: 0,
      // ),
      body: Column(
          children: [
            // MyNotLoginTopWidget(iconsList: iconsList),
            Container(
              height: 1200.h,
              padding: EdgeInsets.fromLTRB(40.w, 80.w, 40.w, 40.w),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  // scale: 0.8,
                  opacity: 0.8,
                  colorFilter: const ColorFilter.mode(Colors.black12, BlendMode.color),
                  image: NetworkImage('${userDetailData.profile?.backgroundUrl}')
                )
              ),
              // child:BackdropFilter(
              //     filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
              //     child: 
              // ) 
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.menu,color: AppTheme.allWhite),
                      SizedBox(
                        child: Row(
                          children: [
                            IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: AppTheme.primary)),
                            IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_outlined,color: AppTheme.allWhite))
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Transform.translate(
                 offset: const Offset(0.0, -40.0),
                 child: Container(
                  padding: EdgeInsets.all(40.w),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(248,249,253, 1),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('音乐', style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 30.h),
                        Text('近期', style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 30.h),
                        Row(
                          children: [
                            Container(
                              width: 180.w,
                              height: 180.w,
                              decoration: BoxDecoration(
                                color: AppTheme.myLoveSing,
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: const Icon(Icons.heart_broken, color: AppTheme.allWhite, size: 48),
                            ),
                            SizedBox(width: 20.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('我喜欢的音乐', style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold, color: const Color.fromRGBO(67,70,84,1))),
                                Text('0首', style: TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold, color: const Color.fromRGBO(135,137,147,1)))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
              )
              
            )
          ],
        )
    );
  }
}

// 未登录时上面部分
class MyNotLoginTopWidget extends StatelessWidget {
  const MyNotLoginTopWidget({
    super.key,
    required this.iconsList,
  });

  final List iconsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 620.h,
      color: AppTheme.myLogoBg,
      child: Column(
        children: [
         const MyAvatarWidget(),
          MyLoginBtnWidget(onTap: (){
            print('登录');
            Navigator.push( 
              context,
              MaterialPageRoute(builder: (context) {
                return const LoginView();
              }),
            );
          }),
          MyActionsWidget(iconsList: iconsList)
        ],
      ),
    );
  }
}



