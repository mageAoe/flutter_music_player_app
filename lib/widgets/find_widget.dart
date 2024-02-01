import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_music_player_app/model/banners_model.dart';

/*
* SearchWidget
*/
class SearchWidget extends StatelessWidget {
  final void Function()? onTap;
  const SearchWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 640.w,
        height: 96.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white
         ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(10, 0, 4, 0), child: Icon(Icons.search, color: Colors.black45)),
            Text('搜索', style: TextStyle(color: Colors.black54,fontSize: 40.sp, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

/*
* TabBarWidget
*/
class TabBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  const TabBarWidget({
    super.key,
    required this.tabController,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      tabs: const [
        Tab(child: Text('tab1')),
        Tab(child: Text('tab2')),
      ]
    );
  }
}


/*
*  swiper
*/
class SwiperWidget extends StatelessWidget {
  final List<Banners> banner;
  const SwiperWidget({ super.key,  required this.banner });

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: 1080.w,
      height: 360.h,
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
            return Image.network("${banner[index].pic}",fit: BoxFit.fill,);
          },
        itemCount: banner.length,
        pagination: const SwiperPagination(),
        control: const SwiperControl(),
      ),
    );
  }
}