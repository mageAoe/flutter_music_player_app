class TopPlaylistModel {
  TopPlaylistModel({
    this.playlists,
    this.total,
    this.code,
    this.more,
    this.cat,
  });
  List<Playlists>? playlists;
  int? total;
  int? code;
  bool? more;
  String? cat;
  
  TopPlaylistModel.fromJson(Map<String, dynamic> json){
    playlists = List.from(json['playlists']).map((e)=>Playlists?.fromJson(e)).toList();
    total = json['total'];
    code = json['code'];
    more = json['more'];
    cat = json['cat'];
  }
}

class Playlists {
  Playlists({
    this.name,
    this.id,
    this.trackNumberUpdateTime,
    this.status,
    this.userId,
    this.createTime,
    this.updateTime,
    this.subscribedCount,
    this.trackCount,
    this.cloudTrackCount,
    this.coverImgUrl,
    this.iconImgUrl,
    this.coverImgId,
    this.description,
    this.tags,
    this.playCount,
    this.trackUpdateTime,
    this.specialType,
    this.totalDuration,
    this.creator,
    this.tracks,
    this.subscribers,
    this.subscribed,
    this.commentThreadId,
    this.newImported,
    this.adType,
    this.highQuality,
    this.privacy,
    this.ordered,
    this.anonimous,
    this.coverStatus,
    this.recommendInfo,
    this.socialPlaylistCover,
    this.recommendText,
    this.coverText,
    this.relateResType,
    this.relateResId,
    this.shareCount,
    this.coverImgIdStr,
    this.alg,
    this.commentCount,
  });
  String? name;
  int? id;
  int? trackNumberUpdateTime;
  int? status;
  int? userId;
  int? createTime;
  int? updateTime;
  int? subscribedCount;
  int? trackCount;
  int? cloudTrackCount;
  String? coverImgUrl;
  String? iconImgUrl;
  int? coverImgId;
  String? description;
  List<dynamic>? tags;
  int? playCount;
  int? trackUpdateTime;
  int? specialType;
  int? totalDuration;
  Creator? creator;
  String? tracks;
  List<Subscribers>? subscribers;
  String? subscribed;
  String? commentThreadId;
  bool? newImported;
  int? adType;
  bool? highQuality;
  int? privacy;
  bool? ordered;
  bool? anonimous;
  int? coverStatus;
  String? recommendInfo;
  String? socialPlaylistCover;
  String? recommendText;
  List<String>? coverText;
  String? relateResType;
  String? relateResId;
  int? shareCount;
  String? coverImgIdStr;
  String? alg;
  int? commentCount;
  
  Playlists.fromJson(Map<String, dynamic> json){
    name = json['name'];
    id = json['id'];
    trackNumberUpdateTime = json['trackNumberUpdateTime'];
    status = json['status'];
    userId = json['userId'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    subscribedCount = json['subscribedCount'];
    trackCount = json['trackCount'];
    cloudTrackCount = json['cloudTrackCount'];
    coverImgUrl = json['coverImgUrl'];
    iconImgUrl = json['iconImgUrl'];
    coverImgId = json['coverImgId'];
    description = json['description'];
    tags = List.castFrom<dynamic, dynamic>(json['tags']);
    playCount = json['playCount'];
    trackUpdateTime = json['trackUpdateTime'];
    specialType = json['specialType'];
    totalDuration = json['totalDuration'];
    creator = Creator.fromJson(json['creator']);
    tracks = json['tracks'];
    subscribers = List.from(json['subscribers']).map((e)=>Subscribers.fromJson(e)).toList();
    subscribed = json['subscribed'];
    commentThreadId = json['commentThreadId'];
    newImported = json['newImported'];
    adType = json['adType'];
    highQuality = json['highQuality'];
    privacy = json['privacy'];
    ordered = json['ordered'];
    anonimous = json['anonimous'];
    coverStatus = json['coverStatus'];
    recommendInfo = json['recommendInfo'];
    socialPlaylistCover = json['socialPlaylistCover'];
    recommendText = json['recommendText'];
    relateResType = json['relateResType'];
    relateResId = json['relateResId'];
    shareCount = json['shareCount'];
    coverImgIdStr = json['coverImgId_str'];
    alg = json['alg'];
    commentCount = json['commentCount'];
    if(json['coverText'] != null){
      coverText = List.castFrom<dynamic, String>(json['coverText']);
    }
  }
}

class Creator {
  Creator({
    this.defaultAvatar,
    this.province,
    this.authStatus,
    this.followed,
    this.avatarUrl,
    this.accountStatus,
    this.gender,
    this.city,
    this.birthday,
    this.userId,
    this.userType,
    this.nickname,
    this.signature,
    this.description,
    this.detailDescription,
    this.avatarImgId,
    this.backgroundImgId,
    this.backgroundUrl,
    this.authority,
    this.mutual,
    this.expertTags,
    this.experts,
    this.djStatus,
    this.vipType,
    this.remarkName,
    this.authenticationTypes,
    this.avatarDetail,
    this.anchor,
    this.avatarImgIdStr,
    this.backgroundImgIdStr,
  });
  bool? defaultAvatar;
  int? province;
  int? authStatus;
  bool? followed;
  String? avatarUrl;
  int? accountStatus;
  int? gender;
  int? city;
  int? birthday;
  int? userId;
  int? userType;
  String? nickname;
  String? signature;
  String? description;
  String? detailDescription;
  int? avatarImgId;
  int? backgroundImgId;
  String? backgroundUrl;
  int? authority;
  bool? mutual;
  String? expertTags;
  String? experts;
  int? djStatus;
  int? vipType;
  String? remarkName;
  int? authenticationTypes;
  AvatarDetail? avatarDetail;
  bool? anchor;
  String? avatarImgIdStr;
  String? backgroundImgIdStr;
  
  Creator.fromJson(Map<String, dynamic> json){
    defaultAvatar = json['defaultAvatar'];
    province = json['province'];
    authStatus = json['authStatus'];
    followed = json['followed'];
    avatarUrl = json['avatarUrl'];
    accountStatus = json['accountStatus'];
    gender = json['gender'];
    city = json['city'];
    birthday = json['birthday'];
    userId = json['userId'];
    userType = json['userType'];
    nickname = json['nickname'];
    signature = json['signature'];
    description = json['description'];
    detailDescription = json['detailDescription'];
    avatarImgId = json['avatarImgId'];
    backgroundImgId = json['backgroundImgId'];
    backgroundUrl = json['backgroundUrl'];
    authority = json['authority'];
    mutual = json['mutual'];
    expertTags = json['expertTags'];
    experts = json['experts'];
    djStatus = json['djStatus'];
    vipType = json['vipType'];
    remarkName = json['remarkName'];
    authenticationTypes = json['authenticationTypes'];
    anchor = json['anchor'];
    avatarImgIdStr = json['avatarImgIdStr'];
    backgroundImgIdStr = json['backgroundImgIdStr'];
    avatarImgIdStr = json['avatarImgId_str'];
    if(json['avatarDetail'] != null){
      avatarDetail = AvatarDetail?.fromJson(json['avatarDetail']);
    }
  }

}

class AvatarDetail {
  AvatarDetail({
    this.userType,
    this.identityLevel,
    this.identityIconUrl,
  });
  int? userType;
  int? identityLevel;
  String? identityIconUrl;
  
  AvatarDetail.fromJson(Map<String, dynamic> json){
    userType = json['userType'];
    identityLevel = json['identityLevel'];
    identityIconUrl = json['identityIconUrl'];
  }
}

class Subscribers {
  Subscribers({
    this.defaultAvatar,
    this.province,
    this.authStatus,
    this.followed,
    this.avatarUrl,
    this.accountStatus,
    this.gender,
    this.city,
    this.birthday,
    this.userId,
    this.userType,
    this.nickname,
    this.signature,
    this.description,
    this.detailDescription,
    this.avatarImgId,
    this.backgroundImgId,
    this.backgroundUrl,
    this.authority,
    this.mutual,
     this.expertTags,
     this.experts,
    this.djStatus,
    this.vipType,
     this.remarkName,
    this.authenticationTypes,
     this.avatarDetail,
    this.anchor,
    this.avatarImgIdStr,
    this.backgroundImgIdStr,
  });
  bool? defaultAvatar;
  int? province;
  int? authStatus;
  bool? followed;
  String? avatarUrl;
  int? accountStatus;
  int? gender;
  int? city;
  int? birthday;
  int? userId;
  int? userType;
  String? nickname;
  String? signature;
  String? description;
  String? detailDescription;
  int? avatarImgId;
  int? backgroundImgId;
  String? backgroundUrl;
  int? authority;
  bool? mutual;
  String? expertTags;
  String? experts;
  int? djStatus;
  int? vipType;
  String? remarkName;
  int? authenticationTypes;
  String? avatarDetail;
  bool? anchor;
  String? avatarImgIdStr;
  String? backgroundImgIdStr;
  
  Subscribers.fromJson(Map<String, dynamic> json){
    defaultAvatar = json['defaultAvatar'];
    province = json['province'];
    authStatus = json['authStatus'];
    followed = json['followed'];
    avatarUrl = json['avatarUrl'];
    accountStatus = json['accountStatus'];
    gender = json['gender'];
    city = json['city'];
    birthday = json['birthday'];
    userId = json['userId'];
    userType = json['userType'];
    nickname = json['nickname'];
    signature = json['signature'];
    description = json['description'];
    detailDescription = json['detailDescription'];
    avatarImgId = json['avatarImgId'];
    backgroundImgId = json['backgroundImgId'];
    backgroundUrl = json['backgroundUrl'];
    authority = json['authority'];
    mutual = json['mutual'];
    expertTags = json['expertTags'];
    experts = json['experts'];
    djStatus = json['djStatus'];
    vipType = json['vipType'];
    remarkName = json['remarkName'];
    authenticationTypes = json['authenticationTypes'];
    avatarDetail = json['avatarDetail'];
    anchor = json['anchor'];
    avatarImgIdStr = json['avatarImgIdStr'];
    backgroundImgIdStr = json['backgroundImgIdStr'];
    avatarImgIdStr = json['avatarImgId_str'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['defaultAvatar'] = defaultAvatar;
    data['province'] = province;
    data['authStatus'] = authStatus;
    data['followed'] = followed;
    data['avatarUrl'] = avatarUrl;
    data['accountStatus'] = accountStatus;
    data['gender'] = gender;
    data['city'] = city;
    data['birthday'] = birthday;
    data['userId'] = userId;
    data['userType'] = userType;
    data['nickname'] = nickname;
    data['signature'] = signature;
    data['description'] = description;
    data['detailDescription'] = detailDescription;
    data['avatarImgId'] = avatarImgId;
    data['backgroundImgId'] = backgroundImgId;
    data['backgroundUrl'] = backgroundUrl;
    data['authority'] = authority;
    data['mutual'] = mutual;
    data['expertTags'] = expertTags;
    data['experts'] = experts;
    data['djStatus'] = djStatus;
    data['vipType'] = vipType;
    data['remarkName'] = remarkName;
    data['authenticationTypes'] = authenticationTypes;
    data['avatarDetail'] = avatarDetail;
    data['anchor'] = anchor;
    data['avatarImgIdStr'] = avatarImgIdStr;
    data['backgroundImgIdStr'] = backgroundImgIdStr;
    data['avatarImgId_str'] = avatarImgIdStr;
    return data;
  }
}