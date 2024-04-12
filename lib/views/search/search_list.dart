import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/api/search_api.dart';
import 'package:flutter_music_player_app/model/search_model.dart';
import 'package:flutter_music_player_app/utlis/shared_preferences.dart';




class SearchListView extends StatefulWidget {

  final int? id;
  final String name;

  const SearchListView({
    super.key,
    this.id,
    required this.name
  });

  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {

  int offset = 0;
  bool isLoading = false;
  SearchModel search = SearchModel();
  List<Songs> searchList = [];
  
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();


  
  @override
  void initState() {
    searchController.text = widget.name;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if(search.result!.hasMore!){
          setState(() {
            offset += 30;
          });
          getSearch(searchController.text);
        }
      }
    });

    setState(() {
      isLoading = true;
    });
    getSearch(widget.name);
    super.initState();
  }

  void writeHistory(String name){
    Store store = Store();
    store.write(name);
  }

  void getSearch(String name) async {
    String query = 'keywords=$name&offset=$offset';
    writeHistory(name);
    SearchApi.getSearch(query).then((value) {
      if(value != null){
        setState(() {
          search = value;
          searchList.addAll(value.result!.songs!);
        });
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  String getArtName(List<Artists>? artists, String album){
    String text = "";
    for (var i = 0; i < artists!.length; i++) {
      if(i == artists.length - 1){
        text += artists[i].name!;
      }else{
        text += '${artists[i].name!}/';
      }
    }
    text += ' - $album';
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.myBg,
        foregroundColor: Colors.black,
        title: Container(
          height: 100.h,
          padding: EdgeInsets.fromLTRB(16.w, 10.w, 16.w, 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(38.w)
          ),
          child: TextField(
            controller: searchController,
            cursorColor: Colors.pink,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search,color: Colors.black),
              hintText: '搜索歌曲、歌手、专辑等',
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              hintStyle: TextStyle(color: Colors.grey, fontSize: 32.sp),
            ),
          ),
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(AppTheme.myBg),
            ),
            onPressed: (){
              if(searchController.text == '' || searchController.text == widget.name || searchController.text.contains(' ')){
                return;
              }
              setState(() {
                searchList.clear();
                offset = 0;
                isLoading = true;
              });
              getSearch(searchController.text);
            }, 
            child: const Text('搜索', style: TextStyle(color: Colors.black)))
        ],
      ),
      body: isLoading ?  const Center(child: CircularProgressIndicator())
      : ListView(
        controller: _scrollController,
        children: searchList.map((value){
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${value.name}', style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                        Text(getArtName(value.artists, value.album!.name!),
                          overflow: TextOverflow.ellipsis, maxLines: 1,
                          style: TextStyle(
                            fontSize: 30.sp,
                            color: const Color.fromARGB(255, 133, 131, 131)
                          ),
                        ),
                        value.alias!.isNotEmpty ?Text('${value.alias?[0]}',
                          style: TextStyle(
                            fontSize: 30.sp,
                            color: const Color.fromARGB(255, 133, 131, 131)
                          )
                        ): const Text('')
                      ],
                    ),
                  ),
                  const Icon(Icons.play_arrow_rounded)
                ],
              ),
              trailing: Icon(Icons.more_vert_outlined,size: 40.w),
            );
          }).toList()
      )
    );
  }
}