import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/model/user_playlist_model.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/utlis/fonts.dart';
import 'package:flutter_music_player_app/widgets/my_widget.dart';
import 'package:flutter_music_player_app/api/login_api.dart';
import 'package:flutter_music_player_app/model/login_model.dart';
import 'package:flutter_music_player_app/model/user_detail_model.dart';
import 'package:flutter_music_player_app/api/my_api.dart';
import 'package:flutter_music_player_app/services/provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';


class MyView extends StatefulWidget {
  const MyView({ Key? key }) : super(key: key);

  @override
  _MyViewState createState() => _MyViewState();
}

class _MyViewState extends State<MyView> with SingleTickerProviderStateMixin {
  UserInfo userInfoData = UserInfo();
  UserDetailModel userDetailData = UserDetailModel();
  UserPlaylistModel userPlaylistData = UserPlaylistModel();


  bool showSubHeaderTabs = false;
  ScrollController scrollController = ScrollController();
  GlobalKey globak = GlobalKey();
  double gkPosition = 0.0;
  double safeAreaTop = 0.0; // 获取刘海屏的高度



  List iconsList = [
    {'title': '最近', 'icon': Icons.access_time_outlined},
    {'title': '本地', 'icon': YunMusicFont.xiazaibendi},
    {'title': '云盘', 'icon': YunMusicFont.yunpan},
    {'title': '已购', 'icon': Icons.shopping_bag_outlined},
    {'title': '', 'icon': YunMusicFont.gongnengguanli}
  ];

  // 检查当前的登录状态
  void checkLoginStatus() async {
    LoginApi.getUserInfo('').then((userInfo){
      if(userInfo != null){
          userInfoData = userInfo;
          getUserInfo();
          getUserPlaylist();
      }else{
        setIsMyLoading(false);
      }
    });
  }

  // 获取用户的详情信息
  void getUserInfo() async {
    MyApi.getUserDetail('uid=${userInfoData.account?.id}').then((deatil){
      if(deatil != null){
          userDetailData = deatil;
        }
    });
  }

  // 获取用户的歌单
  void getUserPlaylist() async {
    MyApi.getUserPlaylist('uid=${userInfoData.account?.id}').then((playlist){
      if(playlist != null){
        setState(() {
          userPlaylistData = playlist;
        });
      }
      print('playlist: $playlist');
      setIsMyLoading(false);
    });
  }

  void setIsMyLoading(bool value){
    // get access to shop
    final shop = context.read<Shop>();
    // set shop
    shop.setIsMyLoading(value);
  }

  @override
  void initState() {
    checkLoginStatus();
    // getUserInfo();

    // 监听滑动
    scrollController.addListener(() {
      if(gkPosition ==0){
        // 获取第二屏的高度 距离顶部的高度
        RenderBox box = globak.currentContext!.findRenderObject() as RenderBox;
        gkPosition = box.localToGlobal(Offset.zero).dy + scrollController.position.pixels - (safeAreaTop + 120.h);
        // print(gkPosition); // 393.7142857142857 总高度
      }

      if(scrollController.position.pixels > gkPosition ){
        if(showSubHeaderTabs == false){
          setState(() {
            showSubHeaderTabs = true;
          });
        }
      }else if(scrollController.position.pixels >0 && scrollController.position.pixels < gkPosition){
        if(showSubHeaderTabs == true){
          setState(() {
            showSubHeaderTabs = false;
          });
        }
      }
    });

    super.initState();
  }

  // 908783043

  @override
  Widget build(BuildContext context) {
    // 获取状态 下面两个方法都可以提取shop里面的数据
    final shop = context.read<Shop>();
    // final Shop userState = Provider.of<Shop>(context);
    final isMyLoading = shop.isMyLoading;
    // print(userState.isMyLoading);

    // 获取屏幕信息
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    // 获取刘海屏的高度
    safeAreaTop = mediaQueryData.padding.top;

    return Scaffold(
      extendBodyBehindAppBar: true, // 扩展body区域到AppBar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.h),
        child: AppBar(
          centerTitle: true,
          backgroundColor: showSubHeaderTabs?  const Color.fromARGB(255, 214, 201, 201) : Colors.white.withOpacity(0.0),
          elevation: 0,
          leading: const Icon(Icons.menu,color: AppTheme.allWhite),
          actions: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: AppTheme.allWhite)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_outlined,color: AppTheme.allWhite))
          ],
        ),
      ),
      body: Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    // child: MyNotLoginTopWidget(iconsList: iconsList,safeAreaTop: safeAreaTop),
                   child: Skeletonizer(
                      enabled: isMyLoading,
                      child: userDetailData.isEmpty()? MyNotLoginTopWidget(iconsList: iconsList) : MyLoginTopWidget(userDetailData: userDetailData, iconsList: iconsList)
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0.0, -40.0),
                    child: Container(
                      key: globak, // 绑定一个key
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 40.h, bottom: 120.h),
                      decoration: const BoxDecoration(
                        color: AppTheme.myBg,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                      ),
                      child: userPlaylistData.isEmpty()
                      ? const MyNotLoginBottomWidget()
                      : MyLoginBottomWidget(userPlaylistData: userPlaylistData, userDetailData: userDetailData),
                    ),
                  ),
                ],
              ),
            ),
            showSubHeaderTabs
            ? Positioned(
              left: 0,
              top: safeAreaTop + 120.h,
              right: 0,
              child: Container(
                color: AppTheme.myBg,
                child: Column(
                  children: [
                    ListTile(
                      title: Text('音乐', style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.bold)),
                    ),
                    ListTile(
                      title: Text('近期', style:  TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ): const Text('')
          ],
        ),
    );
  }
}



