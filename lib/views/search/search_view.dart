import 'package:flutter/material.dart';
import 'package:flutter_music_player_app/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_music_player_app/api/search_api.dart';
import 'package:flutter_music_player_app/model/search_hot_model.dart';
import 'package:flutter_music_player_app/views/search/search_list.dart';
import 'package:flutter_music_player_app/utlis/shared_preferences.dart';




class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with SingleTickerProviderStateMixin {
  
  final FocusNode _focusNode = FocusNode();
  late Color _prefixIconColor = Colors.grey; 

  bool isLoading = false;
  SearchHotModel searchList = SearchHotModel();
  final TextEditingController _editingController = TextEditingController();

  List<String> historyList = [];


  @override
  void initState() {
    _focusNode.addListener(() {  
      if (_focusNode.hasFocus) {  
        setState(() {  
          _prefixIconColor = Colors.pink; // 聚焦时的颜色  
        });  
      } else {  
        setState(() {  
          _prefixIconColor = Colors.grey; // 未聚焦时的颜色  
        });  
      }  
    });

    getHistory();
    isLoading = true;
    getSearchHot();
    super.initState();
  }

  void getHistory() async {
    Store store = Store();
    List<String>? history = await store.read();
    print(history);
    setState(() {
      historyList = history!;
    });
  }

  void clearHistory() async {
    Store store = Store();
    store.clear('searchHistory');
  }

  void getSearchHot() async {
    SearchApi.getSearchHot().then((value) {
      setState(() {
        searchList = value!;
        isLoading = false;
      });
    });
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
            controller: _editingController,
            focusNode: _focusNode,
            cursorColor: Colors.pink,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search,color: _prefixIconColor),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchListView(name: _editingController.text)));
            }, 
            child: const Text('搜索', style: TextStyle(color: Colors.black)))
        ],
      ),
      body: Container(
        color: AppTheme.myBg,
        padding: EdgeInsets.all(30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('搜索历史', style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(onPressed: (){
                  clearHistory();
                }, icon: const Icon(Icons.delete, color: Colors.grey))
              ],
            ),
            historyList.isEmpty ? const Text('')
            : Wrap(
              spacing: 10,
              runSpacing: 10,
              children: historyList.map((e){
                return ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ))
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchListView(name: e)));
                  }, child: Text(e, style: const TextStyle(color: Colors.black))
                );
              }).toList() 
            ),
            const Divider(),
            const Text('热搜榜', style: TextStyle(fontWeight: FontWeight.bold)),
            !isLoading && searchList.data!.isNotEmpty 
            ? Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchListView(name: searchList.data![index].searchWord!)));
                    },
                    child: ListTile(
                      leading: SizedBox(
                        width: 40, // 设置 leading 的宽度  
                        height: 40, // 设置 leading 的高度，通常与 ListTile 的高度一致 
                        child: Center( // 使用 Center 来垂直和水平居中内容  
                          child: Text('${index + 1}'),  
                        ),  
                      ),  
                      title: Row(
                        children: [
                          Text('${searchList.data![index].searchWord}'),
                          SizedBox(width: 20.w),
                          searchList.data![index].iconUrl == null 
                          ? const Text('') 
                          : Image.network('${searchList.data![index].iconUrl}', width: 50.h, height: 50.h),
                        ],
                      ),
                    ),
                  );
                }, 
                itemCount: searchList.data!.length
              ),
            ): const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}