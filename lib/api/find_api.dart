import 'package:flutter_music_player_app/services/httpClient.dart';
import 'package:flutter_music_player_app/model/banners_model.dart';

class FindApi {

  static final HttpClient _httpClient = HttpClient();


  static Future<List<Banners>?> getBanner() async {
    var res = await _httpClient.get();
    print('----------print(res);------------');
    print(res);
    print(res.data);
    if(res.data != null){
      print('----------进来了------------');
      List<Banners> bannerList = BannersModel.fromJson(res.data).banners;
      print(bannerList);
      return bannerList;
    }else{
      return null;
    }
  }
}