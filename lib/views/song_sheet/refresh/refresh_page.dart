// 下拉刷新 上拉加载

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_music_player_app/model/top_playlist_model.dart';
import 'package:flutter_music_player_app/api/song_sheet_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/views/song_sheet/song_detail_view.dart';




class RefreshPage extends StatefulWidget {

  final String value;

  const RefreshPage({super.key, required this.value});

  @override
  State<RefreshPage> createState() => _RefreshPageState();
}

class _RefreshPageState extends State<RefreshPage> {

  bool isLoading = false; // 是否正在请求数据中
  bool _hasMore = true; // 是否还有更多数据可加载
  int _pageIndex = 0; // 页面的索引
  int? _pageTotal = 0; // 总数据条数
  bool _isHasMore = false; // 是否还有更多数据可加载
  List<Playlists> playlists = [];

  //滑动监听
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _getMoreData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        setState(() {
          _isHasMore = true;
          _pageIndex ++;
        });
        _getMoreData();
        // print('-------加载更多--------');
      }
    });
    super.initState();
  }

  Future<TopPlaylistModel?> getTopPlaylist() async {
    // limit=10&offset=0&cat=华语
    TopPlaylistModel? topPlaylist = await SongSheetApi.getTopPlaylist('limit=20&offset=$_pageIndex&cat=${widget.value}');
    if(topPlaylist != null){
      _pageTotal = topPlaylist.total;
      return topPlaylist;
    }
    return null;
  }

  // ListView 到底 ，触发加载更多
  Future _getMoreData() async {
    print("上拉加载更多,或者第一次加载");
    if (!isLoading && _hasMore) {
      // 如果上一次异步请求数据完成 同时有数据可以加载
      if (mounted) {
        setState(() => isLoading = true);
      }
      TopPlaylistModel? topPlaylist = await getTopPlaylist();
      _hasMore = ((_pageIndex + 1) * 20 < _pageTotal!);
      _isHasMore = false;
      if (mounted) { 
        setState(() {
          if(topPlaylist != null){
            playlists.addAll(topPlaylist.playlists as Iterable<Playlists>);
          }
          isLoading = false;
        });
      }
    }else if (!isLoading && !_hasMore) {
      // 这样判断,减少以后的绘制
      _pageIndex = 0;
    }
  }

  // 下拉加载的事件，清空之前list内容，取前X个
  // 其实就是列表重置
  Future<void> _handleRefresh() async {
    // print("下拉刷新 ");
    TopPlaylistModel? topPlaylist = await getTopPlaylist();
    if (mounted) { //mounted == true  保证 当前widget 状态可以更新
      setState(() {
        playlists.clear();
        playlists.addAll(topPlaylist?.playlists as Iterable<Playlists>);
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
      return SinglesSectionWidget(topPlay: playlists[index], id: playlists[index].id, type: widget.value);
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
      : GridView.builder(
        ///保持GridView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.w,
        ), 
        itemBuilder: (context,index){
          return _getItem(index);
        },
        ///根据状态返回绘制 item 数量
        itemCount: _getListCount(),
        ///滑动监听
        controller: _scrollController,
      ), //指示器颜色
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


class SinglesSectionWidget extends StatelessWidget {
  const SinglesSectionWidget({
    super.key,
    required this.id,
    required this.type,
    required this.topPlay,
  });
  final String type;
  final int? id;
  final Playlists topPlay;

  String getPlayCount(int? value){
    if(value! >= 100000){
      return '${(value / 10000).toStringAsFixed(0)}万';
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
      child: Stack(
        children: [
          OnClickWidget(
            onTap: () {
              print(id);
              Navigator.push( 
                context,
                MaterialPageRoute(builder: (context) {
                  return SongDetailView(
                    id: id!,
                    coverImgUrl: topPlay.coverImgUrl ?? '',
                    name: topPlay.name ?? '',
                    nickname: topPlay.creator!.nickname??'',
                    avatar: topPlay.creator!.avatarUrl??'',
                    playCount: topPlay.playCount??0,
                    description: topPlay.description??'',
                    shareCount: topPlay.shareCount??0,
                    commentCount: topPlay.commentCount??0,
                    subscribedCount: topPlay.subscribedCount??0,
                    type: type,
                    coverName: topPlay.creator!.nickname??'',
                  );
                }),
              );
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.network('${topPlay.coverImgUrl}', fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 10.w,
            right: 10.h,
            child: Container(
              width: 160.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.pink[200],
                borderRadius: BorderRadius.circular(22.w)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.play_arrow_outlined, color: Colors.white, size: 18,),
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      getPlayCount(topPlay.playCount), 
                      style: TextStyle(color: Colors.white,fontSize: 32.sp))
                  )
                ],
              ),
            )
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