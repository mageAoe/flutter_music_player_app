class UserPlaylistModel {
  UserPlaylistModel({
    this.version,
    this.more,
    this.playlist,
    this.code,
  });
  String? version;
  bool? more;
  List<Playlist>? playlist;
  int? code;
  
  UserPlaylistModel.fromJson(Map<String, dynamic> json){
    version = json['version'];
    more = json['more'];
    playlist = List.from(json['playlist']).map((e)=>Playlist.fromJson(e)).toList();
    code = json['code'];
  }

  bool isEmpty() {
    return playlist == null && code == null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['version'] = version;
    data['more'] = more;
    data['playlist'] = playlist?.map((e)=>e.toJson()).toList();
    data['code'] = code;
    return data;
  }
}

class Playlist {
  Playlist({
    this.subscribers,
    this.subscribed,
    this.creator,
    this.top,
    this.backgroundCoverId,
    this.titleImage,
    this.opRecommend,
    this.subscribedCount,
    this.cloudTrackCount,
    this.userId,
    this.totalDuration,
    this.coverImgId,
    this.privacy,
    this.trackUpdateTime,
    this.trackCount,
    this.updateTime,
    this.commentThreadId,
    this.coverImgUrl,
    this.specialType,
    this.anonimous,
    this.createTime,
    this.highQuality,
    this.newImported,
    this.trackNumberUpdateTime,
    this.playCount,
    this.adType,
    this.tags,
    this.ordered,
    this.status,
    this.name,
    this.id,
    this.coverImgIdStr,
    this.copied,
  });
  List<dynamic>? subscribers;
  bool? subscribed;
  Creator? creator;
  bool? top;
  int? backgroundCoverId;
  int? titleImage;
  bool? opRecommend;
  int? subscribedCount;
  int? cloudTrackCount;
  int? userId;
  int? totalDuration;
  int? coverImgId;
  int? privacy;
  int? trackUpdateTime;
  int? trackCount;
  int? updateTime;
  String? commentThreadId;
  String? coverImgUrl;
  int? specialType;
  bool? anonimous;
  int? createTime;
  bool? highQuality;
  bool? newImported;
  int? trackNumberUpdateTime;
  int? playCount;
  int? adType;
  List<dynamic>? tags;
  bool? ordered;
  int? status;
  String? name;
  int? id;
  String? coverImgIdStr;
  bool? copied;
  
  Playlist.fromJson(Map<String, dynamic> json){
    subscribers = List.castFrom<dynamic, dynamic>(json['subscribers']);
    subscribed = json['subscribed'];
    creator = Creator.fromJson(json['creator']);
    top = json['top'];
    backgroundCoverId = json['backgroundCoverId'];
    titleImage = json['titleImage'];
    opRecommend = json['opRecommend'];
    subscribedCount = json['subscribedCount'];
    cloudTrackCount = json['cloudTrackCount'];
    userId = json['userId'];
    totalDuration = json['totalDuration'];
    coverImgId = json['coverImgId'];
    privacy = json['privacy'];
    trackUpdateTime = json['trackUpdateTime'];
    trackCount = json['trackCount'];
    updateTime = json['updateTime'];
    commentThreadId = json['commentThreadId'];
    coverImgUrl = json['coverImgUrl'];
    specialType = json['specialType'];
    anonimous = json['anonimous'];
    createTime = json['createTime'];
    highQuality = json['highQuality'];
    newImported = json['newImported'];
    trackNumberUpdateTime = json['trackNumberUpdateTime'];
    playCount = json['playCount'];
    adType = json['adType'];
    tags = List.castFrom<dynamic, dynamic>(json['tags']);
    ordered = json['ordered'];
    status = json['status'];
    name = json['name'];
    id = json['id'];
    coverImgIdStr = json['coverImgId_str'];
    copied = json['copied'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['subscribers'] = subscribers;
    data['subscribed'] = subscribed;
    data['top'] = top;
    data['backgroundCoverId'] = backgroundCoverId;
    data['titleImage'] = titleImage;
    data['opRecommend'] = opRecommend;
    data['subscribedCount'] = subscribedCount;
    data['cloudTrackCount'] = cloudTrackCount;
    data['userId'] = userId;
    data['totalDuration'] = totalDuration;
    data['coverImgId'] = coverImgId;
    data['privacy'] = privacy;
    data['trackUpdateTime'] = trackUpdateTime;
    data['trackCount'] = trackCount;
    data['updateTime'] = updateTime;
    data['commentThreadId'] = commentThreadId;
    data['coverImgUrl'] = coverImgUrl;
    data['specialType'] = specialType;
    data['anonimous'] = anonimous;
    data['createTime'] = createTime;
    data['highQuality'] = highQuality;
    data['newImported'] = newImported;
    data['trackNumberUpdateTime'] = trackNumberUpdateTime;
    data['playCount'] = playCount;
    data['adType'] = adType;
    data['tags'] = tags;
    data['ordered'] = ordered;
    data['status'] = status;
    data['name'] = name;
    data['id'] = id;
    data['coverImgId_str'] = coverImgIdStr;
    data['copied'] = copied;
    return data;
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
    this.djStatus,
    this.vipType,
    this.authenticationTypes,
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
  int? djStatus;
  int? vipType;
  int? authenticationTypes;
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
    djStatus = json['djStatus'];
    vipType = json['vipType'];
    authenticationTypes = json['authenticationTypes'];
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
    data['djStatus'] = djStatus;
    data['vipType'] = vipType;
    data['authenticationTypes'] = authenticationTypes;
    data['anchor'] = anchor;
    data['avatarImgIdStr'] = avatarImgIdStr;
    data['backgroundImgIdStr'] = backgroundImgIdStr;
    data['avatarImgId_str'] = avatarImgIdStr;
    return data;
  }
}