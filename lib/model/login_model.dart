class UserInfo {
  UserInfo({
   this.loginType,
   this.code,
   this.account,
   this.token,
   this.profile,
   this.bindings,
   this.cookie,
  });
 int? loginType;
 int? code;
 Account? account;
 String? token;
 Profile? profile;
 List<Bindings>? bindings;
 String? cookie;
  
  UserInfo.fromJson(Map<String, dynamic> json){
    loginType = json['loginType'];
    code = json['code'];
    account = Account.fromJson(json['account']);
    token = json['token'];
    profile = Profile.fromJson(json['profile']);
    bindings = List.from(json['bindings']).map((e)=>Bindings.fromJson(e)).toList();
    cookie = json['cookie'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['loginType'] = loginType;
    data['code'] = code;
    data['account'] = account?.toJson();
    data['token'] = token;
    data['profile'] = profile?.toJson();
    data['bindings'] = bindings?.map((e)=>e.toJson()).toList();
    data['cookie'] = cookie;
    return data;
  }
}

class Account {
  Account({
    this.id,
    this.userName,
    this.type,
    this.status,
    this.whitelistAuthority,
    this.createTime,
    this.salt,
    this.tokenVersion,
    this.ban,
    this.baoyueVersion,
    this.donateVersion,
    this.vipType,
    this.viptypeVersion,
    this.anonimousUser,
    this.uninitialized,
  });
  int? id;
  String? userName;
  int? type;
  int? status;
  int? whitelistAuthority;
  int? createTime;
  String? salt;
  int? tokenVersion;
  int? ban;
  int? baoyueVersion;
  int? donateVersion;
  int? vipType;
  int? viptypeVersion;
  bool? anonimousUser;
  bool? uninitialized;
  
  Account.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userName = json['userName'];
    type = json['type'];
    status = json['status'];
    whitelistAuthority = json['whitelistAuthority'];
    createTime = json['createTime'];
    salt = json['salt'];
    tokenVersion = json['tokenVersion'];
    ban = json['ban'];
    baoyueVersion = json['baoyueVersion'];
    donateVersion = json['donateVersion'];
    vipType = json['vipType'];
    viptypeVersion = json['viptypeVersion'];
    anonimousUser = json['anonimousUser'];
    uninitialized = json['uninitialized'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['type'] = type;
    data['status'] = status;
    data['whitelistAuthority'] = whitelistAuthority;
    data['createTime'] = createTime;
    data['salt'] = salt;
    data['tokenVersion'] = tokenVersion;
    data['ban'] = ban;
    data['baoyueVersion'] = baoyueVersion;
    data['donateVersion'] = donateVersion;
    data['vipType'] = vipType;
    data['viptypeVersion'] = viptypeVersion;
    data['anonimousUser'] = anonimousUser;
    data['uninitialized'] = uninitialized;
    return data;
  }
}

class Profile {
  Profile({
    this.backgroundImgIdStr,
    this.avatarImgIdStr,
    this.defaultAvatar,
    this.avatarUrl,
    this.vipType,
    this.authStatus,
    this.djStatus,
    this.detailDescription,
    this.experts,
    this.expertTags,
    this.accountStatus,
    this.nickname,
    this.birthday,
    this.gender,
    this.province,
    this.city,
    this.avatarImgId,
    this.backgroundImgId,
    this.followed,
    this.backgroundUrl,
    this.mutual,
    this.remarkName,
    this.userType,
    this.description,
    this.userId,
    this.signature,
    this.authority,
    this.followeds,
    this.follows,
    this.eventCount,
    tarDetail,
    this.playlistCount,
    this.playlistBeSubscribedCount,
  });
 String? backgroundImgIdStr;
 String? avatarImgIdStr;
 bool? defaultAvatar;
 String? avatarUrl;
 int? vipType;
 int? authStatus;
 int? djStatus;
 String? detailDescription;
 Experts? experts;
 String? expertTags;
 int? accountStatus;
 String? nickname;
 int? birthday;
 int? gender;
 int? province;
 int? city;
 int? avatarImgId;
 int? backgroundImgId;
 bool? followed;
 String? backgroundUrl;
 bool? mutual;
 String? remarkName;
 int? userType;
 String? description;
 int? userId;
 String? signature;
 int? authority;
 int? followeds;
 int? follows;
 int? eventCount;
 String? avatarDetail;
 int? playlistCount;
 int? playlistBeSubscribedCount;
  
  Profile.fromJson(Map<String, dynamic> json){
    backgroundImgIdStr = json['backgroundImgIdStr'];
    avatarImgIdStr = json['avatarImgIdStr'];
    defaultAvatar = json['defaultAvatar'];
    avatarUrl = json['avatarUrl'];
    vipType = json['vipType'];
    authStatus = json['authStatus'];
    djStatus = json['djStatus'];
    detailDescription = json['detailDescription'];
    experts = Experts.fromJson(json['experts']);
    expertTags = json['expertTags'];
    accountStatus = json['accountStatus'];
    nickname = json['nickname'];
    birthday = json['birthday'];
    gender = json['gender'];
    province = json['province'];
    city = json['city'];
    avatarImgId = json['avatarImgId'];
    backgroundImgId = json['backgroundImgId'];
    followed = json['followed'];
    backgroundUrl = json['backgroundUrl'];
    mutual = json['mutual'];
    remarkName = json['remarkName'];
    userType = json['userType'];
    description = json['description'];
    userId = json['userId'];
    signature = json['signature'];
    authority = json['authority'];
    avatarImgIdStr = json['avatarImgId_str'];
    followeds = json['followeds'];
    follows = json['follows'];
    eventCount = json['eventCount'];
    avatarDetail = json['avatarDetail'];
    playlistCount = json['playlistCount'];
    playlistBeSubscribedCount = json['playlistBeSubscribedCount'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['backgroundImgIdStr'] = backgroundImgIdStr;
    data['avatarImgIdStr'] = avatarImgIdStr;
    data['defaultAvatar'] = defaultAvatar;
    data['avatarUrl'] = avatarUrl;
    data['vipType'] = vipType;
    data['authStatus'] = authStatus;
    data['djStatus'] = djStatus;
    data['detailDescription'] = detailDescription;
    data['experts'] = experts?.toJson();
    data['expertTags'] = expertTags;
    data['accountStatus'] = accountStatus;
    data['nickname'] = nickname;
    data['birthday'] = birthday;
    data['gender'] = gender;
    data['province'] = province;
    data['city'] = city;
    data['avatarImgId'] = avatarImgId;
    data['backgroundImgId'] = backgroundImgId;
    data['followed'] = followed;
    data['backgroundUrl'] = backgroundUrl;
    data['mutual'] = mutual;
    data['remarkName'] = remarkName;
    data['userType'] = userType;
    data['description'] = description;
    data['userId'] = userId;
    data['signature'] = signature;
    data['authority'] = authority;
    data['avatarImgId_str'] = avatarImgIdStr;
    data['followeds'] = followeds;
    data['follows'] = follows;
    data['eventCount'] = eventCount;
    data['avatarDetail'] = avatarDetail;
    data['playlistCount'] = playlistCount;
    data['playlistBeSubscribedCount'] = playlistBeSubscribedCount;
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
    this.tokenJsonStr,
    this.bindingTime,
    this.refreshTime,
    this.expiresIn,
    this.url,
    this.expired,
    this.userId,
    this.id,
    this.type,
  });
  String? tokenJsonStr;
  int? bindingTime;
  int? refreshTime;
  int? expiresIn;
  String? url;
  bool? expired;
  int? userId;
  int? id;
  int? type;
  
  Bindings.fromJson(Map<String, dynamic> json){
    tokenJsonStr = json['tokenJsonStr'];
    bindingTime = json['bindingTime'];
    refreshTime = json['refreshTime'];
    expiresIn = json['expiresIn'];
    url = json['url'];
    expired = json['expired'];
    userId = json['userId'];
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tokenJsonStr'] = tokenJsonStr;
    data['bindingTime'] = bindingTime;
    data['refreshTime'] = refreshTime;
    data['expiresIn'] = expiresIn;
    data['url'] = url;
    data['expired'] = expired;
    data['userId'] = userId;
    data['id'] = id;
    data['type'] = type;
    return data;
  }
}