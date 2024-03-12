import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_music_player_app/widgets/find_widget.dart';
import 'package:flutter_music_player_app/api/find_api.dart';
import 'package:flutter_music_player_app/model/banners_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/theme/public_style.dart';
import 'package:flutter_music_player_app/utlis/fonts.dart';
import 'package:flutter_music_player_app/services/KeepAliveWrapper.dart';

class FindView extends StatefulWidget {
  const FindView({ super.key });

  @override
  _FindViewState createState() => _FindViewState();
}

class _FindViewState extends State<FindView> {

  double safeAreaTop = 0.0;
  List<Banners> banner = <Banners>[];
  List menuList = [
    {'title': '每日推荐', 'icon': const Icon(YunMusicFont.ziyuan16, color: AppTheme.primary, size: 30)},
    {'title': '排行榜', 'icon': const Icon(YunMusicFont.panhangbang, color: AppTheme.primary, size: 30)},
    {'title': '歌手', 'icon': const Icon(YunMusicFont.geshou, color: AppTheme.primary, size: 30)},
    {'title': '历史', 'icon': const Icon(Icons.history_rounded, color: AppTheme.primary, size: 30)},
  ];

   @override
  void initState() {
    FindApi.getBanner().then((bannerList) {
      if(bannerList != null){
        setState(() {
          banner = bannerList;
        });
      }
    });
    print('===========find=========');
    super.initState();
  }

  _onScrolled(ScrollNotification notification) {}

  @override
  Widget build(BuildContext context) {
    // 获取屏幕信息
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    // 获取刘海屏的高度
    safeAreaTop = mediaQueryData.padding.top;

    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: headLinearGradientStyle),
          padding: EdgeInsets.all(20.w),
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child:Container(
                    margin: EdgeInsets.only(top: safeAreaTop - 20.w, left: 20.w, right: 20.w,bottom: 60.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.menu, color: Colors.white),
                        const SearchWidget(),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.mic, size: 30, color: Colors.white))
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SwiperWidget(banner: banner),
                ),
                // 其他 SliverAppBar 或 SliverPersistentHeader 可以继续添加
              ];
            },
            body: NotificationListener<ScrollNotification>(
              onNotification: (notification) => _onScrolled(notification),
              child:  CustomScrollView(
                cacheExtent: 10.0,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: SizedBox(height: 30.h),
                  ),
                  CategoryWidget(menuList: menuList)
                  // 其他 Sliver 类型的小部件可以继续添加
                ],
              ),
            ),
          ),
        )
      );
  }
}

