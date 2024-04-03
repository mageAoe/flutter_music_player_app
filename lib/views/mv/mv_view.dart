import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_music_player_app/views/mv/mv_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/model/mv_exclusive_rcmd_model.dart';
import 'package:flutter_music_player_app/views/mv/refresh/refresh_page.dart';





class MvView extends StatefulWidget {
  const MvView({ Key? key }) : super(key: key);

  @override
  _MvViewState createState() => _MvViewState();
}

class _MvViewState extends State<MvView> with TickerProviderStateMixin {


  int limit = 20;
  int offset = 0;
  late TabController _tabController;
  List<MvData> tabIconsList = MvData.tabIconsList;




  @override
  void initState() {
    _tabController = TabController(length: tabIconsList.length, vsync: this);
    _tabController.addListener(() {
      if(_tabController.animation!.value == _tabController.index){
        print('tabController.index:  ${_tabController.index}');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
            elevation: 0,
            backgroundColor: AppTheme.myBg,
            title: SizedBox(
              height: 65.h,
              child:TabBar(
                isScrollable: true,
                controller: _tabController,
                indicatorColor: AppTheme.primary,
                labelColor: Colors.black,
                indicatorWeight: 2,
                indicatorPadding: const EdgeInsets.only(left: 5, right: 5),
                labelStyle: const TextStyle(fontSize: 14),
                unselectedLabelColor: Colors.grey[400],
                indicatorSize: TabBarIndicatorSize.label,
                tabs: tabIconsList.map((value) {
                  return Tab(
                    child: Text(value.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold)));
                }).toList(),
              )
            )),
      ),
      body: TabBarView(
          controller: _tabController,
          children: List.generate(
            tabIconsList.length,
            (index) {
              return Container(
                padding: EdgeInsets.only(bottom: 120.h, left: 20.w, right: 20.w),
                color: AppTheme.myBg,
                child: RefreshPage(mvIconData: MvData.tabIconsList[index]),
              );
            },
          ),
        ),
    );
  }
}