import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_music_player_app/theme/public_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoverView extends StatefulWidget {
  const CoverView({super.key});

  @override
  State<CoverView> createState() => _CoverViewState();
}

class _CoverViewState extends State<CoverView> {
  double safeAreaTop = 0.0;

  @override
  Widget build(BuildContext context) {
    // 获取屏幕信息
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    // 获取刘海屏的高度
    safeAreaTop = mediaQueryData.padding.top;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration:
                  const BoxDecoration(gradient: coverHeadLinearGradientStyle),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: safeAreaTop + 120.h),
                  Center(
                    child: SizedBox(
                      width: 600.w,
                      height: 600.h,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                              'https://p2.music.126.net/AS3p3T9P0sps1hkSXjwoAw==/109951169253470725.jpg',
                              fit: BoxFit.cover)),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Center(
                    child: Text('1000首华语乐坛神仙打架8090后经典老歌', style: TextStyle(color: AppTheme.allWhite,fontSize: 43.sp))
                  ),
                  SizedBox(height: 40.h),
                  const Divider(color: AppTheme.allWhite),
                  SizedBox(height: 40.h),
                  Row(
                    children: [
                      const Text('标签:', style: TextStyle(color: AppTheme.allWhite)),
                      SizedBox(width: 40.w),
                      Container(
                        padding: EdgeInsets.fromLTRB(22.w, 8.w, 22.w, 8.w),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 109, 105, 103),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Text('华语', style: TextStyle(color: AppTheme.allWhite, fontWeight: FontWeight.w700, fontSize: 26.sp)),
                      )
                    ],
                  ),
                   SizedBox(height: 40.h),
                  const Text('从前车马很慢，书信很远，一生只够爱一个人。', style: TextStyle(color: AppTheme.allWhite)),
                   SizedBox(height: 40.h),
                  const Text('封面:周杰伦', style: TextStyle(color: AppTheme.allWhite)),
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: SizedBox(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(15.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    width: 240.w,
                    child: const Center(child: Text('保存封面', style: TextStyle(color: AppTheme.allWhite))),
                  ),
                ),
            ))
          ],
        ));
  }
}
