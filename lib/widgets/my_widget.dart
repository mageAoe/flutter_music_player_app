import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_music_player_app/views/login/login.dart';
import 'package:flutter_music_player_app/model/user_detail_model.dart';
import 'package:flutter_music_player_app/views/my/song_detail_view.dart';
import 'package:flutter_music_player_app/model/user_playlist_model.dart';
import 'package:flutter_music_player_app/theme/my_style.dart';



/*
 * 顶部自定义导航
 */
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


/*
 * 我的头像
 */
class MyAvatarWidget extends StatelessWidget {
  final String? avatar;

  const MyAvatarWidget({
    super.key,
    this.avatar
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 180.w,
        height: 180.w,
        decoration: avatar == null ?
        BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(90.w),
        ):
        BoxDecoration(
          borderRadius: BorderRadius.circular(90.w),
          image: DecorationImage(
             image: NetworkImage(avatar!),
             fit: BoxFit.cover
          )
        ),
     );
  }
}

/*
 * 登录按钮
 */
class MyLoginBtnWidget extends StatelessWidget {
  final void Function()? onTap;
  const MyLoginBtnWidget({
    super.key,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){}, 
      child: InkWell(
        onTap: onTap,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('立即登录', style: TextStyle(color: AppTheme.allWhite, fontSize: 48.sp, fontWeight: FontWeight.bold)),
          const Icon(Icons.chevron_right_rounded, color: AppTheme.allWhite)
        ],
          ),
      ));
  }
}


/*
 * 功能按钮
 */
class MyActionsWidget extends StatelessWidget {
  const MyActionsWidget({
    super.key,
    required this.iconsList,
  });

  final List iconsList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: iconsList.map((e){
          return Container(
            padding: EdgeInsets.only(top: 15.h, bottom: 15.h,left: 30.w, right: 30.w),
            decoration: BoxDecoration(
              color: AppTheme.myLogoBgBtn,
              borderRadius: BorderRadius.circular(5)
            ),
            child: Row(
              children: [
                Icon(e['icon'], color: AppTheme.myLogoBtnIcon, size: 15),
                SizedBox(width: 10.w),
                Text(e['title'], style: const TextStyle(color: AppTheme.myLogoBtnIcon)),
              ],
            ),
          );
        }).toList()
      ),
    );
  }
}


/*
 * 未登录时上面部分
 */
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


/*
 * 未登录时底下部分
 */
class MyNotLoginBottomWidget extends StatelessWidget {
  const MyNotLoginBottomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          Text('${userDetailData.profile?.nickname }', style: nicknameTextStyle),
          SizedBox(height: 20.h),
          Text('${userDetailData.profile?.signature}', style: signatureTextStyle),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text('${userDetailData.profile?.newFollows}', style: newFollowsTextStyle),
                  SizedBox(width: 20.w),
                  Text('关注', style: newFollowsSubTextStyle),
                ],
              ),
              Row(
                children: [
                  Text('${userDetailData.profile?.followeds}', style: newFollowsTextStyle),
                  SizedBox(width: 20.w),
                  Text('粉丝', style: newFollowsSubTextStyle),
                ],
              ),
              Row(
                children: [
                  Text('Lv.${userDetailData.level}', style: newFollowsTextStyle),
                  SizedBox(width: 20.w),
                  Text('等级', style: newFollowsSubTextStyle),
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
                    Text('${e.name}', overflow: TextOverflow.ellipsis, style:  playlistNameTextStyle),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text('歌单 ·', style: playlistNameSubTextStyle),
                        Text('${e.trackCount}首 ·', style: playlistNameSubTextStyle),
                        Text('${e.creator?.nickname}', style: playlistNameSubTextStyle),
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