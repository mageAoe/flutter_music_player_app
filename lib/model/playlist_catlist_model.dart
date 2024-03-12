class PlaylistCatlist {
  PlaylistCatlist({
    this.code,
    this.all,
    this.sub,
  });
  int? code;
  All? all;
  List<Sub>? sub;
  
  PlaylistCatlist.fromJson(Map<String, dynamic> json){
    code = json['code'];
    all = All.fromJson(json['all']);
    sub = List.from(json['sub']).map((e)=>Sub.fromJson(e)).toList();
  }
}

class All {
  All({
    this.name,
    this.resourceCount,
    this.imgId,
    this.imgUrl,
    this.type,
    this.category,
    this.resourceType,
    this.hot,
    this.activity,
  });
  String? name;
  int? resourceCount;
  int? imgId;
  String? imgUrl;
  int? type;
  int? category;
  int? resourceType;
  bool? hot;
  bool? activity;
  
  All.fromJson(Map<String, dynamic> json){
    name = json['name'];
    resourceCount = json['resourceCount'];
    imgId = json['imgId'];
    imgUrl = json['imgUrl'];
    type = json['type'];
    category = json['category'];
    resourceType = json['resourceType'];
    hot = json['hot'];
    activity = json['activity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['resourceCount'] = resourceCount;
    data['imgId'] = imgId;
    data['imgUrl'] = imgUrl;
    data['type'] = type;
    data['category'] = category;
    data['resourceType'] = resourceType;
    data['hot'] = hot;
    data['activity'] = activity;
    return data;
  }
}

class Sub {
  Sub({
    this.name,
    this.resourceCount,
    this.imgId,
    this.imgUrl,
    this.type,
    this.category,
    this.resourceType,
    this.hot,
    this.activity,
  });
  String? name;
  int? resourceCount;
  int? imgId;
  String? imgUrl;
  int? type;
  int? category;
  int? resourceType;
  bool? hot;
  bool? activity;
  
  Sub.fromJson(Map<String, dynamic> json){
    name = json['name'];
    resourceCount = json['resourceCount'];
    imgId = json['imgId'];
    imgUrl = json['imgUrl'];
    type = json['type'];
    category = json['category'];
    resourceType = json['resourceType'];
    hot = json['hot'];
    activity = json['activity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['resourceCount'] = resourceCount;
    data['imgId'] = imgId;
    data['imgUrl'] = imgUrl;
    data['type'] = type;
    data['category'] = category;
    data['resourceType'] = resourceType;
    data['hot'] = hot;
    data['activity'] = activity;
    return data;
  }
}