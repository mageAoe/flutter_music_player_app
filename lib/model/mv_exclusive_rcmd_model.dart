class MvExclusiveRcmdModel {
  MvExclusiveRcmdModel({
    this.data,
    this.more,
    this.code,
  });
  List<MvItemData>? data;
  bool? more;
  int? code;
  
  MvExclusiveRcmdModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>MvItemData.fromJson(e)).toList();
    more = json['more'];
    code = json['code'];
  }
}

class MvItemData {
  MvItemData({
    this.id,
    this.cover,
    this.name,
    this.playCount,
    this.briefDesc,
    this.desc,
    this.artistName,
    this.artistId,
    this.duration,
    this.mark,
    this.subed,
    this.artists,
  });
  int? id;
  String? cover;
  String? name;
  int? playCount;
  String? briefDesc;
  String? desc;
  String? artistName;
  int? artistId;
  int? duration;
  int? mark;
  bool?subed;
  List<Artists>? artists;
  
  MvItemData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    cover = json['cover'];
    name = json['name'];
    playCount = json['playCount'];
    briefDesc = json['briefDesc'];
    desc = json['desc'];
    artistName = json['artistName'];
    artistId = json['artistId'];
    duration = json['duration'];
    mark = json['mark'];
    subed = json['subed'];
    artists = List.from(json['artists']).map((e)=>Artists.fromJson(e)).toList();
  }
}

class Artists {
  Artists({
    this.id,
    this.name,
  });
  int? id;
  String? name;
  
  Artists.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }
}