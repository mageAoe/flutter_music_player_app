class SearchModel {
  SearchModel({
    this.result,
    this.code,
  });
  Result? result;
  int? code;
  
  SearchModel.fromJson(Map<String, dynamic> json){
    result = Result.fromJson(json['result']);
    code = json['code'];
  }
}

class Result {
  Result({
    this.songs,
    this.hasMore,
    this.songCount,
  });
  List<Songs>? songs;
  bool? hasMore;
  int? songCount;
  
  Result.fromJson(Map<String, dynamic> json){
    songs = List.from(json['songs']).map((e)=>Songs.fromJson(e)).toList();
    hasMore = json['hasMore'];
    songCount = json['songCount'];
  }
}

class Songs {
  Songs({
    this.id,
    this.name,
    this.artists,
    this.album,
    this.duration,
    this.copyrightId,
    this.status,
    this.alias,
    this.rtype,
    this.ftype,
    this.mvid,
    this.fee,
    this.rUrl,
    this.mark,
  });
  int? id;
  String? name;
  List<Artists>? artists;
  Album? album;
  int? duration;
  int? copyrightId;
  int? status;
  List<String>? alias;
  int? rtype;
  int? ftype;
  int? mvid;
  int? fee;
  int? rUrl;
  int? mark;
  
  Songs.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    artists = List.from(json['artists']).map((e)=>Artists.fromJson(e)).toList();
    album = Album.fromJson(json['album']);
    duration = json['duration'];
    copyrightId = json['copyrightId'];
    status = json['status'];
    alias = List.castFrom<dynamic, String>(json['alias']);
    rtype = json['rtype'];
    ftype = json['ftype'];
    mvid = json['mvid'];
    fee = json['fee'];
    rUrl = json['rUrl'];
    mark = json['mark'];
  }
}

class Artists {
  Artists({
    this.id,
    this.name,
    this.picUrl,
    this.alias,
    this.albumSize,
    this.picId,
    this.fansGroup,
    this.img1v1Url,
    this.img1v1,
    this.trans,
  });
  int? id;
  String? name;
  String? picUrl;
  List<dynamic>? alias;
  int? albumSize;
  int? picId;
  String? fansGroup;
  String? img1v1Url;
  int? img1v1;
  String? trans;
  
  Artists.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    picUrl = json['picUrl'];
    alias = List.castFrom<dynamic, dynamic>(json['alias']);
    albumSize = json['albumSize'];
    picId = json['picId'];
    fansGroup = json['fansGroup'];
    img1v1Url = json['img1v1Url'];
    img1v1 = json['img1v1'];
    trans = json['trans'];
  }
}

class Album {
  Album({
    this.id,
    this.name,
    this.artist,
    this.publishTime,
    this.size,
    this.copyrightId,
    this.status,
    this.picId,
    this.mark,
  });
  int? id;
  String? name;
  Artist? artist;
  int? publishTime;
  int? size;
  int? copyrightId;
  int? status;
  int? picId;
  int? mark;
  
  Album.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    artist = Artist.fromJson(json['artist']);
    publishTime = json['publishTime'];
    size = json['size'];
    copyrightId = json['copyrightId'];
    status = json['status'];
    picId = json['picId'];
    mark = json['mark'];
  }

}

class Artist {
  Artist({
    this.id,
    this.name,
    this.picUrl,
    this.alias,
    this.albumSize,
    this.picId,
    this.fansGroup,
    this.img1v1Url,
    this.img1v1,
    this.trans,
  });
  int? id;
  String? name;
  String? picUrl;
  List<dynamic>? alias;
  int? albumSize;
  int? picId;
  String? fansGroup;
  String? img1v1Url;
  int? img1v1;
  String? trans;
  
  Artist.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    picUrl = json['picUrl'];
    alias = List.castFrom<dynamic, dynamic>(json['alias']);
    albumSize = json['albumSize'];
    picId = json['picId'];
    fansGroup = json['fansGroup'];
    img1v1Url = json['img1v1Url'];
    img1v1 = json['img1v1'];
    trans = json['trans'];
  }
}