import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/model/mv_exclusive_rcmd_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class SinglesSectionWidget extends StatelessWidget {
  const SinglesSectionWidget({
    super.key,
    required this.mvData,
  });
  final MvItemData mvData;

  String getPlayCount(int? value){
    if(value! >= 100000){
      return '${(value / 10000).toStringAsFixed(1)}万';
    }else{
      return value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              // child: Image.network('${topPlay.coverImgUrl}', fit: BoxFit.cover),
              child: FadeInImage.assetNetwork(
                height: 280.h,
                fit: BoxFit.fill,
                placeholder: 'assets/images/placeholder.gif',
                image: mvData.cover!,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mvData.name!, maxLines: 2, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 10.h),
                  Text(mvData.artistName!, style: TextStyle(color: Colors.teal, fontSize: 32.sp)),
                  SizedBox(height: 10.h),
                  Text('${getPlayCount(mvData.playCount)}播放', style: TextStyle(color: Colors.pink[400], fontSize: 32.sp)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// 点击事件组件
class OnClickWidget extends StatefulWidget {
  final void Function()? onTap;
  final Widget? child;
  const OnClickWidget({
    this.onTap,
    required this.child,
    super.key
  });

  @override
  State<OnClickWidget> createState() => _OnClickWidgetState();
}

class _OnClickWidgetState extends State<OnClickWidget> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkResponse(
        /// 是否需要按需剪裁水波纹
        containedInkWell: true,
        /// 点击时，背景效果的形状
        borderRadius: BorderRadius.circular(10),
        /// 点击时，背景效果的形状（rectangle 或 circle）
        highlightShape: BoxShape.rectangle,
        /// 点击时，背景效果的颜色
        highlightColor: Colors.blue,
        onTap: widget.onTap,
        child: widget.child,
      ),
    );
  }
}