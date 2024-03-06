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
import 'package:flutter_music_player_app/views/song_sheet/song_detail_view.dart';
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
          // backgroundColor: Colors.white.withOpacity(0.0),
          backgroundColor: showSubHeaderTabs?  const Color.fromARGB(255, 214, 201, 201) : Colors.white.withOpacity(0.0),
          elevation: 0,
          leading: const Icon(Icons.menu,color: AppTheme.allWhite),
          actions: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: AppTheme.allWhite)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_outlined,color: AppTheme.allWhite))
          ],
        ),
      ),
      body: Skeletonizer(
        enabled: isMyLoading,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    // child: MyNotLoginTopWidget(iconsList: iconsList,safeAreaTop: safeAreaTop),
                   child: userDetailData.isEmpty() && isMyLoading
                    ? MyNotLoginTopWidget(iconsList: iconsList) 
                    : MyLoginTopWidget(userDetailData: userDetailData, iconsList: iconsList),
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
      )
    );
  }
}

// 登录后展示歌单
class MyLoginBottomWidget extends StatelessWidget {
  const MyLoginBottomWidget({
    super.key,
    required this.userPlaylistData,
    required this.userDetailData
  });

  final UserDetailModel userDetailData;
  final UserPlaylistModel userPlaylistData;

  @override
  Widget build(BuildContext context) {
    return Column(
      // shrinkWrap: true,
      // padding: EdgeInsets.zero,
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
            child: InkWell(
              onTap: (){
                Navigator.push( 
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SongDetailView(
                      id: e.id!,
                      coverImgUrl: e.coverImgUrl!,
                      name: e.name!,
                      nickname: e.creator?.nickname,
                      avatar: userDetailData.profile?.avatarUrl
                    );
                  }),
                );
              },
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network("${e.coverImgUrl}")
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${e.name}', 
                      overflow: TextOverflow.ellipsis,
                      style:  TextStyle(fontSize: 44.sp, fontWeight: FontWeight.bold, color: AppTheme.myLoveSingText)
                    ),
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
      padding: EdgeInsets.fromLTRB(40.w, 240.w, 40.w, 40.w),
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
          // const TopNavBarWidget(),
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
    return Column(
      // padding: EdgeInsets.zero,
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
    this.safeAreaTop = 0.0
  });

  final double safeAreaTop;
  final List iconsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 920.h,
      padding: EdgeInsets.fromLTRB(40.w, 80.w, 40.w, 40.w),
      color: AppTheme.myLogoBg,
      child: Column(
        children: [
        //  const TopNavBarWidget(),
         SizedBox(height: 40.h + safeAreaTop),
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



