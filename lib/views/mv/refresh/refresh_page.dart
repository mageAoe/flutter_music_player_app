// 下拉刷新 上拉加载

import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/widgets/mv_widget.dart';
import 'package:flutter_music_player_app/api/mv_api.dart';
import 'package:flutter_music_player_app/model/mv_exclusive_rcmd_model.dart';
import 'package:flutter_music_player_app/views/mv/mv_data.dart';





class RefreshPage extends StatefulWidget {

  final MvData mvIconData;

  const RefreshPage({super.key, required this.mvIconData});

  @override
  State<RefreshPage> createState() => _RefreshPageState();
}

class _RefreshPageState extends State<RefreshPage> {

  bool isLoading = false; // 是否正在请求数据中
  bool _hasMore = true; // 是否还有更多数据可加载
  int _pageIndex = 0; // 页面的索引
  // int? _pageTotal = 0; // 总数据条数
  bool _isHasMore = false; // 是否还有更多数据可加载
  List<MvItemData> playlists = [];
  // MvExclusiveRcmdModel? mvList;

  //滑动监听
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // init(widget.mvIconData.index, widget.mvIconData.name);
    _getMoreData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        setState(() {
          _isHasMore = true;
          _pageIndex ++;
        });
        _getMoreData();
      }
    });
    super.initState();
  }

  // 请求数据
  Future<MvExclusiveRcmdModel?> init(int index,String name) async {
    if(index == 1){
     return await getMvExclusiveRcmd();
    }else if(index == 2){
      return await getMvFirst();
    }else if(index == 3){
      return await getTopMv();
    }else{
      return await getMvAll(name);
    }
  } 


  // 官方
  Future<MvExclusiveRcmdModel?> getMvExclusiveRcmd() async {
    MvExclusiveRcmdModel? mvList = await MVApi.getMvExclusiveRcmd('limit=30&offset=$_pageIndex');
    if(mvList != null){
      return mvList;
    }
    return null;
  }

  // 最新
  Future<MvExclusiveRcmdModel?> getMvFirst() async {
    MvExclusiveRcmdModel? mvList = await MVApi.getMvFirst('limit=30&offset=$_pageIndex');
    if(mvList != null){
      return mvList;
    }
    return null;
  }

  // 排行
  Future<MvExclusiveRcmdModel?> getTopMv() async {
    MvExclusiveRcmdModel? mvList =  await MVApi.getTopMv('limit=30&offset=$_pageIndex');
    if(mvList != null){
      return mvList;
    }
    return null;
  }

  // 分类
  Future<MvExclusiveRcmdModel?> getMvAll(String name) async {
    String query = 'limit=30&offset=$_pageIndex&area=$name';
    MvExclusiveRcmdModel? mvList =  await MVApi.getMvAll(query);
    if(mvList != null){
      return mvList;
    }
    return null;
  }

  // ListView 到底 ，触发加载更多
  Future _getMoreData() async {
    print("上拉加载更多,或者第一次加载");
    if (!isLoading) {
      // 如果上一次异步请求数据完成 同时有数据可以加载
      if (mounted) {
        setState(() => isLoading = true);
      }
      MvExclusiveRcmdModel? mvList = await init(widget.mvIconData.index, widget.mvIconData.name);
      if (mounted) {
        setState(() {
          if(mvList != null){
            playlists.addAll(mvList.data as Iterable<MvItemData>);
          }
          if(mvList!.data!.isEmpty){
            _hasMore = false;
          }
          isLoading = false;
        });
      }
    }else if (!isLoading) {
      // 这样判断,减少以后的绘制
      _pageIndex = 0;
    }
  }

  // 下拉加载的事件，清空之前list内容，取前X个
  // 其实就是列表重置
  Future<void> _handleRefresh() async {
    // print("下拉刷新 ");
    MvExclusiveRcmdModel? mvList = await init(widget.mvIconData.index, widget.mvIconData.name);
    if (mounted) { //mounted == true  保证 当前widget 状态可以更新
      setState(() {
        playlists.clear();
        playlists.addAll(mvList?.data as Iterable<MvItemData>);
        isLoading = false;
        return;
      });
    }
  }

  _getListCount() {
    if (playlists.isEmpty) {
      // 在没有数据时，固定返回数量1用于空页面呈现
      return 1;
    }else{
      return  playlists.length;
    }
  }

  ///根据配置状态返回实际列表渲染Item
  _getItem(int index) {
    // loading
    // 上拉加载更多
    // empty error
    if(index == playlists.length && playlists.isNotEmpty && _isHasMore){
      return _buildProgressIndicator();
    }else if (index == _getListCount() -1 && playlists.isNotEmpty && _isHasMore) {
      return _buildProgressIndicator();
    }else{
      return SinglesSectionWidget(mvData: playlists[index]);
    }
  }

  // 加载与empty
  _getLoadingOrEmpty() {
    if(isLoading){
      //正在刷新 渲染刷新页面
      return _buildIsLoading();
    }else{
      //渲染空页面
      return _buildEmpty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: AppTheme.primary,
      child: playlists.isEmpty ? _getLoadingOrEmpty() 
      :ListView.builder(
        ///保持GridView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context,index){
          return _getItem(index);
        },
        ///根据状态返回绘制 item 数量
        itemCount: _getListCount(),
        controller: _scrollController
      ),
    );
  }



  ///  loading
  Widget _buildIsLoading() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.85,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SpinKitCircle(size: 55.0, color: Theme.of(context).primaryColor),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text("正在加载..",
                  style: TextStyle(color: Colors.black54, fontSize: 15.0))
            )
          ]
        )
    ));
  }

  ///上拉加载更多 Widget
  Widget _buildProgressIndicator() {
    return _hasMore 
    ? SizedBox(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitFadingCircle( color: Theme.of(context).primaryColor),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text("正在加载..",
                  style: TextStyle(color: Colors.black54, fontSize: 15.0)))
          ],
        ),
      )
    ) 
    : const SizedBox( child: Center(
        child: Text("哥，这回真没了！！" ,style: TextStyle(color: Colors.black54, fontSize: 15.0)),
      ));
  }

  ///空页面 错误页面 empty error
  Widget  _buildEmpty()  {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text("页面出错了！！"),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppTheme.primary)),
            onPressed: (){
              if (mounted) { //mounted == true  保证 当前widget 状态可以更新
                setState(() {
                  playlists.clear();
                  isLoading = false;
                  _hasMore = true;
                  _pageIndex = 0;
                });
                _getMoreData();
              }
            }, 
            child: const Text("重新加载")
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
