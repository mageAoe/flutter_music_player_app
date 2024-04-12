class SingerModel {
  SingerModel({
    this.artists,
    this.more,
    this.code,
  });
  List<Artists>? artists;
  bool? more;
  int? code;
  
  SingerModel.fromJson(Map<String, dynamic> json){
    artists = List.from(json['artists']).map((e)=>Artists.fromJson(e)).toList();
    more = json['more'];
    code = json['code'];
  }

  bool isEmpty() {
    return artists == null && code == null;
  }
}

class Artists {
  Artists({
    this.accountId,
    this.albumSize,
    this.alias,
    this.briefDesc,
    this.followed,
    this.id,
    this.img1v1Id,
    this.img1v1IdStr,
    this.img1v1Url,
    this.musicSize,
    this.name,
    this.picId,
    this.picIdStr,
    this.picUrl,
    this.topicPerson,
    this.trans,
    this.transNames,
  });
  int? accountId;
  int? albumSize;
  List<String>? alias;
  String? briefDesc;
  bool? followed;
  int? id;
  int? img1v1Id;
  String? img1v1IdStr;
  String? img1v1Url;
  int? musicSize;
  String? name;
  int? picId;
  String? picIdStr;
  String? picUrl;
  int? topicPerson;
  String? trans;
  List<String>? transNames;
  
  Artists.fromJson(Map<String, dynamic> json){
    accountId = json['accountId'];
    albumSize = json['albumSize'];
    alias = List.castFrom<dynamic, String>(json['alias']);
    briefDesc = json['briefDesc'];
    followed = json['followed'];
    id = json['id'];
    img1v1Id = json['img1v1Id'];
    img1v1IdStr = json['img1v1Id_str'];
    img1v1Url = json['img1v1Url'];
    musicSize = json['musicSize'];
    name = json['name'];
    picId = json['picId'];
    picIdStr = json['picId_str'];
    picUrl = json['picUrl'];
    topicPerson = json['topicPerson'];
    trans = json['trans'];
    if(json['transNames'] != null){
      transNames = List.castFrom<dynamic, String>(json['transNames']);
    }
  }
}