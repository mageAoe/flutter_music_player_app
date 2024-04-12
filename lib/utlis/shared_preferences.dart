import 'package:shared_preferences/shared_preferences.dart';

class Store{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void write(String name) async {
    final SharedPreferences prefs = await _prefs;

    List<String>? items = prefs.getStringList('searchHistory');
    if(items != null){
      if(!items.contains(name)){ // 必须是不存在才能添加
        items.add(name);
      }
    }else{
      items = [name];
    }

    await prefs.setStringList('searchHistory', items);
  }

  Future<List<String>?> read() async {
    final SharedPreferences prefs = await _prefs;

    List<String>? items = prefs.getStringList('searchHistory');

    return items;
  }

  void clear(String key) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setStringList(key, []);
  }
}