import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/model/user_playlist_model.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/utlis/fonts.dart';
import 'package:flutter_music_player_app/widgets/my_widget.dart';
import 'package:flutter_music_player_app/views/login/login.dart';
import 'package:flutter_music_player_app/api/login_api.dart';
import 'package:flutter_music_player_app/model/login_model.dart';
import 'package:flutter_music_player_app/model/user_detail_model.dart';
import 'package:flutter_music_player_app/api/my_api.dart';

class MyView extends StatefulWidget {
  const MyView({ Key? key }) : super(key: key);

  @override
  _MyViewState createState() => _MyViewState();
}

class _MyViewState extends State<MyView> with SingleTickerProviderStateMixin {
  UserInfo userInfoData = UserInfo();
  UserDetailModel userDetailData = UserDetailModel();
  UserPlaylistModel userPlaylistData = UserPlaylistModel();

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
          getUserPlaylist();
        }
    });
  }

  // 获取用户的详情信息
  getUserInfo() async {
    MyApi.getUserDetail('uid=${userInfoData.account?.id}').then((deatil){
      if(deatil != null){
          userDetailData = deatil;
        }
    });
  }

  // 获取用户的歌单
  getUserPlaylist() async {
    MyApi.getUserPlaylist('uid=${userInfoData.account?.id}').then((playlist){
      if(playlist != null){
          setState(() {
            userPlaylistData = playlist;
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
      body: Column(
          children: [
            // MyNotLoginTopWidget(iconsList: iconsList),
            // MyLoginTopWidget(userDetailData: userDetailData, iconsList: iconsList),
            userDetailData.isEmpty() 
            ? MyNotLoginTopWidget(iconsList: iconsList) 
            : MyLoginTopWidget(userDetailData: userDetailData, iconsList: iconsList),
            Expanded(
              flex: 1,
              child: Transform.translate(
                 offset: const Offset(0.0, -40.0),
                 child: Container(
                  padding: EdgeInsets.only(top: 40.h, bottom: 120.h),
                    decoration: const BoxDecoration(
                      color: AppTheme.myBg,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                    ),
                    // child: const MyNotLoginBottomWidget(),
                    child: userPlaylistData.isEmpty()
                    ? const MyNotLoginBottomWidget()
                    : MyLoginBottomWidget(userPlaylistData: userPlaylistData),
                  ),
              )
              
            )
          ],
        )
    );
  }
}

// 登录后展示歌单
class MyLoginBottomWidget extends StatelessWidget {
  const MyLoginBottomWidget({
    super.key,
    required this.userPlaylistData,
  });

  final UserPlaylistModel userPlaylistData;

  @override
  Widget build(BuildContext context) {
    return ListView(
      // shrinkWrap: true,
      padding: EdgeInsets.zero,
      children:  [
        ListTile(
          title: Text('音乐', style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.bold)),
        ),
        ListTile(
          title: Text('近期', style:  TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold)),
        ),
        ...userPlaylistData.playlist!.map((e) {
          return Padding(
            padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network("${e.coverImgUrl}")
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${e.name}', style:  TextStyle(fontSize: 44.sp, fontWeight: FontWeight.bold, color: AppTheme.myLoveSingText)),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Text('歌单 ·', style: TextStyle(color: AppTheme.myLoveSingSubtext, fontSize: 34.sp)),
                      Text('${e.trackCount}首 ·', style: TextStyle(color: AppTheme.myLoveSingSubtext, fontSize: 34.sp)),
                      Text('${e.creator?.nickname}', style: TextStyle(color: AppTheme.myLoveSingSubtext, fontSize: 34.sp)),
                    ],
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

// 登录后的顶部
class MyLoginTopWidget extends StatelessWidget {
  const MyLoginTopWidget({
    super.key,
    required this.userDetailData,
    required this.iconsList,
  });

  final UserDetailModel userDetailData;
  final List iconsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1200.h,
      padding: EdgeInsets.fromLTRB(40.w, 80.w, 40.w, 40.w),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          opacity: 0.8,
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.colorDodge), // color
          image: NetworkImage('${userDetailData.profile?.backgroundUrl}')
        )
      ),
      child: Column(
        children: [
          const TopNavBarWidget(),
          SizedBox(height: 40.h),
          MyAvatarWidget(avatar: userDetailData.profile?.avatarUrl),
          SizedBox(height: 40.h),
          Text('${userDetailData.profile?.nickname }', style: TextStyle(fontSize: 62.sp, color: AppTheme.allWhite, fontWeight: FontWeight.bold)),
          SizedBox(height: 20.h),
          Text('${userDetailData.profile?.signature}', style: TextStyle(fontSize: 34.sp, color: const Color.fromARGB(255, 228, 225, 225), fontWeight: FontWeight.bold)),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text('${userDetailData.profile?.newFollows}', style: TextStyle(fontSize: 48.sp, color: AppTheme.allWhite, fontWeight: FontWeight.bold)),
                  SizedBox(width: 20.w),
                  Text('关注', style: TextStyle(fontSize: 34.sp, color: const Color.fromARGB(255, 228, 225, 225), fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  Text('${userDetailData.profile?.followeds}', style: TextStyle(fontSize: 48.sp, color: AppTheme.allWhite, fontWeight: FontWeight.bold)),
                  SizedBox(width: 20.w),
                  Text('粉丝', style: TextStyle(fontSize: 34.sp, color: const Color.fromARGB(255, 228, 225, 225), fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  Text('Lv.${userDetailData.level}', style: TextStyle(fontSize: 48.sp, color: AppTheme.allWhite, fontWeight: FontWeight.bold)),
                  SizedBox(width: 20.w),
                  Text('等级', style: TextStyle(fontSize: 34.sp, color: const Color.fromARGB(255, 228, 225, 225), fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          SizedBox(height: 30.h),
          MyActionsWidget(iconsList: iconsList)
        ],
      ),
    );
  }
}

// 顶部自定义导航
class TopNavBarWidget extends StatelessWidget {
  const TopNavBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.menu,color: AppTheme.allWhite),
        SizedBox(
          child: Row(
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: AppTheme.allWhite)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_outlined,color: AppTheme.allWhite))
            ],
          ),
        )
      ],
    );
  }
}

// 未登录时底下部分
class MyNotLoginBottomWidget extends StatelessWidget {
  const MyNotLoginBottomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
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
      height: 920.h,
      padding: EdgeInsets.fromLTRB(40.w, 80.w, 40.w, 40.w),
      color: AppTheme.myLogoBg,
      child: Column(
        children: [
         const TopNavBarWidget(),
         SizedBox(height: 40.h),
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



