import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/model/banners_model.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';

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

// 登录按钮
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

// 功能按钮
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