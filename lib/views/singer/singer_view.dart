import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/model/singer_model.dart';
import 'package:flutter_music_player_app/api/singer_api.dart';
import 'package:cached_network_image/cached_network_image.dart';




class SingerView extends StatefulWidget {
  const SingerView({super.key});

  @override
  State<SingerView> createState() => _SingerViewState();
}

class _SingerViewState extends State<SingerView>  with TickerProviderStateMixin {

  List listType = [
    {"name": "全部", "type": -1},
    {"name": "男歌手", "type": 1},
    {"name": "女歌手", "type": 2},
    {"name": "乐队", "type": 3}
  ];
  List listArea = [
    {"name": "全部", "area": -1},
    {"name": "华语", "area": 7},
    {"name": "欧美", "area": 96},
    {"name": "日本", "area": 8},
    {"name": "韩国", "area": 16},
    {"name": "其他", "area": 0},
  ];

  int offset = 0;
  bool isLoading = false;
  SingerModel singerList = SingerModel();
  List<Artists?> artists = [];
  late TabController _tabTopController;
  late TabController _tabBotoomController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabTopController = TabController(length: 4, vsync: this);
    _tabTopController.addListener(() {
      if(_tabTopController.animation!.value == _tabTopController.index){
        setState(() {
          offset = 0;
          artists = [];
        });
        getSingerList();
      }
    });
    _tabBotoomController = TabController(length: 6, vsync: this);
    _tabBotoomController.addListener(() {
      if(_tabBotoomController.animation!.value == _tabBotoomController.index){
        setState(() {
          offset = 0;
          artists = [];
        });
        getSingerList();
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if(singerList.more!){
          setState(() {
            offset += 30;
            isLoading = true;
          });
          getSingerList();
        }
      }
    });

    getSingerList();
  }

  // 请求数据
  void getSingerList() async {
    String query = 'type=${listType[_tabTopController.index]['type']}&area=${listArea[_tabBotoomController.index]['area']}&limit=30&offset=$offset';
    await SingerApi.getSingerList(query).then((value){
      if(value != null){
        setState(() {
          singerList = value;
          artists.addAll(value.artists!);
        });
      }
      setState(() {
          isLoading = false;
        });
    });
  }

  Widget _buildItem(Artists e, int index){
    return Column(
        children: [
           ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: '${e.img1v1Url}',
                placeholder: (context, url) => Image.asset('assets/images/placeholder.gif'),
              ),
            ),
            title: Text(e.name!, style: const TextStyle(color: Colors.black87)),
            subtitle: Row(
              children: [
                const Text('歌曲数量：'),
                Text('${e.musicSize}')
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black87),
          ),
          const Divider()
        ],
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          elevation: 0,
          backgroundColor: AppTheme.myBg,
          foregroundColor: Colors.black,
          title: const Text('歌手分类'),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 65.h,
                child:TabBar(
                  isScrollable: true,
                  controller: _tabTopController,
                  indicatorColor: Colors.white,
                  labelColor: AppTheme.primary,
                  indicatorWeight: 2,
                  indicatorPadding: const EdgeInsets.only(left: 5, right: 5),
                  labelStyle: TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: const TextStyle( // 未选中样式
                    fontWeight: FontWeight.w100
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: listType.map((value) {
                    return Tab(
                      child: Text(value["name"]));
                  }).toList(),
                )
              ),
              SizedBox(
                height: 65.h,
                child:TabBar(
                  isScrollable: true,
                  controller: _tabBotoomController,
                  indicatorColor: Colors.white,
                  labelColor: AppTheme.primary,
                  indicatorWeight: 2,
                  indicatorPadding: const EdgeInsets.only(left: 5, right: 5),
                  labelStyle: TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: const TextStyle( // 未选中样式
                    fontWeight: FontWeight.w100
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: listArea.map((value) {
                    return Tab(
                      child: Text(value["name"]));
                  }).toList(),
                )
              )
            ],
          ),
          Container(
            width: double.infinity,
            height: 80.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            color: const Color.fromARGB(255, 234, 235, 240),
            child: const Text('热门歌手'),
          ),
          artists.isEmpty
          ? const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
          : Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              itemCount: artists.length,
              itemBuilder: (context, index){
                if(isLoading && index == artists.length - 1){
                  return const Center(
                    child: CircularProgressIndicator());
                }else{
                  return _buildItem(artists[index]!, index);
                }
              },
            ),
          )
        ],
      ),
    );
  }


    @override
  void dispose() {
    _tabTopController.dispose();
    _tabBotoomController.dispose();
    super.dispose();
  }
}