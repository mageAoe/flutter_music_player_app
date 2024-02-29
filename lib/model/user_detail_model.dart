class UserDetailModel {
  UserDetailModel({
    this.level,
    this.listenSongs,
    this.userPoint,
    this.mobileSign,
    this.pcSign,
    this.profile,
    this.peopleCanSeeMyPlayRecord,
    this.bindings,
    this.adValid,
    this.code,
    this.newUser,
    this.recallUser,
    this.createTime,
    this.createDays,
    this.profileVillageInfo,
  });
  int? level;
  int? listenSongs;
  UserPoint? userPoint;
  bool? mobileSign;
  bool? pcSign;
  Profile? profile;
  bool? peopleCanSeeMyPlayRecord;
  List<Bindings>? bindings;
  bool? adValid;
  int? code;
  bool? newUser;
  bool? recallUser;
  int? createTime;
  int? createDays;
  ProfileVillageInfo? profileVillageInfo;
  
  UserDetailModel.fromJson(Map<String, dynamic> json){
    level = json['level'];
    listenSongs = json['listenSongs'];
    userPoint = UserPoint.fromJson(json['userPoint']);
    mobileSign = json['mobileSign'];
    pcSign = json['pcSign'];
    profile = Profile.fromJson(json['profile']);
    peopleCanSeeMyPlayRecord = json['peopleCanSeeMyPlayRecord'];
    bindings = List.from(json['bindings']).map((e)=>Bindings.fromJson(e)).toList();
    adValid = json['adValid'];
    code = json['code'];
    newUser = json['newUser'];
    recallUser = json['recallUser'];
    createTime = json['createTime'];
    createDays = json['createDays'];
    profileVillageInfo = ProfileVillageInfo.fromJson(json['profileVillageInfo']);
  }

  bool isEmpty() {
    return profile == null && level == null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['level'] = level;
    data['listenSongs'] = listenSongs;
    data['userPoint'] = userPoint?.toJson();
    data['mobileSign'] = mobileSign;
    data['pcSign'] = pcSign;
    data['profile'] = profile?.toJson();
    data['peopleCanSeeMyPlayRecord'] = peopleCanSeeMyPlayRecord;
    data['bindings'] = bindings?.map((e)=>e.toJson()).toList();
    data['adValid'] = adValid;
    data['code'] = code;
    data['newUser'] = newUser;
    data['recallUser'] = recallUser;
    data['createTime'] = createTime;
    data['createDays'] = createDays;
    data['profileVillageInfo'] = profileVillageInfo?.toJson();
    return data;
  }
}

class UserPoint {
  UserPoint({
    this.userId,
    this.balance,
    this.updateTime,
    this.version,
    this.status,
    this.blockBalance,
  });
  int? userId;
  int? balance;
  int? updateTime;
  int? version;
  int? status;
  int? blockBalance;
  
  UserPoint.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    balance = json['balance'];
    updateTime = json['updateTime'];
    version = json['version'];
    status = json['status'];
    blockBalance = json['blockBalance'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['balance'] = balance;
    data['updateTime'] = updateTime;
    data['version'] = version;
    data['status'] = status;
    data['blockBalance'] = blockBalance;
    return data;
  }
}

class Profile {
  Profile({
    this.privacyItemUnlimit,
    this.avatarDetail,
    this.birthday,
    this.nickname,
    this.avatarUrl,
    this.backgroundImgId,
    this.backgroundUrl,
    this.userType,
    this.avatarImgId,
    this.province,
    this.city,
    this.gender,
    this.followed,
    this.mutual,
    this.authStatus,
    this.expertTags,
    this.experts,
    this.remarkName,
    this.createTime,
    this.accountStatus,
    this.djStatus,
    this.vipType,
    this.detailDescription,
    this.defaultAvatar,
    this.backgroundImgIdStr,
    this.avatarImgIdStr,
    this.description,
    this.userId,
    this.signature,
    this.authority,
    this.followeds,
    this.follows,
    this.blacklist,
    this.eventCount,
    this.allSubscribedCount,
    this.playlistBeSubscribedCount,
    this.followTime,
    this.followMe,
    this.artistIdentity,
    this.cCount,
    this.inBlacklist,
    this.sDJPCount,
    this.playlistCount,
    this.sCount,
    this.newFollows,
  });
  PrivacyItemUnlimit? privacyItemUnlimit;
  String? avatarDetail;
  int? birthday;
  String? nickname;
  String? avatarUrl;
  int? backgroundImgId;
  String? backgroundUrl;
  int? userType;
  int? avatarImgId;
  int? province;
  int? city;
  int? gender;
  bool? followed;
  bool? mutual;
  int? authStatus;
  String? expertTags;
  Experts? experts;
  String? remarkName;
  int? createTime;
  int? accountStatus;
  int? djStatus;
  int? vipType;
  String? detailDescription;
  bool? defaultAvatar;
  String? backgroundImgIdStr;
  String? avatarImgIdStr;
  String? description;
  int? userId;
  String? signature;
  int? authority;
  int? followeds;
  int? follows;
  bool? blacklist;
  int? eventCount;
  int? allSubscribedCount;
  int? playlistBeSubscribedCount;
  String? followTime;
  bool? followMe;
  List<dynamic>? artistIdentity;
  int? cCount;
  bool? inBlacklist;
  int? sDJPCount;
  int? playlistCount;
  int? sCount;
  int? newFollows;
  
  Profile.fromJson(Map<String, dynamic> json){
    privacyItemUnlimit = PrivacyItemUnlimit.fromJson(json['privacyItemUnlimit']);
    avatarDetail = json['avatarDetail'];
    birthday = json['birthday'];
    nickname = json['nickname'];
    avatarUrl = json['avatarUrl'];
    backgroundImgId = json['backgroundImgId'];
    backgroundUrl = json['backgroundUrl'];
    userType = json['userType'];
    avatarImgId = json['avatarImgId'];
    province = json['province'];
    city = json['city'];
    gender = json['gender'];
    followed = json['followed'];
    mutual = json['mutual'];
    authStatus = json['authStatus'];
    expertTags = json['expertTags'];
    experts = Experts.fromJson(json['experts']);
    remarkName = json['remarkName'];
    createTime = json['createTime'];
    accountStatus = json['accountStatus'];
    djStatus = json['djStatus'];
    vipType = json['vipType'];
    detailDescription = json['detailDescription'];
    defaultAvatar = json['defaultAvatar'];
    backgroundImgIdStr = json['backgroundImgIdStr'];
    avatarImgIdStr = json['avatarImgIdStr'];
    description = json['description'];
    userId = json['userId'];
    signature = json['signature'];
    authority = json['authority'];
    followeds = json['followeds'];
    follows = json['follows'];
    blacklist = json['blacklist'];
    eventCount = json['eventCount'];
    allSubscribedCount = json['allSubscribedCount'];
    playlistBeSubscribedCount = json['playlistBeSubscribedCount'];
    avatarImgIdStr = json['avatarImgId_str'];
    followTime = json['followTime'];
    followMe = json['followMe'];
    artistIdentity = List.castFrom<dynamic, dynamic>(json['artistIdentity']);
    cCount = json['cCount'];
    inBlacklist = json['inBlacklist'];
    sDJPCount = json['sDJPCount'];
    playlistCount = json['playlistCount'];
    sCount = json['sCount'];
    newFollows = json['newFollows'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['privacyItemUnlimit'] = privacyItemUnlimit?.toJson();
    data['avatarDetail'] = avatarDetail;
    data['birthday'] = birthday;
    data['nickname'] = nickname;
    data['avatarUrl'] = avatarUrl;
    data['backgroundImgId'] = backgroundImgId;
    data['backgroundUrl'] = backgroundUrl;
    data['userType'] = userType;
    data['avatarImgId'] = avatarImgId;
    data['province'] = province;
    data['city'] = city;
    data['gender'] = gender;
    data['followed'] = followed;
    data['mutual'] = mutual;
    data['authStatus'] = authStatus;
    data['expertTags'] = expertTags;
    data['experts'] = experts?.toJson();
    data['remarkName'] = remarkName;
    data['createTime'] = createTime;
    data['accountStatus'] = accountStatus;
    data['djStatus'] = djStatus;
    data['vipType'] = vipType;
    data['detailDescription'] = detailDescription;
    data['defaultAvatar'] = defaultAvatar;
    data['backgroundImgIdStr'] = backgroundImgIdStr;
    data['avatarImgIdStr'] = avatarImgIdStr;
    data['description'] = description;
    data['userId'] = userId;
    data['signature'] = signature;
    data['authority'] = authority;
    data['followeds'] = followeds;
    data['follows'] = follows;
    data['blacklist'] = blacklist;
    data['eventCount'] = eventCount;
    data['allSubscribedCount'] = allSubscribedCount;
    data['playlistBeSubscribedCount'] = playlistBeSubscribedCount;
    data['avatarImgId_str'] = avatarImgIdStr;
    data['followTime'] = followTime;
    data['followMe'] = followMe;
    data['artistIdentity'] = artistIdentity;
    data['cCount'] = cCount;
    data['inBlacklist'] = inBlacklist;
    data['sDJPCount'] = sDJPCount;
    data['playlistCount'] = playlistCount;
    data['sCount'] = sCount;
    data['newFollows'] = newFollows;
    return data;
  }
}

class PrivacyItemUnlimit {
  PrivacyItemUnlimit({
    this.area,
    this.college,
    this.gender,
    this.age,
    this.villageAge,
  });
  bool? area;
  bool? college;
  bool? gender;
  bool? age;
  bool? villageAge;
  
  PrivacyItemUnlimit.fromJson(Map<String, dynamic> json){
    area = json['area'];
    college = json['college'];
    gender = json['gender'];
    age = json['age'];
    villageAge = json['villageAge'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['area'] = area;
    data['college'] = college;
    data['gender'] = gender;
    data['age'] = age;
    data['villageAge'] = villageAge;
    return data;
  }
}

class Experts {
  Experts();
  
  Experts.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    return data;
  }
}

class Bindings {
  Bindings({
    this.expiresIn,
    this.refreshTime,
    this.bindingTime,
    this.tokenJsonStr,
    this.url,
    this.expired,
    this.userId,
    this.id,
    this.type,
  });
  int? expiresIn;
  int? refreshTime;
  int? bindingTime;
  String? tokenJsonStr;
  String? url;
  bool? expired;
  int? userId;
  int? id;
  int? type;
  
  Bindings.fromJson(Map<String, dynamic> json){
    expiresIn = json['expiresIn'];
    refreshTime = json['refreshTime'];
    bindingTime = json['bindingTime'];
    tokenJsonStr = json['tokenJsonStr'];
    url = json['url'];
    expired = json['expired'];
    userId = json['userId'];
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['expiresIn'] = expiresIn;
    data['refreshTime'] = refreshTime;
    data['bindingTime'] = bindingTime;
    data['tokenJsonStr'] = tokenJsonStr;
    data['url'] = url;
    data['expired'] = expired;
    data['userId'] = userId;
    data['id'] = id;
    data['type'] = type;
    return data;
  }
}

class ProfileVillageInfo {
  ProfileVillageInfo({
    this.title,
    this.imageUrl,
    this.targetUrl,
  });
  String? title;
  String? imageUrl;
  String? targetUrl;
  
  ProfileVillageInfo.fromJson(Map<String, dynamic> json){
    title = json['title'];
    imageUrl = json['imageUrl'];
    targetUrl = json['targetUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['imageUrl'] = imageUrl;
    data['targetUrl'] = targetUrl;
    return data;
  }
}